import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';

/// Carousel card from the Figma Home screen (228 x 156 image).
class HotOfferCard extends StatelessWidget {
  const HotOfferCard({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 228,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 156, child: MealImage(url: meal.thumbnail)),
          const SizedBox(height: 12),
          Text(
            meal.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            '${meal.category} • ${meal.area}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppColors.grayDark),
          ),
          Text(
            context.formatPrice(meal.price),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}