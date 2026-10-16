import 'package:flutter/material.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/presentation/screens/home/home_screen.dart';
import 'package:streetbite/presentation/screens/login/login_screen.dart';
import 'package:streetbite/presentation/screens/signup/signup_screen.dart';
import 'package:streetbite/presentation/screens/splash/splash_screen.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/screens/meal_details/meal_details_screen.dart';
import 'package:streetbite/presentation/screens/cart/cart_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Widget screen;
    switch (settings.name) {
      case AppRoutes.login:
        screen = const LoginScreen();
      case AppRoutes.signup:
        screen = const SignUpScreen();
      case AppRoutes.home:
        screen = const HomeScreen();
      case AppRoutes.cart:
        screen = const CartScreen();
      case AppRoutes.mealDetails:
        // The selected meal arrives as a navigation argument.
        screen = MealDetailsScreen(meal: settings.arguments as Meal);
      case AppRoutes.splash:
      default:
        screen = const SplashScreen();
    }
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}
