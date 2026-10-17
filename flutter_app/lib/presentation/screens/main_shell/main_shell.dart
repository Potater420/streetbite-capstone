import 'package:flutter/material.dart';
import 'package:streetbite/presentation/screens/favorites/favorites_screen.dart';
import 'package:streetbite/presentation/screens/home/home_screen.dart';
import 'package:streetbite/presentation/screens/orders/orders_screen.dart';
import 'package:streetbite/presentation/screens/profile/profile_screen.dart';
import 'package:streetbite/presentation/widgets/app_bottom_nav_bar.dart';

/// Hosts the four tabs. IndexedStack keeps each tab's state (scroll
/// position, search text) when switching.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}