import 'package:fitsaw/shared/classes/palette.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionHeader extends ConsumerWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Palette.container2Background,
        border: Border(
          top: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child:
          // Content of the title block.
          Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9 + 10,
          child: Row(
            children: [
              ExpandableArrow(key: key),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
