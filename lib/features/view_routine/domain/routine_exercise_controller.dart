import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:flutter/material.dart';

class RoutineExerciseController {
  final Exercise exercise;
  late final TextEditingController restController;
  late final TextEditingController setController;
  late final TextEditingController weightController;
  late final TextEditingController timeController;
  late final TextEditingController repController;

  RoutineExerciseController(this.exercise) {
    restController = TextEditingController();
    setController = TextEditingController();
    weightController = TextEditingController();
    timeController = TextEditingController();
    repController = TextEditingController();
  }

  void dispose() {
    restController.dispose();
    setController.dispose();
    weightController.dispose();
    timeController.dispose();
    repController.dispose();
  }
}
