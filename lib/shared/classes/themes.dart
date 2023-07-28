import 'package:flutter/material.dart';
import 'package:fitsaw/shared/classes/palette.dart';

class Themes {
  static ThemeData get dark {
    return ThemeData(
      fontFamily: 'OpenSans',
      brightness: Brightness.dark,
      primaryColor: Palette.primary,
      canvasColor: Palette.canvas,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16, color: Palette.primaryText),

        // applies to TextFields
        titleMedium: TextStyle(color: Palette.primaryText),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Palette.primaryText,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 56,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Palette.secondaryText),
        counterStyle: TextStyle(color: Palette.secondaryText),
        isDense: true,
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
