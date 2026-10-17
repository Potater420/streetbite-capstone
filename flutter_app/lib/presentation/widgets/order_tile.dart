import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/presentation/widgets/list_item_tile.dart';

/// One row of the order history. Also used on the Profile screen (Part B).
class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final FoodOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final first = order.items.isEmpty ? null : order.items.first;
    final count = order.items.fold<int>(0, (sum, item) => sum + item.quantity);

    return ListItemTile(
      imageUrl: first?.thumbnail ?? '',
      title: first?.name ?? '',
      subtitle:
          '${context.l10n.orderItemsCount(count)} • ${context.formatDateTime(order.createdAt)}',
      trailing: Text(
        context.formatPrice(order.pricing.total),
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}