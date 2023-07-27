import 'package:flutter/material.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: Themes.dark,
    );
  }
}
