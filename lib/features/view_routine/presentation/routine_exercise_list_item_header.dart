import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItemHeader extends ConsumerWidget {
  final Exercise exercise;
  final Function(BuildContext, Exercise) onEdit;

  const RoutineExerciseListItemHeader({
    super.key,
    required this.exercise,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This container allows the entire row to be clickable isntead of just the
    // text/arrow. I'm not sure why this works but it does.
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ExpandableArrow(key: key),
              Text(exercise.name),
            ],
          ),
          EditButton(() => onEdit(context, exercise)),
        ],
      ),
    );
  }
}
