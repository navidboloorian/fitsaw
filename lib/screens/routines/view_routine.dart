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
    ref.read(routineExerciseListProvider.notifier).clear();
  }

  List<RoutineExerciseWrapper> _generateRoutineExerciseList() {
    List<RoutineExerciseWrapper> list = [];

    for (RoutineExerciseController routineExercise
        in ref.read(routineExerciseListProvider)) {
      int? reps;
      int? time;
      int? weight;

      if (routineExercise.setController.text.isEmpty) {
        routineExercise.setController.text = '1';
      }

      if (routineExercise.exercise.isTimed) {
        if (routineExercise.timeController.text == '00:00') {
          routineExercise.timeController.text = '00:01';
        }

        time =
            TimeInputValidator.toSeconds(routineExercise.timeController.text);
      } else {
        if (routineExercise.repController.text.isEmpty) {
          routineExercise.repController.text = '1';
        }

        reps = int.parse(routineExercise.repController.text);
      }

      if (routineExercise.exercise.isWeighted) {
        if (routineExercise.weightController.text.isEmpty) {
          routineExercise.weightController.text = '1';
        }

        weight = int.parse(routineExercise.weightController.text);
      }

      list.add(
        RoutineExerciseWrapper(
          exercise: routineExercise.exercise,
          sets: int.parse(routineExercise.setController.text),
          reps: reps,
          time: time,
          weight: weight,
          rest:
              TimeInputValidator.toSeconds(routineExercise.restController.text),
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

  void _upsertRoutine(bool showSnackbar) {
    if (!_formHasErrors()) {
      ObjectId id = widget.isNew ? ObjectId() : widget.routine!.id;
      String name = _nameController.text;
      String description = _descriptionController.text;
      List<String> tags = ref.read(tagTextFieldListFamily('routine'));
      List<RoutineExerciseWrapper> exercises = _generateRoutineExerciseList();

      ref.read(routineListProvider).upsert(
            Routine(
              id,
              name,
              description: description,
              tags: tags,
              exercises: exercises,
            ),
          );

      String snackbarMessage =
          widget.isNew ? 'Routine created!' : 'Routine updated!';

      Navigator.pop(context);

      _resetProviders();

      showSnackbar
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Palette.fitsawGreen,
                duration: const Duration(milliseconds: 500),
                content: Text(
                  snackbarMessage,
                  style: const TextStyle(color: Palette.darkText),
                ),
              ),
            )
          : null;
    }
  }

  List<RoutineExerciseController> _parseExistingExercises() {
    List<RoutineExerciseController> list = [];

    for (RoutineExerciseWrapper routineExercise in widget.routine!.exercises) {
      RoutineExerciseController routineExerciseController =
          RoutineExerciseController(routineExercise.exercise!);

      routineExerciseController.restController.text =
          TimeInputValidator.toTime(routineExercise.rest!);

      routineExerciseController.setController.text =
          routineExercise.sets!.toString();

      if (routineExerciseController.exercise.isTimed) {
        routineExerciseController.timeController.text =
            TimeInputValidator.toTime(routineExercise.time!);
      } else {
        routineExerciseController.repController.text =
            routineExercise.reps!.toString();
      }

      if (routineExerciseController.exercise.isWeighted) {
        routineExerciseController.weightController.text =
            routineExercise.weight!.toString();
      }

      list.add(routineExerciseController);
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
      _upsertRoutine(false);

      ref.read(activeRoutineProvider.notifier).set(widget.routine!);
      ref.read(currentExerciseIndexProvider.notifier).state = 0;
      ref.read(isRoutineCompletedProvider.notifier).state = false;

      Navigator.pushNamed(
        context,
        'active_routine',
        arguments: PageArguments(routine: widget.routine),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew) {
      _populateForm();
    }
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
            widget.isNew
                ? const SizedBox.shrink()
                : BottomButton(text: 'Start', onTap: _startRoutine),
          ],
        ),
      ),
    );
  }
}
