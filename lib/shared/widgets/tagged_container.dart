import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
      child: Column(
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
