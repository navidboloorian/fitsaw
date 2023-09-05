import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/shared/providers/providers.dart';

class ExpandableArrow extends ConsumerWidget {
  const ExpandableArrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedRotation(
      turns: ref.watch(expandableArrowProvider(key!)),
      duration: const Duration(milliseconds: 50),
      child: const Icon(
        Icons.arrow_drop_down_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
