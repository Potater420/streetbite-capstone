import 'package:get_it/get_it.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';

/// Service locator (GetIt) used for dependency injection.
/// Classes get their dependencies from here instead of creating them,
/// which keeps layers decoupled and makes testing easy.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => LocaleCubit());
}