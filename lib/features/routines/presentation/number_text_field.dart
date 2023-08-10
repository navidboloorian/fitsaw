import 'package:fitsaw/features/routines/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final int lengthLimit;

  const NumberTextField(
      {super.key, required this.controller, required this.lengthLimit});

  @override
  State<NumberTextField> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isEmpty) {
      widget.controller.text = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          if (widget.controller.text.isEmpty ||
              int.parse(widget.controller.text) < 1) {
            widget.controller.text = '1';
          }
        }
      },
      child: TextFormField(
        textAlign: TextAlign.center,
        key: UniqueKey(),
        controller: widget.controller,
        decoration: const InputDecoration(hintText: '0'),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.lengthLimit),
        ],
      ),
    );
  }
}
