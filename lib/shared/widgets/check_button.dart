import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CheckButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.check,
      ),
    );
  }
}
