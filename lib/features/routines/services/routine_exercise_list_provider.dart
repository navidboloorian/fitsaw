import 'package:fitsaw/features/routines/domain/routine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListNotifier extends Notifier<List<Map<String, dynamic>>> {
  @override
  List<Map<String, dynamic>> build() {
    return [];
  }

  void set(List<Map<String, dynamic>> routineExercises) {
    state = [...routineExercises];
  }

  void add(Map<String, dynamic> routineExercise) {
    state = [...state, routineExercise];
  }

  void remove(Map<String, dynamic> routineExercise) {
    state.remove(routineExercise);
    state = [...state];
  }

  void clear() {
    state = [];
  }
}

final routineExerciseListProvider =
    NotifierProvider<RoutineExerciseListNotifier, List<Map<String, dynamic>>>(
        () => RoutineExerciseListNotifier());
