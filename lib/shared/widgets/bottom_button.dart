import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BottomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          height: 35,
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
