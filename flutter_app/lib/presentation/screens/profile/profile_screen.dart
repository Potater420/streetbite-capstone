import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/widgets/screen_title.dart';

// TEMPORARY: replaced by the real Profile screen in Part B.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.watch<AuthCubit>().state is Authenticated
        ? (context.watch<AuthCubit>().state as Authenticated).user
        : null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(l10n.navProfile),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    user?.email ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.grayDark),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => context.read<AuthCubit>().logout(),
                    icon: const Icon(Icons.logout),
                    label: Text(l10n.logoutButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}