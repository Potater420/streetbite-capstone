import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';
import 'package:streetbite/presentation/blocs/theme/theme_event.dart';

// TEMPORARY: replaced by the real animated splash in Phase 2.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeBloc>().add(const ThemeToggled()),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LocaleCubit>().toggle(),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.l10n.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}