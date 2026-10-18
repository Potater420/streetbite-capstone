import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_cubit.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_state.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/orders/orders_cubit.dart';
import 'package:streetbite/presentation/blocs/orders/orders_state.dart';
import 'package:streetbite/presentation/blocs/profile/profile_cubit.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';
import 'package:streetbite/presentation/blocs/theme/theme_event.dart';
import 'package:streetbite/presentation/widgets/device_details_card.dart';
import 'package:streetbite/presentation/widgets/hot_offer_card.dart';
import 'package:streetbite/presentation/widgets/order_tile.dart';
import 'package:streetbite/presentation/widgets/profile_avatar.dart';
import 'package:streetbite/presentation/widgets/profile_row.dart';
import 'package:streetbite/presentation/widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state;
    if (auth is! Authenticated) return const SizedBox.shrink();

    return BlocProvider(
      create: (_) => sl<ProfileCubit>()..start(auth.user.uid),
      child: _ProfileView(name: auth.user.name, email: auth.user.email),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final grayStyle = theme.textTheme.bodyMedium?.copyWith(
      color: AppColors.grayDark,
    );

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current.failure != null,
      listener: (context, state) => context.showFailure(state.failure!),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                          previous.photo != current.photo ||
                          previous.isUploading != current.isUploading,
                      builder: (context, state) => ProfileAvatar(
                        photo: state.photo,
                        isUploading: state.isUploading,
                        onTap: () => context.read<ProfileCubit>().changePhoto(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(email, style: grayStyle),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ProfileRow(
                icon: Icons.language,
                title: l10n.profileLanguage,
                trailing: Text(l10n.languageName, style: grayStyle),
                onTap: () => context.read<LocaleCubit>().toggle(),
              ),
              BlocBuilder<ThemeBloc, ThemeMode>(
                builder: (context, mode) => ProfileRow(
                  icon: Icons.dark_mode_outlined,
                  title: l10n.profileDarkMode,
                  trailing: Switch(
                    value: mode == ThemeMode.dark,
                    onChanged: (_) =>
                        context.read<ThemeBloc>().add(const ThemeToggled()),
                  ),
                  onTap: () =>
                      context.read<ThemeBloc>().add(const ThemeToggled()),
                ),
              ),
              ProfileRow(
                icon: Icons.logout,
                title: l10n.logoutButton,
                color: theme.colorScheme.error,
                onTap: () => context.read<AuthCubit>().logout(),
              ),
              SectionTitle(l10n.favoritesTitle),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state.meals.isEmpty) {
                    return _EmptyText(l10n.favoritesEmpty);
                  }
                  return SizedBox(
                    height: 252,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.meals.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.mealDetails,
                            arguments: meal,
                          ),
                          child: HotOfferCard(meal: meal),
                        );
                      },
                    ),
                  );
                },
              ),
              SectionTitle(l10n.recentOrdersTitle),
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state.orders.isEmpty) return _EmptyText(l10n.ordersEmpty);
                  return Column(
                    children: [
                      for (final order in state.orders.take(3))
                        OrderTile(order: order),
                    ],
                  );
                },
              ),
              SectionTitle(l10n.deviceDetailsTitle),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.device != current.device,
                builder: (context, state) =>
                    DeviceDetailsCard(details: state.device),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.grayDark),
      ),
    );
  }
}