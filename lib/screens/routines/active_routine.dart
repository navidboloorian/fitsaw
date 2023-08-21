import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveRoutine extends ConsumerWidget {
  const ActiveRoutine({super.key});

  void _goToNextExercise(WidgetRef ref) {
    if (ref.read(currentExerciseIndexProvider) !=
        ref.read(activeExerciseListProvider).length - 1) {
      ref.read(currentExerciseIndexProvider.notifier).state++;
    } else {
      ref.read(isRoutineCompletedProvider.notifier).state = true;
    }
  }

  Future<bool> _goToPreviousExercise(
      BuildContext context, WidgetRef ref) async {
    if (ref.read(currentExerciseIndexProvider) != 0) {
      // go to previous exercise if it's not the first exercise in the routine
      ref.read(currentExerciseIndexProvider.notifier).state--;
      return false;
    } else {
      // pop navigator if it's the first exercise in the routine
      return true;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      // intercept back button
      onWillPop: () => _goToPreviousExercise(context, ref),
      child: Scaffold(
        appBar: CustomAppBar(
          leading: BackArrowButton(() => Navigator.pop(context)),
        ),
        body: ref.watch(isRoutineCompletedProvider)
            ? Column(
                children: [
                  const Expanded(child: CompletedRoutine()),
                  BottomButton(
                    text: 'Finish',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              )
            : Column(
                children: [
                  const Expanded(child: CurrentExercise()),
                  BottomButton(
                    text: 'Next',
                    onTap: () => _goToNextExercise(ref),
                  )
                ],
              ),
      ),
    );
  }
}
