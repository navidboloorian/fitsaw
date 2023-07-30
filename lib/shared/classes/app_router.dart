import 'package:fitsaw/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      // The default page when the app starts.
      case '/':
      case 'routines':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Routines(),
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
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ViewExercise(),
        );
      default:
        return null;
    }
  }
}
