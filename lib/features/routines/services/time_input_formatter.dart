import 'dart:math' as math;

import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  final RegExp _expression;
  TimeInputFormatter() : _expression = RegExp(r'^[0-9]+:[0-9]+$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_expression.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;

      String value = newValue.text;
      String newText;

      String leftSubstring = '';
      String rightSubstring = '';

      // The TextField will start with a value of "00:00" which has a length of
      // 5. As such, upon deletion, the length of value will be 4 and upon
      // addition the length will be 6.

      if (value.length == 4) {
        // A character is deleted from the field.

        // Shift the leftmost character one to the right and slide a zero into
        // the 0th index.
        leftSubstring = '0${value[0]}';

        if (value[1] == ':') {
          // A deletion is made on the left side of the colon. This is necessary
          // because of the example below.
          // E.g.:
          // 12|:34
          // 1:34
          // value[1] == ":"
          // value[3] == "4"
          // leftSubstring = 01
          // rightSubstring = :4
          // newText = 01::4
          rightSubstring = value.substring(2);
        } else {
          rightSubstring = '${value[1]}${value[3]}';
        }
      } else if (value.length == 6) {
        // A character is added to the field.
        if (value[0] == '0') {
          // The current, left-most characcter is "0" i.e. there are additional
          // empty spaces to fill.

          if (value[3] == ':') {
            // A character is added on the left side of the colon. This is necessary
            // because of the example below.
            // E.g.:
            // 01|:34
            // 011:34
            // value[1] = "1"
            // value[3] = ":"
            // leftSubstring = "1:"
            // rightSubstring = "34"
            // newText = "1::34"
            leftSubstring = value.substring(1, 3);
          } else {
            leftSubstring = '${value[1]}${value[3]}';
          }

          // Set the right substring to the characters to the rightmost
          // characters.
          rightSubstring = value.substring(4);
        } else {
          // All spaces are filled, keep using old value and don't allow new
          // characters to be inputted.
          leftSubstring = oldValue.text.substring(0, 2);
          rightSubstring = oldValue.text.substring(3, 5);
        }
      }

      newText = '$leftSubstring:$rightSubstring';

      // Move cursor to the rightmost point of the TextField.
      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }

    return oldValue;
  }
}
