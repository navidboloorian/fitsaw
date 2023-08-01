import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';

/// Used to create custom expandable section widget. Takes a title to
/// display on the title block and a list of elements to display in the section.
/// Custom expandable is necessary in order to change the color of the header vs
/// the list elements.
class ExpandableSection extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ExpandableSection(
      {super.key, required this.title, required this.children});

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool expanded = false;
  int itemCount = 0;

  // Default state is arrow pointing to the right (collapsed).
  double turns = 3 / 4;

  void toggleExpandable() {
    setState(
      () {
        if (expanded) {
          itemCount = 0;
          turns = 3 / 4;
        } else {
          itemCount = widget.children.length;
          turns = 0;
        }

        expanded = !expanded;
      },
    );
  }

  /// Ensures that the number of items displayed are synced with the number of
  /// items in the list. Previously, when a new item was added the list count
  /// wouldn't update if the list was already expanded.
  void syncItemCount() {
    if (expanded) {
      itemCount = widget.children.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    syncItemCount();

    return Column(
      children: [
        // Title block that collapses/expands the list on tap.
        GestureDetector(
          onTap: toggleExpandable,
          child:
              // Sets title background color.
              Container(
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
                width: MediaQuery.of(context).size.width * 0.9 - 20,
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 50),
                      child: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
