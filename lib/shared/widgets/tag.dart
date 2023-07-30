import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String name;
  final Function(String)? onTap;
  final bool isDismissible;
  final Color color;

  const Tag({
    required this.name,
    super.key,
    this.onTap,
    this.isDismissible = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(name);
        }
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 25),
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: color),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // use Flexible to wrap text in container
            Flexible(
              child: Text(
                name,
                style: TextStyle(color: color),
              ),
            ),
            const SizedBox(width: 3),
            isDismissible
                ? Icon(
                    Icons.close,
                    size: 10,
                    color: color,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
