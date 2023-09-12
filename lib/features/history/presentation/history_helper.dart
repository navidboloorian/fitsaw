import 'package:fitsaw/features/history/domain/history.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';

class HistoryHelper {
  static HistoryRoutine routineToHistory(Routine routine) {
    List<RoutineExerciseWrapper> exercises = [];

    for (RoutineExerciseWrapper exerciseWrapper in routine.exercises) {
      RoutineExerciseWrapper historyExerciseWrapper = RoutineExerciseWrapper(
        historyExercise: HistoryExercise(
          exerciseWrapper.exercise!.name,
          exerciseWrapper.exercise!.isTimed,
          exerciseWrapper.exercise!.isWeighted,
          description: exerciseWrapper.exercise!.description,
          tags: exerciseWrapper.exercise!.tags,
        ),
        sets: exerciseWrapper.sets,
        rest: exerciseWrapper.rest,
        reps: exerciseWrapper.reps,
        times: exerciseWrapper.times,
        weights: exerciseWrapper.weights,
        exercise: exerciseWrapper.exercise,
      );

      exercises.add(historyExerciseWrapper);
    }

    HistoryRoutine historyRoutine = HistoryRoutine(routine.name,
        description: routine.description,
        tags: routine.tags,
        exercises: exercises);

    return historyRoutine;
  }
}
