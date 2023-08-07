import 'package:fitsaw/features/routines/services/services.dart';
import 'package:flutter/material.dart';

class TimedTextField extends StatefulWidget {
  final TextEditingController controller;

  const TimedTextField({super.key, required this.controller});

  @override
  State<TimedTextField> createState() => _TimedTextFieldState();
}

class _TimedTextFieldState extends State<TimedTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = '00:00';
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          TimeInputValidator.validate(widget.controller);
        }
      },
      child: TextFormField(
        key: UniqueKey(),
        controller: widget.controller,
        decoration: const InputDecoration(hintText: '00:00'),
        inputFormatters: [TimeInputFormatter()],
      ),
    );
  }
}
