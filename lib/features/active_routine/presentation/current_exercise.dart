import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/settings/services/services.dart';
import 'package:fitsaw/features/view_routine/presentation/number_text_field.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentExercise extends ConsumerStatefulWidget {
  const CurrentExercise({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CurrentExerciseState();
}

class _CurrentExerciseState extends ConsumerState<CurrentExercise> {
  TextEditingController? _repController;
  TextEditingController? _weightController;
  int? _repValue;
  int? _weightValue;
  late final String _weightUnit;

  @override
  void initState() {
    super.initState();

    _weightUnit = ref.read(settingsProvider).get().weightUnit;

    _setControllers();
  }

  void _setControllers() {
    int set = ref.read(currentSetProvider);
    RoutineExerciseWrapper currentExercise = ref.read(currentExerciseProvider)!;

    if (!currentExercise.exercise!.isTimed) {
      _repController =
          TextEditingController(text: currentExercise.reps[set].toString());

      _repValue = currentExercise.reps[set];
      _repController!.addListener(_setRepValue);
    } else {
      _repController = null;
      _repValue = null;
    }

    if (currentExercise.exercise!.isWeighted) {
      _weightController =
          TextEditingController(text: currentExercise.weights[set].toString());

      _weightValue = currentExercise.weights[set];
      _weightController!.addListener(_setWeightValue);
    } else {
      _weightController = null;
      _weightValue = null;
    }
  }

  void _setRepValue() {
    if (_repController!.text.isNotEmpty) {
      setState(() {
        _repValue = int.parse(_repController!.text);
      });
    }
  }

  void _setWeightValue() {
    if (_weightController!.text.isNotEmpty) {
      setState(() {
        _weightValue = int.parse(_weightController!.text);
      });
    }
  }

  void _updateExerciseStats() {
    int set = ref.read(currentSetProvider);
    RoutineExerciseWrapper currentExercise = ref.read(currentExerciseProvider)!;

    if (!currentExercise.exercise!.isTimed) {
      if (_repValue != currentExercise.reps[set]) {
        currentExercise.reps[set] = _repValue!;
      }
    }

    if (currentExercise.exercise!.isWeighted) {
      if (_weightValue != currentExercise.weights[set]) {
        currentExercise.weights[set] = _weightValue!;
      }
    }
  }

  CustomContainer _repExerciseDetails(
      RoutineExerciseWrapper exerciseWrapper, int set) {
    List<Widget> children = [];

    children.add(
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              // tweak these specific numbers
              width: _repValue.toString().length == 1 ? 40 : 50,
              child: NumberTextField(
                key: const ValueKey(0),
                controller: _repController!,
                lengthLimit: 2,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            _repValue! != 1
                ? const Text('reps', style: TextStyle(fontSize: 30))
                : const Text('rep', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );

    if (exerciseWrapper.exercise!.isWeighted) {
      children.add(
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                // tweak these specific numbers
                width: _weightValue.toString().length == 1
                    ? 40
                    : _weightValue.toString().length == 2
                        ? 50
                        : 60,
                child: NumberTextField(
                  key: const ValueKey(1),
                  controller: _weightController!,
                  lengthLimit: 3,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              _weightValue! != 1
                  ? Text(
                      '${_weightUnit}s',
                      style: const TextStyle(fontSize: 30),
                    )
                  : Text(_weightUnit, style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      );
    }

    return CustomContainer(
      child: Center(
        child: Column(
          children: children,
        ),
      ),
    );
  }

  List<Widget> _pageElements() {
    List<Widget> list = [];
    RoutineExerciseWrapper? currentExerciseWrapper =
        ref.watch(currentExerciseProvider);
    int currentSet = ref.watch(currentSetProvider);

    list.add(
      CustomContainer(
        child: Text(currentExerciseWrapper!.exercise!.name),
      ),
    );

    list.add(
      CustomContainer(
        child: Text(
          'Set ${currentSet + 1} of ${currentExerciseWrapper.sets}',
        ),
      ),
    );

    if (currentExerciseWrapper.exercise!.isTimed) {
      list.add(
        CustomContainer(
          child: CountdownTimer(
            set: ref.watch(currentSetProvider),
            exerciseIndex: ref.watch(currentExerciseIndexProvider),
            duration: currentExerciseWrapper.times[currentSet],
            setControllers: _setControllers,
          ),
        ),
      );

      if (currentExerciseWrapper.exercise!.isWeighted) {
        list.add(
          CustomContainer(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // tweak these specific numbers
                    width: _weightValue.toString().length == 1
                        ? 40
                        : _weightValue.toString().length == 2
                            ? 50
                            : 60,
                    child: NumberTextField(
                      key: const ValueKey(1),
                      controller: _weightController!,
                      lengthLimit: 3,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  _weightValue! != 1
                      ? Text('${_weightUnit}s',
                          style: const TextStyle(fontSize: 30))
                      : Text(_weightUnit, style: const TextStyle(fontSize: 30)),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      list.add(_repExerciseDetails(currentExerciseWrapper, currentSet));
    }

    int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
    bool isLastExercise = currentExerciseIndex ==
            ref.watch(activeRoutineProvider)!.exercises.length - 1 &&
        currentSet ==
            ref
                    .watch(activeRoutineProvider)!
                    .exercises[currentExerciseIndex]
                    .sets! -
                1;

    if (!isLastExercise) {
      if (currentExerciseWrapper.rest! > 0) {
        list.add(const CustomContainer(child: Text('Next: Rest')));
      } else {
        Exercise nextExercise;

        if (ref.read(currentSetProvider) == currentExerciseWrapper.sets! - 1) {
          nextExercise = ref
              .read(activeRoutineProvider)!
              .exercises[ref.read(currentExerciseIndexProvider) + 1]
              .exercise!;
        } else {
          nextExercise = currentExerciseWrapper.exercise!;
        }

        list.add(CustomContainer(child: Text('Next: ${nextExercise.name}')));
      }

      if (currentExerciseWrapper.exercise!.description != null) {
        list.add(
          CustomContainer(
            child: Text(currentExerciseWrapper.exercise!.description!),
          ),
        );
      }
    }

    return list;
  }

  void _goToNextExercise() {
    _updateExerciseStats();

    int currentSet = ref.watch(currentSetProvider);
    int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
    RoutineExerciseWrapper? currentExerciseWrapper =
        ref.watch(currentExerciseProvider);
    bool isLastExercise = currentExerciseIndex ==
            ref.watch(activeRoutineProvider)!.exercises.length - 1 &&
        currentSet ==
            ref
                    .watch(activeRoutineProvider)!
                    .exercises[currentExerciseIndex]
                    .sets! -
                1;

    if (currentExerciseWrapper!.rest! > 0 && !isLastExercise) {
      ref.read(isRestProvider.notifier).state = true;
    } else {
      if (currentSet < currentExerciseWrapper.sets! - 1) {
        ref.read(currentSetProvider.notifier).state++;
      } else if (currentExerciseIndex <
          ref.watch(activeRoutineProvider)!.exercises.length - 1) {
        ref.read(currentSetProvider.notifier).state = 0;
        ref.read(currentExerciseIndexProvider.notifier).state++;
      } else {
        ref.read(isRoutineCompletedProvider.notifier).state = true;
      }
    }

    _setControllers();
  }

  @override
  void dispose() {
    super.dispose();

    if (_repController != null) {
      _repController!.dispose();
    }

    if (_weightController != null) {
      _weightController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentSet = ref.watch(currentSetProvider);
    int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
    bool isLastExercise = currentExerciseIndex ==
            ref.watch(activeRoutineProvider)!.exercises.length - 1 &&
        currentSet ==
            ref
                    .watch(activeRoutineProvider)!
                    .exercises[currentExerciseIndex]
                    .sets! -
                1;

    return Column(
      children: [
        Expanded(
          child: ListView(children: _pageElements()),
        ),
        BottomButton(
          text: isLastExercise ? 'Finish' : 'Next',
          onTap: _goToNextExercise,
        ),
      ],
    );
  }
}
