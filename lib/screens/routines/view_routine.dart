import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/services/services.dart';
import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:fitsaw/features/view_routine/presentation/presentation.dart';
import 'package:fitsaw/features/view_routine/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class ViewRoutine extends ConsumerStatefulWidget {
  final bool isNew;
  final Routine? routine;

  const ViewRoutine({
    super.key,
    required this.isNew,
    this.routine,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends ConsumerState<ViewRoutine> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _resetProviders() {
    ref.read(tagTextFieldListFamily('routine').notifier).clear();

    for (RoutineExerciseController routineExerciseController
        in ref.read(routineExerciseListProvider)) {
      routineExerciseController.delete();
    }

    ref.read(routineExerciseListProvider.notifier).clear();
  }

  List<RoutineExerciseWrapper> _generateRoutineExerciseList() {
    List<RoutineExerciseWrapper> list = [];

    for (RoutineExerciseController routineExerciseController
        in ref.read(routineExerciseListProvider)) {
      List<int> reps = [];
      List<int> times = [];
      List<int> weights = [];

      if (routineExerciseController.setController.text.isEmpty) {
        routineExerciseController.setController.text = '1';
      }

      if (routineExerciseController.exercise.isTimed) {
        for (TextEditingController controller
            in routineExerciseController.timeControllers) {
          if (controller.text == '00:00') {
            controller.text = '00:01';
          }

          TimeInputValidator.validate(controller);

          int time = TimeInputValidator.toSeconds(controller.text);

          times.add(time);
        }

        // This case will be a true if a set count has been increased but the
        // field was not unfocused.
        if (times.length <
            int.parse(routineExerciseController.setController.text)) {
          routineExerciseController.setController.text =
              times.length.toString();
        }
      } else {
        for (TextEditingController controller
            in routineExerciseController.repControllers) {
          if (controller.text.isEmpty) {
            controller.text = '1';
          }

          int repCount = int.parse(controller.text);

          reps.add(repCount);
        }

        if (times.length <
            int.parse(routineExerciseController.setController.text)) {
          routineExerciseController.setController.text = reps.length.toString();
        }
      }

      if (routineExerciseController.exercise.isWeighted) {
        for (TextEditingController controller
            in routineExerciseController.weightControllers) {
          if (controller.text.isEmpty) {
            controller.text = '1';
          }

          int weightCount = int.parse(controller.text);

          weights.add(weightCount);
        }
      }

      TimeInputValidator.validate(routineExerciseController.restController);

      list.add(
        RoutineExerciseWrapper(
          exercise: routineExerciseController.exercise,
          sets: int.parse(routineExerciseController.setController.text),
          reps: reps,
          times: times,
          weights: weights,
          rest: TimeInputValidator.toSeconds(
            routineExerciseController.restController.text,
          ),
        ),
      );
    }

    return list;
  }

  bool _formHasErrors() {
    if (ref.read(routineExerciseListProvider).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Palette.fitsawRed,
          duration: Duration(milliseconds: 500),
          content: Text(
            'A routine must have at least one exercise.',
            style: TextStyle(color: Palette.darkText),
          ),
        ),
      );

      return true;
    } else if (!_formKey.currentState!.validate()) {
      return true;
    }

    return false;
  }

  Routine? _upsertRoutine(bool showSnackbar) {
    if (!_formHasErrors()) {
      ObjectId id = widget.isNew ? ObjectId() : widget.routine!.id;
      String name = _nameController.text;
      String description = _descriptionController.text;
      List<String> tags = ref.read(tagTextFieldListFamily('routine'));
      List<RoutineExerciseWrapper> exercises = _generateRoutineExerciseList();
      Routine routine = Routine(
        id,
        name,
        description: description,
        tags: tags,
        exercises: exercises,
      );

      ref.read(routineListProvider).upsert(routine);

      String snackbarMessage =
          widget.isNew ? 'Routine created!' : 'Routine updated!';

      if (showSnackbar) {
        Navigator.pop(context);
        _resetProviders();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Palette.fitsawGreen,
            duration: const Duration(milliseconds: 500),
            content: Text(
              snackbarMessage,
              style: const TextStyle(color: Palette.darkText),
            ),
          ),
        );
      }

      return routine;
    }

    return null;
  }

  List<RoutineExerciseController> _parseExistingExercises() {
    List<RoutineExerciseController> list = [];

    for (RoutineExerciseWrapper routineExercise in widget.routine!.exercises) {
      try {
        RoutineExerciseController routineExerciseController =
            RoutineExerciseController(routineExercise.exercise!);

        routineExerciseController.restController.text =
            TimeInputValidator.toTime(routineExercise.rest!);

        routineExerciseController.setController.text =
            routineExercise.sets!.toString();

        for (int i = 0; i < routineExercise.sets!; i++) {
          routineExerciseController.add();

          if (routineExerciseController.exercise.isTimed) {
            int time = routineExercise.times[i];

            routineExerciseController.timeControllers[i].text =
                TimeInputValidator.toTime(time);
          } else {
            int reps = routineExercise.reps[i];

            routineExerciseController.repControllers[i].text = reps.toString();
          }

          if (routineExerciseController.exercise.isWeighted) {
            int weight = routineExercise.weights[i];

            routineExerciseController.weightControllers[i].text =
                weight.toString();
          }
        }

        list.add(routineExerciseController);
      } catch (error) {
        // The exercise has been deleted and we're using "!" on a null variable.
        // We don't need to handle the error as the exercise has not been added
        // to the list.
      }
    }

    return list;
  }

  void _populateForm() {
    _nameController.text = widget.routine!.name;

    if (widget.routine!.description != null) {
      _descriptionController.text = widget.routine!.description!;
    }

    // Uses "Future" to avoid provider being updated before widget is built out.
    Future(() {
      ref
          .read(tagTextFieldListFamily('routine').notifier)
          .set(widget.routine!.tags);
      ref
          .read(routineExerciseListProvider.notifier)
          .set(_parseExistingExercises());
    });
  }

  /// Clear form/reset providers if user uses the back button.
  Future<bool> _onWillPop() async {
    _resetProviders();

    return true;
  }

  void _startRoutine() {
    // Ensure that changes that have made to the routine are maintained for
    // when the the routine is started.
    if (!_formHasErrors()) {
      Routine? routine = _upsertRoutine(false);

      ref.read(activeRoutineProvider.notifier).set(routine!);
      ref.read(currentExerciseIndexProvider.notifier).state = 0;
      ref.read(currentSetProvider.notifier).state = 0;
      ref.read(isRoutineCompletedProvider.notifier).state = false;
      ref.read(isRestProvider.notifier).state = false;
      ref.read(totalTimeProvider.notifier).start();

      Navigator.pushNamed(
        context,
        'active_routine',
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew) {
      _populateForm();
    }

    Future(() {
      ref.read(activeRoutineProvider.notifier).set(null);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [CheckButton(() => _upsertRoutine(true))],
        ),
        body: Column(
          children: [
            Expanded(
              child: ViewRoutineForm(
                formKey: _formKey,
                nameController: _nameController,
                descriptionController: _descriptionController,
              ),
            ),
            widget.isNew || ref.watch(routineExerciseListProvider).isEmpty
                ? const SizedBox.shrink()
                : BottomButton(text: 'Start', onTap: _startRoutine),
          ],
        ),
      ),
    );
  }
}
