import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(maxWidth: 40),
      onPressed: onPressed,
      icon: const Icon(
        Icons.settings,
      ),
    );
  }
}
