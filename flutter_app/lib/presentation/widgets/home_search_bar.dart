import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// Pill search bar from the Figma Home screen.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: context.l10n.searchHint,
        hintStyle: const TextStyle(color: AppColors.grayDark),
        prefixIcon: const Icon(Icons.search, color: AppColors.grayDark),
        filled: true,
        fillColor: isDark
            ? theme.colorScheme.surfaceContainerHighest
            : AppColors.grayLight,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}