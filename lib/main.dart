import 'package:flutter/material.dart';
import 'package:fitsaw/shared/classes/classes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      theme: Themes.dark,
    );
  }
}
