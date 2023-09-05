import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:flutter/material.dart';

class RoutineExerciseController {
  final Exercise exercise;
  late final TextEditingController restController;
  late final TextEditingController setController;
  late final List<TextEditingController> weightControllers;
  late final List<TextEditingController> timeControllers;
  late final List<TextEditingController> repControllers;

  RoutineExerciseController(this.exercise) {
    restController = TextEditingController();
    setController = TextEditingController();
    weightControllers = [];
    timeControllers = [];
    repControllers = [];
  }

  // Add controllers to the end of the list.
  void add() {
    timeControllers.add(TextEditingController());
    repControllers.add(TextEditingController());
    weightControllers.add(TextEditingController());
  }

  // Delete the last controller in the list.
  void delete() {
    TextEditingController controller =
        timeControllers.elementAt(timeControllers.length - 1);
    timeControllers.removeAt(timeControllers.length - 1);
    controller.dispose();

    controller = repControllers.elementAt(repControllers.length - 1);
    repControllers.removeAt(repControllers.length - 1);
    controller.dispose();

    controller = weightControllers.elementAt(weightControllers.length - 1);
    weightControllers.removeAt(weightControllers.length - 1);
    controller.dispose();
  }

  void dispose() {
    restController.dispose();
    setController.dispose();

    for (TextEditingController controller in weightControllers) {
      controller.dispose();
    }

    for (TextEditingController controller in timeControllers) {
      controller.dispose();
    }

    for (TextEditingController controller in repControllers) {
      controller.dispose();
    }
  }
}
