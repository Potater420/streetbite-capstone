import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/biometric_result.dart';
import 'package:streetbite/domain/usecases/authenticate_with_biometrics_usecase.dart';
import 'package:streetbite/injection.dart';
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
  static const _profileIndex = 3;

  static const _tabs = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  final _authenticate = sl<AuthenticateWithBiometricsUseCase>();
  int _index = 0;
  bool _isAuthenticating = false;

  Future<void> _onTabSelected(int index) async {
    final opensProfile = index == _profileIndex && _index != _profileIndex;
    if (!opensProfile) {
      setState(() => _index = index);
      return;
    }
    if (_isAuthenticating) return;

    // Fingerprint required before the profile opens.
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    _isAuthenticating = true;
    final result = await _authenticate(l10n.biometricReason);
    _isAuthenticating = false;
    if (!mounted) return;

    switch (result) {
      case BiometricResult.success:
        setState(() => _index = index);
      case BiometricResult.unavailable:
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.biometricUnavailable)));
        setState(() => _index = index);
      case BiometricResult.failed:
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.biometricFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onTap: _onTabSelected,
      ),
    );
  }
}
