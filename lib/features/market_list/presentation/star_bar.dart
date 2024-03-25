import 'dart:math';

import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StarBar extends ConsumerWidget {
  final Routine routine;

  const StarBar({super.key, required this.routine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Icon> starListGenerator() {
      List<Icon> starList = [];

      for (int i = 0; i < min(5, routine.rating!.toInt()); i++) {
        starList.add(const Icon(FitsawIcons.star, size: 16));
      }

      for (int i = max(0, routine.rating!.toInt()); i < 5; i++) {
        starList.add(
          const Icon(
            FitsawIcons.star,
            size: 16,
            color: Palette.container2Background,
          ),
        );
      }

      return starList;
    }

    return Row(
      children: [
        ...starListGenerator(),
        const SizedBox(width: 5),
        Text("(${routine.reviewers.length})",
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
