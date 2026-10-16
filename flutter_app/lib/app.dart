import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/router/app_router.dart';
import 'package:streetbite/core/router/app_routes.dart';
import 'package:streetbite/core/theme/app_theme.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/l10n/app_localizations.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeBloc>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<CartBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                onGenerateTitle: (context) => context.l10n.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: AppRoutes.splash,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}