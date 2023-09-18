import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final EdgeInsets margin;

  const BottomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 30,
    this.margin = const EdgeInsets.fromLTRB(0, 10, 0, 10),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          margin: margin,
          height: height,
          padding: EdgeInsets.zero,
          color: Palette.fitsawBlue,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Palette.darkText),
            ),
          ),
        ),
      ),
    );
  }
}
