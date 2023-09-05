import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const SizedBox(
        width: 32,
        height: 32,
        child: Icon(
          Icons.edit_outlined,
          size: 16,
        ),
      ),
    );
  }
}
