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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ref.watch(isRoutineCompletedProvider)
          ? Column(
              children: [
                const Expanded(child: CompletedRoutine()),
                BottomButton(
                    text: 'Finish', onTap: () => Navigator.pop(context)),
              ],
            )
          : Column(
              children: [
                const Expanded(child: CurrentExercise()),
                BottomButton(text: 'Next', onTap: () => _goToNextExercise(ref))
              ],
            ),
    );
  }
}
