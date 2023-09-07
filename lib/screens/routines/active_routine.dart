import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveRoutine extends ConsumerWidget {
  const ActiveRoutine({super.key});

  Future<bool> _onWillPop(WidgetRef ref) async {
    int currentSet = ref.watch(currentSetProvider);
    int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
    bool isResting = ref.watch(isRestProvider);
    bool isFirstExercise = currentExerciseIndex == 0 && currentSet == 0;

    ref.read(isRestProvider.notifier).state = false;

    if (isResting) {
      ref.read(isRestProvider.notifier).state = false;
      return false;
    } else {
      if (isFirstExercise) {
        return true;
      } else {
        if (currentSet > 0) {
          ref.read(currentSetProvider.notifier).state--;
        } else {
          ref.read(currentExerciseIndexProvider.notifier).state--;
        }

        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      // intercept back button
      onWillPop: () => _onWillPop(ref),
      child: Scaffold(
        appBar: CustomAppBar(
          leading: BackArrowButton(() => Navigator.pop(context)),
        ),
        body: ref.watch(isRoutineCompletedProvider)
            ? const CompletedRoutine()
            : ref.watch(isRestProvider)
                ? const Rest()
                : const CurrentExercise(),
      ),
    );
  }
}
