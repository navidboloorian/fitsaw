import 'package:fitsaw/features/view_routine/services/services.dart';
import 'package:flutter/material.dart';

class TimeTextField extends StatefulWidget {
  final TextEditingController controller;

  const TimeTextField({super.key, required this.controller});

  @override
  State<TimeTextField> createState() => _TimeTextFieldState();
}

class _TimeTextFieldState extends State<TimeTextField> {
  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isEmpty) {
      widget.controller.text = '00:00';
    }
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
        textAlign: TextAlign.center,
        controller: widget.controller,
        decoration: const InputDecoration(hintText: '00:00'),
        keyboardType: TextInputType.number,
        inputFormatters: [TimeInputFormatter()],
      ),
    );
  }
}
