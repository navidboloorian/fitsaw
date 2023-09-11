import 'package:fitsaw/screens/screens.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings route) {
    late PageArguments arguments;

    if (route.arguments != null) {
      arguments = (route.arguments as PageArguments);
    }

    switch (route.name) {
      // The default page when the app starts.
      case '/':
      case 'routines':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Routines(),
        );
      case 'history':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const History(),
        );
      case 'exercises':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Exercises(),
        );
      case 'market':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Market(),
        );
      case 'view_exercise':
        return MaterialPageRoute(
          builder: (context) => ViewExercise(
            isNew: arguments.isNew!,
            exercise: arguments.exercise,
          ),
        );
      case 'view_routine':
        return MaterialPageRoute(
          builder: (context) => ViewRoutine(
            isNew: arguments.isNew!,
            routine: arguments.routine,
          ),
        );
      case 'active_routine':
        return MaterialPageRoute(
          builder: (context) => const ActiveRoutine(),
        );
      default:
        return null;
    }
  }
}
