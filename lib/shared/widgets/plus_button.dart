import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlusButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.add,
      ),
    );
  }
}
