import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseListItemHeader extends ConsumerWidget {
  final String title;

  const RoutineExerciseListItemHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This container allows the entire row to be clickable isntead of just the
    // text/arrow. I'm not sure why this works but it does.
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Row(
        children: [
          ExpandableArrow(key: key),
          Text(title),
        ],
      ),
    );
  }
}
