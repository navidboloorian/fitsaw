import 'package:flutter/material.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(ProviderScope(child: App()));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: Themes.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
