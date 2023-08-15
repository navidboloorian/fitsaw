import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentExercise extends ConsumerWidget {
  const CurrentExercise({super.key});

  List<Widget> _exerciseFields(RoutineExerciseWrapper exerciseWrapper) {
    List<Widget> exerciseFields = [];

    exerciseFields
        .add(CustomContainer(child: Text(exerciseWrapper.exercise!.name)));

    if (exerciseWrapper.exercise!.isTimed) {
      exerciseFields.add(
        CustomContainer(
          child: CountdownTimer(
            duration: exerciseWrapper.time!,
          ),
        ),
      );
    } else {
      exerciseFields.add(
        CustomContainer(
          child: Column(
            children: [
              Text('${exerciseWrapper.reps} reps'),
              exerciseWrapper.exercise!.isWeighted
                  ? Text('${exerciseWrapper.weight} lbs')
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    }

    if (exerciseWrapper.exercise!.description != null) {
      exerciseFields.add(
          CustomContainer(child: Text(exerciseWrapper.exercise!.description!)));
    }

    return exerciseFields;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RoutineExerciseWrapper? exerciseWrapper =
        ref.watch(currentExerciseProvider);

    return ListView(children: _exerciseFields(exerciseWrapper!));
  }
}
