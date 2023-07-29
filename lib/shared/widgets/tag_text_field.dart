import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class TagTextField extends ConsumerStatefulWidget {
  const TagTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagTextFieldState();
}

class _TagTextFieldState extends ConsumerState<TagTextField> {
  late final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
