import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

final activeExerciseListProvider = Provider<List<RoutineExerciseWrapper>>(
  (ref) {
    List<RoutineExerciseWrapper> exerciseList = [];

    final routine = ref.watch(activeRoutineProvider);

    // Goes through list of exercises in routine.
    for (int i = 0; i < routine!.exercises.length; i++) {
      final exercise = routine.exercises[i];

      // Creates a new exercise for each set.
      for (int j = 0; j < exercise.sets!; j++) {
        exerciseList.add(
          RoutineExerciseWrapper(
            exercise: exercise.exercise,
            reps: exercise.reps,
            times: [],
            weights: [],
          ),
        );

        // Create a rest "exercise" if the exercise has rest initialized.
        if (exercise.rest! > 0) {
          exerciseList.add(
            RoutineExerciseWrapper(
              exercise: Exercise(ObjectId(), 'Rest', true, false),
              times: [],
            ),
          );
        }
      }
    }

    return exerciseList;
  },
);
