import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure_message.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_state.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_event.dart';
import 'package:streetbite/features/settings/presentation/blocs/locale_cubit.dart';
import 'package:streetbite/features/home/presentation/blocs/meals_cubit.dart';
import 'package:streetbite/features/home/presentation/blocs/meals_state.dart';
import 'package:streetbite/features/settings/presentation/blocs/theme_bloc.dart';
import 'package:streetbite/features/settings/presentation/blocs/theme_event.dart';
import 'package:streetbite/features/cart/presentation/widgets/cart_icon_button.dart';
import 'package:streetbite/features/home/presentation/widgets/category_selector.dart';
import 'package:streetbite/core/widgets/error_view.dart';
import 'package:streetbite/features/home/presentation/widgets/featured_banner.dart';
import 'package:streetbite/features/home/presentation/widgets/home_search_bar.dart';
import 'package:streetbite/features/home/presentation/widgets/hot_offers_section.dart';
import 'package:streetbite/features/home/presentation/widgets/meal_card.dart';
import 'package:streetbite/features/home/presentation/widgets/nearby_vendors_button.dart';
import 'package:streetbite/core/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider(
      create: (_) => sl<MealsCubit>()..load(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 20,
            title: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => Text(
                l10n.homeGreeting(
                  state is Authenticated ? state.user.name : '',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              IconButton(
                tooltip: l10n.changeLanguage,
                icon: const Icon(Icons.language),
                onPressed: () => context.read<LocaleCubit>().toggle(),
              ),
              BlocBuilder<ThemeBloc, ThemeMode>(
                builder: (context, mode) => IconButton(
                  tooltip: l10n.toggleTheme,
                  icon: Icon(
                    mode == ThemeMode.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                  ),
                  onPressed: () =>
                      context.read<ThemeBloc>().add(const ThemeToggled()),
                ),
              ),
              CartIconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.cart),
              ),
            ],
          ),
          body: BlocBuilder<MealsCubit, MealsState>(
            builder: (context, state) => switch (state) {
              MealsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              MealsError error => ErrorView(
                message: error.failure.localized(l10n),
                onRetry: () => context.read<MealsCubit>().load(),
              ),
              MealsLoaded loaded => _MealsContent(state: loaded),
            },
          ),
        ),
      ),
    );
  }
}

class _MealsContent extends StatelessWidget {
  const _MealsContent({required this.state});

  final MealsLoaded state;

  void _addToCart(BuildContext context, Meal meal) {
    context.read<CartBloc>().add(CartItemAdded(meal));
    context.showMessage(
      context.l10n.addedToCart(meal.name),
      duration: const Duration(seconds: 2),
    );
  }

  void _openDetails(BuildContext context, Meal meal) {
    Navigator.of(context).pushNamed(AppRoutes.mealDetails, arguments: meal);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MealsCubit>();
    final meals = state.filtered;

    // MediaQuery drives the grid so cards fit any screen width.
    const horizontalPadding = 20.0;
    const spacing = 16.0;
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = (width - horizontalPadding * 2 - spacing) / 2;

    return RefreshIndicator(
      onRefresh: () => cubit.load(forceRefresh: true),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 4,
                  ),
                  child: HomeSearchBar(onChanged: cubit.search),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: NearbyVendorsButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.vendorMap),
                  ),
                ),
                CategorySelector(
                  categories: state.categories,
                  selected: state.category,
                  onSelected: cubit.selectCategory,
                ),
                FeaturedBanner(
                  meals: state.featured,
                  onMealTap: (meal) => _openDetails(context, meal),
                ),
                HotOffersSection(
                  meals: state.hotOffers,
                  onMealTap: (meal) => _openDetails(context, meal),
                ),
                SectionTitle(context.l10n.allMealsTitle),
              ],
            ),
          ),
          if (meals.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Center(child: Text(context.l10n.noMealsFound)),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                horizontalPadding,
                24,
              ),
              sliver: SliverGrid.builder(
                itemCount: meals.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: cardWidth / (cardWidth + 100),
                ),
                itemBuilder: (context, index) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openDetails(context, meals[index]),
                  child: MealCard(
                    meal: meals[index],
                    onAdd: () => _addToCart(context, meals[index]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
