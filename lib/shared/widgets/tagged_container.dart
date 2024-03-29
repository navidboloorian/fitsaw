import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Displays child widget on the top and tag list on the bottom.
class TaggedContainer extends StatelessWidget {
  final List<String> tags;
  final Function(String)? onTap;
  final bool isDismissible;
  final Widget child;

  const TaggedContainer({
    super.key,
    required this.child,
    required this.tags,
    this.onTap,
    this.isDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          tags.isEmpty
              ? const SizedBox.shrink()
              : const SizedBox(
                  height: 5,
                ),
          TagWrapper(
            tags: tags,
            onTap: onTap,
            isDismissible: isDismissible,
          ),
        ],
      ),
    );
  }
}
