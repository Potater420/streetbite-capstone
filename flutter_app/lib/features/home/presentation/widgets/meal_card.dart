import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/category_extensions.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/core/widgets/meal_image.dart';

/// Grid card: image, name, category and the Add-to-Cart button.
class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, required this.onAdd});

  final Meal meal;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(aspectRatio: 1, child: MealImage(url: meal.thumbnail)),
        const SizedBox(height: 8),
        Text(
          meal.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          context.categoryName(meal.category),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.grayDark,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                context.formatPrice(meal.price),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton.filled(
              tooltip: context.l10n.addToCart,
              visualDensity: VisualDensity.compact,
              onPressed: onAdd,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
