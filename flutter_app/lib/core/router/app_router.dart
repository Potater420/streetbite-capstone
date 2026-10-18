import 'package:flutter/material.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/features/auth/presentation/screens/login_screen.dart';
import 'package:streetbite/features/main_layout/presentation/screens/main_shell.dart';
import 'package:streetbite/features/auth/presentation/screens/signup_screen.dart';
import 'package:streetbite/features/splash/presentation/screens/splash_screen.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/meal_details/presentation/screens/meal_details_screen.dart';
import 'package:streetbite/features/cart/presentation/screens/cart_screen.dart';
import 'package:streetbite/features/orders/domain/entities/food_order.dart';
import 'package:streetbite/features/orders/presentation/screens/checkout_screen.dart';
import 'package:streetbite/features/orders/presentation/screens/order_success_screen.dart';
import 'package:streetbite/features/vendors/presentation/screens/vendor_map_screen.dart';

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
        screen = const MainShell();
      case AppRoutes.cart:
        screen = const CartScreen();
      case AppRoutes.checkout:
        screen = const CheckoutScreen();
      case AppRoutes.orderSuccess:
        screen = OrderSuccessScreen(order: settings.arguments as FoodOrder);
      case AppRoutes.vendorMap:
        screen = const VendorMapScreen();
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
