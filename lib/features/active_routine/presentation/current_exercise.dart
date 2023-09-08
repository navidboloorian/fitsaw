import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentExercise extends ConsumerWidget {
  const CurrentExercise({super.key});

  CustomContainer _repExerciseDetails(
      RoutineExerciseWrapper exerciseWrapper, int set) {
    List<Widget> children = [];

    exerciseWrapper.reps[set] > 1
        ? children.add(
            Text(
              '${exerciseWrapper.reps[set]} reps',
              style: const TextStyle(fontSize: 30),
            ),
          )
        : children.add(
            Text(
              '${exerciseWrapper.reps[set]} rep',
              style: const TextStyle(fontSize: 30),
            ),
          );

    if (exerciseWrapper.exercise!.isWeighted) {
      children.add(
        Text(
          '${exerciseWrapper.weights[set]} lbs',
          style: const TextStyle(fontSize: 30),
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

  List<Widget> _pageElements(WidgetRef ref) {
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
              duration: currentExerciseWrapper.times[currentSet]),
        ),
      );

      if (currentExerciseWrapper.exercise!.isWeighted) {
        list.add(
          CustomContainer(
            child: Center(
              child: Text(
                '${currentExerciseWrapper.weights[currentSet]} lbs',
                style: const TextStyle(fontSize: 30),
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

  void _goToNextExercise(WidgetRef ref) {
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: ListView(children: _pageElements(ref)),
        ),
        BottomButton(
          text: isLastExercise ? 'Finish' : 'Next',
          onTap: () => _goToNextExercise(ref),
        ),
      ],
    );
  }
}
