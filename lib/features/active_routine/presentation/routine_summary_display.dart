import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineSummaryDisplay extends ConsumerWidget {
  final String elapsedTime;
  final Routine routine;
  final bool isHistory;

  const RoutineSummaryDisplay({
    super.key,
    required this.elapsedTime,
    required this.routine,
    required this.isHistory,
  });

  List<Widget> _generateSetRows(RoutineExerciseWrapper routineExerciseWrapper) {
    List<Widget> list = [];

    for (int i = 0; i < routineExerciseWrapper.sets!; i++) {
      list.add(
        RoutineSummaryRow(
          rowNumber: i,
          routineExerciseWrapper: routineExerciseWrapper,
        ),
      );
    }

    return list;
  }

  List<Widget> _generateSections(WidgetRef ref) {
    List<Widget> list = [];

    for (RoutineExerciseWrapper routineExerciseWrapper in routine.exercises) {
      list.add(
        ExpandableSection(
          gap: 0,
          header: SummarySectionHeader(
            key: UniqueKey(),
            setCount: routineExerciseWrapper.sets!,
            exercise: routineExerciseWrapper.exercise!,
          ),
          isExpanded: true,
          children: _generateSetRows(routineExerciseWrapper),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomContainer(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                isHistory
                    ? 'Routine: ${routine.name}'
                    : 'Congratulations! You have completed your routine: ${routine.name}!',
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: Palette.canvas,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: LabeledField(
              label: 'Elapsed Time',
              width: 150,
              child: Text(
                elapsedTime.toString().split('.').first.padLeft(8, '0'),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: Palette.canvas,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Column(
              children: _generateSections(ref),
            ),
          )
        ],
      ),
    );
  }
}

class RoutineSummaryRow extends ConsumerWidget {
  final int rowNumber;
  final RoutineExerciseWrapper routineExerciseWrapper;

  const RoutineSummaryRow({
    super.key,
    required this.rowNumber,
    required this.routineExerciseWrapper,
  });

  List<Widget> _generateFields() {
    List<Widget> list = [];

    if (routineExerciseWrapper.exercise!.isTimed) {
      list.add(
        LabeledField(
          width: 42,
          label: 'Time',
          child: Text(routineExerciseWrapper.times[rowNumber].toString()),
        ),
      );
    } else {
      list.add(
        LabeledField(
          width: 37,
          label: 'Reps',
          child: Text(routineExerciseWrapper.reps[rowNumber].toString()),
        ),
      );
    }

    if (routineExerciseWrapper.exercise!.isWeighted) {
      list.add(const SizedBox(width: 5));

      list.add(
        LabeledField(
          width: 55,
          label: 'Weight',
          child: Text(routineExerciseWrapper.weights[rowNumber].toString()),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Set ${rowNumber + 1}'),
          Row(
            children: [
              Row(
                children: _generateFields(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
