import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';

// TEMPORARY: replaced by the real Home screen in Phase 3.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
        }
      },
      builder: (context, state) {
        final name = state is Authenticated ? state.user.name : '';
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.appName),
            actions: [
              IconButton(
                tooltip: context.l10n.logoutButton,
                icon: const Icon(Icons.logout),
                onPressed: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
          body: Center(
            child: Text(
              context.l10n.homeWelcome(name),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        );
      },
    );
  }
}