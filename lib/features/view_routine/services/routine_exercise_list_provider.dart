import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListNotifier
    extends Notifier<List<RoutineExerciseController>> {
  @override
  List<RoutineExerciseController> build() {
    return [];
  }

  RoutineExerciseController removeAt(int index) {
    RoutineExerciseController routineExercise = state.removeAt(index);

    set(state);

    return routineExercise;
  }

  void insert(int index, RoutineExerciseController routineExercise) {
    state.insert(index, routineExercise);
    set(state);
  }

  void set(List<RoutineExerciseController> routineExercises) {
    state = [...routineExercises];
  }

  void add(RoutineExerciseController routineExercise) {
    state = [...state, routineExercise];
  }

  void remove(RoutineExerciseController routineExercise) {
    state.remove(routineExercise);
    set(state);
  }

  void clear() {
    for (RoutineExerciseController routineExercise in state) {
      routineExercise.dispose();
    }

    state = [];
  }
}

final routineExerciseListProvider = NotifierProvider<
    RoutineExerciseListNotifier,
    List<RoutineExerciseController>>(() => RoutineExerciseListNotifier());
