import 'package:flutter/material.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;

  const SearchBox(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search...',
        ),
      ),
    );
  }
}
