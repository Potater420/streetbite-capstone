import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';

class MealImage extends StatelessWidget {
  const MealImage({super.key, required this.url, this.borderRadius = 16});

  final String url;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : const _ImagePlaceholder(),
        errorBuilder: (context, error, stack) => const _ImagePlaceholder(),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(Icons.restaurant, color: AppColors.grayDark),
      ),
    );
  }
}