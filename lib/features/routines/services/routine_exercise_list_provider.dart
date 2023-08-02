import 'package:fitsaw/features/routines/domain/routine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListNotifier
    extends Notifier<List<RoutineExerciseWrapper>> {
  @override
  List<RoutineExerciseWrapper> build() {
    return [];
  }

  void set(List<RoutineExerciseWrapper> exercises) {
    state = [...exercises];
  }

  void add(RoutineExerciseWrapper exercise) {
    state = [...state, exercise];
  }

  void remove(RoutineExerciseWrapper exercise) {
    state.remove(exercise);
    state = [...state];
  }

  void clear() {
    state = [];
  }
}

final routineExerciseListProvider =
    NotifierProvider<RoutineExerciseListNotifier, List<RoutineExerciseWrapper>>(
        () => RoutineExerciseListNotifier());
