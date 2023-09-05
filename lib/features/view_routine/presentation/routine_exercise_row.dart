import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineExerciseRow extends ConsumerWidget {
  final Widget child;

  const RoutineExerciseRow({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        children: [
          const Divider(height: 0, color: Palette.canvas),
          child,
        ],
      ),
    );
  }
}
