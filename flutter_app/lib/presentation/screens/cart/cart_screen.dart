import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/cart/cart_event.dart';
import 'package:streetbite/presentation/blocs/cart/cart_state.dart';
import 'package:streetbite/presentation/widgets/bottom_action_bar.dart';
import 'package:streetbite/presentation/widgets/cart_item_tile.dart';
import 'package:streetbite/presentation/widgets/delivery_mode_toggle.dart';
import 'package:streetbite/presentation/widgets/order_summary.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // BlocListener: shows a SnackBar the moment the cart becomes empty.
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.items.isNotEmpty && current.items.isEmpty,
      listener: (context, state) {
        // Only while this screen is visible, so clearing the cart after an
        // order is placed doesn't show it.
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          context.showMessage(l10n.cartEmpty);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) =>
                previous.deliveryMode != current.deliveryMode,
            builder: (context, state) => SizedBox(
              width: 247,
              child: DeliveryModeToggle(
                selected: state.deliveryMode,
                onChanged: (mode) =>
                    context.read<CartBloc>().add(CartDeliveryModeChanged(mode)),
              ),
            ),
          ),
        ),
        // BlocBuilder: rebuilds the items and the totals on every change.
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) return const _EmptyCart();

            final cart = context.read<CartBloc>();
            return Column(
              children: [
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 16),
                    children: [
                      SectionTitle(l10n.cartTitle),
                      for (final item in state.items)
                        CartItemTile(
                          item: item,
                          onDecrease: () => cart.add(
                            item.quantity == 1
                                ? CartItemRemoved(item.meal.id)
                                : CartItemDecremented(item.meal.id),
                          ),
                          onIncrease: () => cart.add(CartItemAdded(item.meal)),
                        ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              l10n.seeMenu,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: OrderSummary(pricing: state.pricing),
                      ),
                    ],
                  ),
                ),
                BottomActionBar(
                  label: l10n.continueButton,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.checkout),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 72,
              color: AppColors.grayDark,
            ),
            const SizedBox(height: 16),
            Text(l10n.cartEmpty, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.browseMeals),
              ),
            ),
          ],
        ),
      ),
    );
  }
}