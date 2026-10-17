import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_cubit.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_state.dart';
import 'package:streetbite/presentation/widgets/empty_state.dart';
import 'package:streetbite/presentation/widgets/list_item_tile.dart';
import 'package:streetbite/presentation/widgets/screen_title.dart';

/// Live favourites from the user's Firestore document.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(l10n.favoritesTitle),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state.meals.isEmpty) {
                    return EmptyState(
                      icon: Icons.favorite_border,
                      message: l10n.favoritesEmpty,
                    );
                  }
                  return ListView.builder(
                    itemCount: state.meals.length,
                    itemBuilder: (context, index) {
                      final meal = state.meals[index];
                      return ListItemTile(
                        imageUrl: meal.thumbnail,
                        title: meal.name,
                        subtitle: '${meal.category} • ${meal.area}',
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.mealDetails,
                          arguments: meal,
                        ),
                        trailing: IconButton(
                          tooltip: l10n.removeFromFavorites,
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                          onPressed: () =>
                              context.read<FavoritesCubit>().toggle(meal),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}