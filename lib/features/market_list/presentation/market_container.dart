import 'package:fitsaw/features/market_list/presentation/presentation.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Displays child widget on the top and tag list on the bottom.
class MarketContainer extends StatelessWidget {
  final List<String> tags;
  final Function(String) onTap;
  final Routine routine;

  const MarketContainer({
    super.key,
    required this.tags,
    required this.routine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(routine.name),
              // TODO: query user db based on routine.creator id
              // Text("username"),
            ],
          ),
          tags.isEmpty
              ? const SizedBox.shrink()
              : const SizedBox(
                  height: 5,
                ),
          TagWrapper(
            tags: tags,
            onTap: onTap,
          ),
          tags.isEmpty
              ? const SizedBox.shrink()
              : const SizedBox(
                  height: 10,
                ),
          const Divider(
            height: 1,
            color: Palette.container2Background,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(FitsawIcons.download, size: 16),
                  const SizedBox(width: 5),
                  Text('(${routine.downloads})',
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              StarBar(
                routine: routine,
              )
            ],
          ),
        ],
      ),
    );
  }
}
