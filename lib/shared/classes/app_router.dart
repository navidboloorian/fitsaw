import 'package:fitsaw/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // the default page when the app starts
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
      default:
        return null;
    }
  }
}
