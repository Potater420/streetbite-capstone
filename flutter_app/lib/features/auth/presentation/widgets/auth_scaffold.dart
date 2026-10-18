import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/widgets/app_logo_icon.dart';
import 'package:streetbite/features/settings/presentation/widgets/language_toggle_button.dart';

/// Welcome-style layout from the Figma kit: photo on top, green panel below.
/// The hero height comes from MediaQuery, so it adapts to any screen size.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.heroHeightFactor = 0.38,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final double heroHeightFactor;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final heroHeight = media.size.height * heroHeightFactor;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: heroHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/welcome_hero.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const ColoredBox(color: Colors.black12),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.1, 0.44],
                        colors: [Color(0x33000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                  Center(
                    child: AppLogoIcon(size: math.min(128, heroHeight * 0.45)),
                  ),
                  PositionedDirectional(
                    top: media.padding.top + 8,
                    end: 16,
                    child: const LanguageToggleButton(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                32,
                24,
                24 + media.padding.bottom,
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 32),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
