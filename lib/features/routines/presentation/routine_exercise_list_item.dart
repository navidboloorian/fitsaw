import 'package:fitsaw/features/exercises/domain/domain.dart';
import 'package:fitsaw/features/routines/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItem extends ConsumerWidget {
  final Map<String, dynamic> routineExerciseMap;

  late final List<TextFieldColumn> _textFieldColumns;
  late final String _exerciseName;

  RoutineExerciseListItem({super.key, required this.routineExerciseMap}) {
    _exerciseName = (routineExerciseMap['exercise'] as Exercise).name;
    _textFieldColumns = [];

    _generateTextFieldColumns();
  }

  void _generateTextFieldColumns() {
    routineExerciseMap.forEach(
      (key, value) {
        switch (key) {
          case 'restController':
            {
              _textFieldColumns.add(
                TextFieldColumn(
                  width: 43,
                  label: 'Rest',
                  textField: TimeTextField(controller: value),
                ),
              );
            }
            break;
          case 'setController':
            {
              _textFieldColumns.add(
                TextFieldColumn(
                  width: 32,
                  label: 'Sets',
                  textField: NumberTextField(controller: value, lengthLimit: 2),
                ),
              );
            }
            break;
          case 'timeController':
            {
              _textFieldColumns.add(
                TextFieldColumn(
                  width: 43,
                  label: 'Time',
                  textField: TimeTextField(controller: value),
                ),
              );
            }
            break;
          case 'repController':
            {
              _textFieldColumns.add(
                TextFieldColumn(
                  width: 37,
                  label: 'Reps',
                  textField: NumberTextField(controller: value, lengthLimit: 2),
                ),
              );
            }
            break;
          case 'weightController':
            {
              _textFieldColumns.add(
                TextFieldColumn(
                  width: 88,
                  label: 'Weight (lbs)',
                  textField: NumberTextField(controller: value, lengthLimit: 3),
                ),
              );
            }
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
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
