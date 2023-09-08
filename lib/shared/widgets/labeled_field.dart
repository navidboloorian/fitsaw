import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/widgets.dart';

class LabeledField extends StatelessWidget {
  final double width;
  final String label;
  final Widget child;

  const LabeledField({
    super.key,
    required this.width,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          child,
          Text(
            label,
            style: const TextStyle(color: Palette.secondaryText),
          ),
        ],
      ),
    );
  }
}
