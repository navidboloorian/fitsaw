import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final int lengthLimit;
  final TextStyle? style;

  const NumberTextField({
    super.key,
    required this.controller,
    required this.lengthLimit,
    this.style,
  });

  @override
  State<NumberTextField> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  void _setDefault() {
    if (widget.controller.text.isEmpty) {
      widget.controller.text = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    _setDefault();

    return Focus(
      key: widget.key,
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          if (widget.controller.text.isEmpty ||
              int.parse(widget.controller.text) < 1) {
            widget.controller.text = '1';
          }
        }
      },
      child: TextFormField(
        key: widget.key ?? UniqueKey(),
        textAlign: TextAlign.center,
        controller: widget.controller,
        decoration: const InputDecoration(hintText: '0'),
        style: widget.style,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.lengthLimit),
        ],
      ),
    );
  }
}
