import 'package:flutter/material.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}