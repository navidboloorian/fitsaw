import 'package:fitsaw/features/routines/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RoutineExerciseContainer extends StatelessWidget {
  final RoutineExerciseWrapper routineExercise;

  const RoutineExerciseContainer({super.key, required this.routineExercise});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Palette.container2Background,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(routineExercise.exercise!.name),
          ),
          const SizedBox(height: 3),
          const Divider(
            height: 0,
            color: Palette.darkText,
            thickness: 1,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  initialValue: '99:99',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
