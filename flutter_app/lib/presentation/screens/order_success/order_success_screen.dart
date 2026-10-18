import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/food_order.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.order});

  final FoodOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final number = order.id.length > 6
        ? order.id.substring(order.id.length - 6)
        : order.id;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary.withValues(alpha: 0.12),
                ),
                child: Icon(Icons.check_circle, size: 72, color: primary),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.orderPlacedTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.orderPlacedMessage(number),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.formatPrice(order.pricing.total),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(AppRoutes.home)),
                child: Text(
                  l10n.backToHome,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
