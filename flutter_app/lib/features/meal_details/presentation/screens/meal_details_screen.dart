import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_event.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_state.dart';
import 'package:streetbite/features/favorites/presentation/blocs/favorites_cubit.dart';
import 'package:streetbite/features/favorites/presentation/blocs/favorites_state.dart';
import 'package:streetbite/features/cart/presentation/widgets/cart_icon_button.dart';
import 'package:streetbite/core/widgets/meal_image.dart';

/// Receives the selected meal through navigation arguments (see AppRouter).
class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  static final ButtonStyle _overlayStyle = IconButton.styleFrom(
    backgroundColor: Colors.black38,
    foregroundColor: Colors.white,
  );

  int _quantityInCart(CartState state) => state.items
      .where((item) => item.meal.id == meal.id)
      .fold<int>(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final heroHeight = (MediaQuery.sizeOf(context).height * 0.3).clamp(
      220.0,
      320.0,
    );

    return BlocListener<FavoritesCubit, FavoritesState>(
      listenWhen: (previous, current) => current.failure != null,
      listener: (context, state) => context.showFailure(state.failure!),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: heroHeight,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              MealImage(url: meal.thumbnail, borderRadius: 0),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 0.5],
                                    colors: [
                                      Color(0x4D000000),
                                      Color(0x00000000),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.name,
                                style: theme.textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              _MetaRow(
                                category: meal.category,
                                area: meal.area,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                l10n.instructionsTitle,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                meal.instructions.trim(),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _BottomBar(meal: meal, quantityInCart: _quantityInCart),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      style: _overlayStyle,
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).backButtonTooltip,
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state.isFavorite(meal.id);
                        return IconButton(
                          style: _overlayStyle,
                          tooltip: isFavorite
                              ? l10n.removeFromFavorites
                              : l10n.addToFavorites,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.redAccent : Colors.white,
                          ),
                          onPressed: () =>
                              context.read<FavoritesCubit>().toggle(meal),
                        );
                      },
                    ),
                    const SizedBox(width: 4),
                    CartIconButton(
                      style: _overlayStyle,
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AppRoutes.cart),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.category, required this.area});

  final String category;
  final String area;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: AppColors.grayDark);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        Text(category, style: style),
        Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: AppColors.grayMid,
            shape: BoxShape.circle,
          ),
        ),
        Text(area, style: style),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.meal, required this.quantityInCart});

  final Meal meal;
  final int Function(CartState) quantityInCart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final price = context.formatPrice(meal.price);

    return Material(
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          // BlocConsumer: the listener shows feedback, the builder updates
          // the button with the live cart count.
          child: BlocConsumer<CartBloc, CartState>(
            listenWhen: (previous, current) =>
                quantityInCart(current) > quantityInCart(previous),
            listener: (context, state) => context.showMessage(
              l10n.addedToCart(meal.name),
              duration: const Duration(seconds: 2),
            ),
            builder: (context, state) {
              final count = quantityInCart(state);
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () =>
                    context.read<CartBloc>().add(CartItemAdded(meal)),
                child: Text(
                  count == 0
                      ? l10n.addToCartWithPrice(price)
                      : l10n.addAnotherWithCount(count),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}