import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:fitsaw/features/view_routine/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItem extends ConsumerStatefulWidget {
  final RoutineExerciseController routineExercise;
  final Function(BuildContext, Exercise) onClick;

  const RoutineExerciseListItem({
    super.key,
    required this.routineExercise,
    required this.onClick,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RoutineExerciseListItemState();
}

class _RoutineExerciseListItemState
    extends ConsumerState<RoutineExerciseListItem> {
  late final List<TextFieldColumn> _textFieldColumns;
  late final String _exerciseName;
  late int setCount;

  void _generateTextFieldColumns() {
    _textFieldColumns.add(
      TextFieldColumn(
        width: 44,
        label: 'Rest',
        textField:
            TimeTextField(controller: widget.routineExercise.restController),
      ),
    );
    _textFieldColumns.add(
      TextFieldColumn(
        width: 32,
        label: 'Sets',
        textField: NumberTextField(
            controller: widget.routineExercise.setController, lengthLimit: 2),
      ),
    );

    if (widget.routineExercise.exercise.isTimed) {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 44,
          label: 'Time',
          textField:
              TimeTextField(controller: widget.routineExercise.timeController),
        ),
      );
    } else {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 37,
          label: 'Reps',
          textField: NumberTextField(
              controller: widget.routineExercise.repController, lengthLimit: 2),
        ),
      );
    }

    if (widget.routineExercise.exercise.isWeighted) {
      _textFieldColumns.add(
        TextFieldColumn(
          width: 88,
          label: 'Weight (lbs)',
          textField: NumberTextField(
              controller: widget.routineExercise.weightController,
              lengthLimit: 3),
        ),
      );
    }
  }

  void _updateSets() {
    setCount = int.parse(widget.routineExercise.setController.text);
  }

  @override
  void initState() {
    super.initState();

    _exerciseName = widget.routineExercise.exercise.name;
    _textFieldColumns = [];
    widget.routineExercise.setController.addListener(_updateSets);

    _generateTextFieldColumns();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(context, widget.routineExercise.exercise),
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
