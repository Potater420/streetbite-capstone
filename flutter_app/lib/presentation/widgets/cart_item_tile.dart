import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/presentation/widgets/meal_image.dart';
import 'package:streetbite/presentation/widgets/quantity_stepper.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onDecrease,
    required this.onIncrease,
  });

  final CartItem item;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: MealImage(url: item.meal.thumbnail, borderRadius: 12),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.formatPrice(item.meal.price),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          QuantityStepper(
            quantity: item.quantity,
            onDecrease: onDecrease,
            onIncrease: onIncrease,
          ),
        ],
      ),
    );
  }
}
