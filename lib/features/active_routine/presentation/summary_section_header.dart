import 'package:fitsaw/features/exercise_list/domain/domain.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummarySectionHeader extends ConsumerWidget {
  final Exercise exercise;
  final int setCount;

  const SummarySectionHeader({
    super.key,
    required this.exercise,
    required this.setCount,
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
          setCount > 1
              ? Text('$setCount sets of ${exercise.name}')
              : Text('$setCount set of ${exercise.name}'),
        ],
      ),
    );
  }
}
