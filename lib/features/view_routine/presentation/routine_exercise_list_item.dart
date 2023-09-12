import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/features/view_routine/domain/domain.dart';
import 'package:fitsaw/features/view_routine/presentation/presentation.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItem extends ConsumerStatefulWidget {
  final RoutineExerciseController routineExerciseController;
  final Function(BuildContext, Exercise) onEdit;

  const RoutineExerciseListItem({
    super.key,
    required this.routineExerciseController,
    required this.onEdit,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RoutineExerciseListItemState();
}

class _RoutineExerciseListItemState
    extends ConsumerState<RoutineExerciseListItem> {
  int sets = 1;
  bool isPopulating = true;
  List<PerSetRow> perSetRows = [];

  void _generatePerSetRows() {
    if (sets > perSetRows.length) {
      for (int i = perSetRows.length; i < sets; i++) {
        // Avoids adding extra controllers when prepopulating.
        if (sets > widget.routineExerciseController.repControllers.length) {
          widget.routineExerciseController.add();
        }

        perSetRows.add(
          PerSetRow(
            rowNumber: i + 1,
            routineExerciseController: widget.routineExerciseController,
          ),
        );
      }
    } else {
      for (int i = perSetRows.length - 1; i >= sets; i--) {
        widget.routineExerciseController.delete();

        perSetRows.removeAt(i);
      }
    }

    setState(() {
      perSetRows = perSetRows;
    });
  }

  void _updateSets(String setCount) {
    setState(() {
      sets = int.parse(setCount);
    });
  }

  void _populatePreExistingSets() {
    sets = int.parse(widget.routineExerciseController.setController.text);

    setState(() {
      sets = sets;
    });
  }

  @override
  void initState() {
    super.initState();

    Future(() => _populatePreExistingSets());
  }

  @override
  Widget build(BuildContext context) {
    _generatePerSetRows();

    return ExpandableSection(
      isExpanded: true,
      gap: 0,
      header: RoutineExerciseListItemHeader(
        key: UniqueKey(),
        exercise: widget.routineExerciseController.exercise,
        onEdit: widget.onEdit,
      ),
      children: [
        ExerciseWideRow(
          setController: widget.routineExerciseController.setController,
          restController: widget.routineExerciseController.restController,
          updateSets: _updateSets,
        ),
        ...perSetRows,
      ],
    );
  }
}

class ExerciseWideRow extends ConsumerWidget {
  final TextEditingController setController;
  final TextEditingController restController;
  final Function(String) updateSets;

  const ExerciseWideRow({
    super.key,
    required this.setController,
    required this.restController,
    required this.updateSets,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Divider(
          height: 0,
          color: Palette.canvas,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            children: [
              LabeledField(
                width: 44,
                label: 'Rest',
                child: TimeTextField(
                  controller: restController,
                ),
              ),
              Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    updateSets(setController.text);
                  }
                },
                child: LabeledField(
                  width: 32,
                  label: 'Sets',
                  child: NumberTextField(
                    controller: setController,
                    lengthLimit: 2,
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
          color: Palette.canvas,
        ),
      ],
    );
  }
}

class PerSetRow extends ConsumerWidget {
  final int rowNumber;
  final RoutineExerciseController routineExerciseController;

  const PerSetRow({
    super.key,
    required this.rowNumber,
    required this.routineExerciseController,
  });

  List<Widget> _generateTextFields() {
    List<Widget> list = [];

    if (routineExerciseController.exercise.isTimed) {
      list.add(
        LabeledField(
          width: 42,
          label: 'Time',
          child: TimeTextField(
            controller:
                routineExerciseController.timeControllers[rowNumber - 1],
          ),
        ),
      );
    } else {
      list.add(
        LabeledField(
          width: 37,
          label: 'Reps',
          child: NumberTextField(
            controller: routineExerciseController.repControllers[rowNumber - 1],
            lengthLimit: 2,
          ),
        ),
      );
    }

    if (routineExerciseController.exercise.isWeighted) {
      list.add(const SizedBox(width: 5));

      list.add(
        LabeledField(
          width: 55,
          label: 'Weight',
          child: NumberTextField(
            controller:
                routineExerciseController.weightControllers[rowNumber - 1],
            lengthLimit: 3,
          ),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Set $rowNumber',
              ),
              Row(
                children: _generateTextFields(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
