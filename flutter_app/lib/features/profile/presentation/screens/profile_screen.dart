import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/snackbar_extensions.dart';
import 'package:streetbite/core/widgets/hot_offer_card.dart';
import 'package:streetbite/core/widgets/section_title.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_state.dart';
import 'package:streetbite/features/favorites/presentation/blocs/favorites_cubit.dart';
import 'package:streetbite/features/favorites/presentation/blocs/favorites_state.dart';
import 'package:streetbite/features/orders/presentation/blocs/orders_cubit.dart';
import 'package:streetbite/features/orders/presentation/blocs/orders_state.dart';
import 'package:streetbite/features/orders/presentation/widgets/order_tile.dart';
import 'package:streetbite/features/profile/presentation/blocs/profile_cubit.dart';
import 'package:streetbite/features/profile/presentation/blocs/profile_state.dart';
import 'package:streetbite/features/profile/presentation/widgets/device_details_card.dart';
import 'package:streetbite/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:streetbite/features/profile/presentation/widgets/profile_header.dart';
import 'package:streetbite/features/profile/presentation/widgets/profile_row.dart';
import 'package:streetbite/features/settings/presentation/blocs/locale_cubit.dart';
import 'package:streetbite/features/settings/presentation/blocs/theme_bloc.dart';
import 'package:streetbite/features/settings/presentation/blocs/theme_event.dart';
import 'package:streetbite/injection.dart';

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
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? theme.colorScheme.surfaceContainerHighest
        : AppColors.grayLight;
    final grayStyle = theme.textTheme.bodyMedium?.copyWith(
      color: AppColors.grayDark,
    );
    final error = theme.colorScheme.error;

    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current.failure != null,
      listener: (context, state) {
        // Right after logout, Firestore can still report errors before this
        // screen closes. Only show failures while the user is signed in.
        if (context.read<AuthCubit>().state is Authenticated) {
          context.showFailure(state.failure!);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) =>
                  previous.photo != current.photo ||
                  previous.isUploading != current.isUploading,
              builder: (context, state) => ProfileHeader(
                name: name,
                email: email,
                photo: state.photo,
                isUploading: state.isUploading,
                onAvatarTap: () => context.read<ProfileCubit>().changePhoto(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) => _StatCard(
                        value: state.meals.length,
                        label: l10n.favoritesTitle,
                        color: cardColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) => _StatCard(
                        value: state.orders.length,
                        label: l10n.ordersTitle,
                        color: cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SectionTitle(l10n.favoritesTitle),
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state.meals.isEmpty) return _EmptyText(l10n.favoritesEmpty);
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
            SectionTitle(l10n.settingsTitle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ProfileRow(
                      icon: Icons.language,
                      title: l10n.profileLanguage,
                      trailing: Text(l10n.languageName, style: grayStyle),
                      onTap: () => context.read<LocaleCubit>().toggle(),
                    ),
                    const Divider(height: 1, indent: 64),
                    BlocBuilder<ThemeBloc, ThemeMode>(
                      builder: (context, mode) => ProfileRow(
                        icon: Icons.dark_mode_outlined,
                        title: l10n.profileDarkMode,
                        trailing: Switch(
                          value: mode == ThemeMode.dark,
                          onChanged: (_) => context.read<ThemeBloc>().add(
                            const ThemeToggled(),
                          ),
                        ),
                        onTap: () =>
                            context.read<ThemeBloc>().add(const ThemeToggled()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirmed = await confirmLogout(context);
                  if (confirmed && context.mounted) {
                    context.read<AuthCubit>().logout();
                  }
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.logoutButton),
                style: OutlinedButton.styleFrom(
                  foregroundColor: error,
                  side: BorderSide(color: error.withValues(alpha: 0.5)),
                  minimumSize: const Size.fromHeight(52),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            NumberFormat.decimalPattern(locale).format(value),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.grayDark,
            ),
          ),
        ],
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