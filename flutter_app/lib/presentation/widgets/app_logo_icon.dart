import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';

/// White rounded tile with the app icon (128 / radius 40 in the Figma kit).
/// Swap the Icon for your own logo image later.
class AppLogoIcon extends StatelessWidget {
  const AppLogoIcon({super.key, this.size = 128});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.3125),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 14,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Icon(Icons.fastfood, size: size * 0.53, color: AppColors.primary),
    );
  }
}