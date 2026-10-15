import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:streetbite/data/datasources/auth_remote_datasource.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/repositories/auth_repository_impl.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';
import 'package:streetbite/domain/usecases/get_current_user_usecase.dart';
import 'package:streetbite/domain/usecases/login_usecase.dart';
import 'package:streetbite/domain/usecases/logout_usecase.dart';
import 'package:streetbite/domain/usecases/sign_up_usecase.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';

/// Service locator (GetIt) used for dependency injection.
/// Classes get their dependencies from here instead of creating them,
/// which keeps layers decoupled and makes testing easy.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // External services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService.instance);

  // Data layer
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // State
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
}