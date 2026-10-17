import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';

/// Row from the Figma Profile screen: 24-px icon and a 16-pt semibold label.
class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color ?? AppColors.grayDark),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
