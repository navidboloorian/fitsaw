import 'package:fitsaw/shared/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to create custom expandable section widget. Takes a header to
/// display as the title block and a list of elements to display in the section.
/// Custom expandable is necessary in order to change the color of the header vs
/// the list elements.
class ExpandableSection extends ConsumerStatefulWidget {
  final List<Widget> children;
  final Widget header;

  const ExpandableSection({
    super.key,
    required this.header,
    required this.children,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpandableSectionState();
}

class _ExpandableSectionState extends ConsumerState<ExpandableSection> {
  bool isExpanded = true;
  int itemCount = 0;

  void _toggleExpandable() {
    setState(
      () {
        if (isExpanded) {
          itemCount = 0;
          ref.read(expandableArrowProvider(widget.header.key!).notifier).state =
              3 / 4;
        } else {
          itemCount = widget.children.length;
          ref.read(expandableArrowProvider(widget.header.key!).notifier).state =
              0;
        }

        isExpanded = !isExpanded;
      },
    );
  }

  /// Ensures that the number of items displayed are synced with the number of
  /// items in the list. Previously, when a new item was added the list count
  /// wouldn't update if the list was already expanded.
  void syncItemCount() {
    if (isExpanded) {
      itemCount = widget.children.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    syncItemCount();

    return Column(
      children: [
        // Title block that collapses/expands the list on tap.
        GestureDetector(onTap: _toggleExpandable, child: widget.header),
        AnimatedSize(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 150),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                for (int i = 0; i < itemCount; i++) widget.children[i]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
