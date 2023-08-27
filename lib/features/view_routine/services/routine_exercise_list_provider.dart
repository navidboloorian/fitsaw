import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListNotifier extends Notifier<List<Map<String, dynamic>>> {
  @override
  List<Map<String, dynamic>> build() {
    return [];
  }

  Map<String, dynamic> removeAt(int index) {
    Map<String, dynamic> routineExercise = state.removeAt(index);
    set(state);

    return routineExercise;
  }

  void disposeControllers(Map<String, dynamic> routineExercise) {
    routineExercise.forEach((key, value) {
      if (value is TextEditingController) {
        value.dispose();
      }
    });
  }

  void insert(int index, Map<String, dynamic> routineExercise) {
    state.insert(index, routineExercise);
    set(state);
  }

  void set(List<Map<String, dynamic>> routineExercises) {
    state = [...routineExercises];
  }

  void add(Map<String, dynamic> routineExercise) {
    state = [...state, routineExercise];
  }

  void remove(Map<String, dynamic> routineExercise) {
    state.remove(routineExercise);
    set(state);
  }

  void clear() {
    for (Map<String, dynamic> routineExercise in state) {
      routineExercise.forEach((key, value) {
        if (value != null && value is TextEditingController) {
          value.dispose();
        }
      });
    }

    state = [];
  }
}

final routineExerciseListProvider =
    NotifierProvider<RoutineExerciseListNotifier, List<Map<String, dynamic>>>(
        () => RoutineExerciseListNotifier());
