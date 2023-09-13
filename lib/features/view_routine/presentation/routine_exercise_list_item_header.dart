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
    // This container allows the entire row to be clickable instead of just the
    // text/arrow. I'm not sure why this works but it does.
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Row(
                children: [
                  ExpandableArrow(key: key),
                  Flexible(
                    child: Text(exercise.name),
                  ),
                ],
              ),
            ),
            EditButton(() => onEdit(context, exercise)),
          ],
        ),
      ),
    );
  }
}
