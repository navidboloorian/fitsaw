import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Rest extends ConsumerWidget {
  const Rest({super.key});

  List<Widget> _pageElements(WidgetRef ref) {
    List<Widget> list = [];
    RoutineExerciseWrapper? currentExerciseWrapper =
        ref.watch(currentExerciseProvider);

    list.add(
      const CustomContainer(
        child: Text('Rest'),
      ),
    );

    list.add(
      CustomContainer(
        child: CountdownTimer(duration: currentExerciseWrapper!.rest!),
      ),
    );

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

    return list;
  }

  void _goToNextExercise(WidgetRef ref) {
    int currentSet = ref.watch(currentSetProvider);
    int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
    RoutineExerciseWrapper? currentExerciseWrapper =
        ref.watch(currentExerciseProvider);

    if (currentSet < currentExerciseWrapper!.sets! - 1) {
      ref.read(currentSetProvider.notifier).state++;
    } else if (currentExerciseIndex <
        ref.watch(activeRoutineProvider)!.exercises.length - 1) {
      ref.read(currentSetProvider.notifier).state = 0;
      ref.read(currentExerciseIndexProvider.notifier).state++;
    } else {
      ref.read(isRoutineCompletedProvider.notifier).state = true;
    }

    ref.read(isRestProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: _pageElements(ref)),
        ),
        BottomButton(
          text: 'Next',
          onTap: () => _goToNextExercise(ref),
        ),
      ],
    );
  }
}
