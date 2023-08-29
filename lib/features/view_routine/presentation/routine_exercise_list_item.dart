import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:fitsaw/features/view_routine/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItem extends ConsumerWidget {
  final RoutineExerciseController routineExercise;
  final Function(BuildContext, Exercise) onClick;

  late final List<TextFieldColumn> _textFieldColumns;
  late final String _exerciseName;

  RoutineExerciseListItem({
    super.key,
    required this.routineExercise,
    required this.onClick,
  }) {
    _exerciseName = routineExercise.exercise.name;
    _textFieldColumns = [];

    _generateTextFieldColumns();
  }

  void _generateTextFieldColumns() {
    _textFieldColumns.add(
      TextFieldColumn(
        width: 44,
        label: 'Rest',
        textField: TimeTextField(controller: routineExercise.restController),
      ),
    );
    _textFieldColumns.add(
      TextFieldColumn(
        width: 32,
        label: 'Sets',
        textField: NumberTextField(
            controller: routineExercise.setController, lengthLimit: 2),
      ),
    );

    if (routineExercise.exercise.isTimed) {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 44,
          label: 'Time',
          textField: TimeTextField(controller: routineExercise.timeController),
        ),
      );
    } else {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 37,
          label: 'Reps',
          textField: NumberTextField(
              controller: routineExercise.repController, lengthLimit: 2),
        ),
      );
    }

    if (routineExercise.exercise.isWeighted) {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 88,
          label: 'Weight (lbs)',
          textField: NumberTextField(
              controller: routineExercise.weightController, lengthLimit: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onClick(context, routineExercise.exercise),
      child: CustomContainer(
        color: Palette.container2Background,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_exerciseName),
            const Divider(
              color: Palette.darkText,
            ),
            Wrap(
              spacing: 10,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _textFieldColumns,
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldColumn extends StatelessWidget {
  final double width;
  final String label;
  final Widget textField;

  const TextFieldColumn({
    super.key,
    required this.width,
    required this.label,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          textField,
          Text(
            label,
            style: const TextStyle(color: Palette.secondaryText),
          ),
        ],
      ),
    );
  }
}
