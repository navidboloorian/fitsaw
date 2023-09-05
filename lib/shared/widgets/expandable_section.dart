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
  final double gap;
  final bool isExpanded;

  const ExpandableSection({
    super.key,
    required this.header,
    required this.children,
    required this.isExpanded,
    this.gap = 10,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpandableSectionState();
}

class _ExpandableSectionState extends ConsumerState<ExpandableSection> {
  late bool isExpanded;
  late double? boxHeight;

  void _toggleExpandable() {
    setState(
      () {
        if (isExpanded) {
          boxHeight = 0;

          // Uses the header widget's key to create a provider that can be
          // referenced by the header to rotate the arrow on tap.
          ref.read(expandableArrowProvider(widget.header.key!).notifier).state =
              3 / 4;
        } else {
          boxHeight = null;
          ref.read(expandableArrowProvider(widget.header.key!).notifier).state =
              0;
        }

        isExpanded = !isExpanded;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isExpanded = widget.isExpanded;
    });

    if (widget.isExpanded) {
      boxHeight = null;

      Future(() => ref
          .read(expandableArrowProvider(widget.header.key!).notifier)
          .state = 0);
    } else {
      boxHeight = 0;
      Future(() => ref
          .read(expandableArrowProvider(widget.header.key!).notifier)
          .state = 3 / 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title block that collapses/expands the list on tap.
        GestureDetector(onTap: _toggleExpandable, child: widget.header),
        AnimatedSize(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 150),
          child: SizedBox(
            height: boxHeight,
            child: Padding(
              padding: boxHeight == null
                  ? EdgeInsets.only(top: widget.gap)
                  : EdgeInsets.zero,
              child: Column(
                children: widget.children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
