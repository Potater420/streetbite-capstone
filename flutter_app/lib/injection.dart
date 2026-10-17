import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/data/datasources/auth_remote_datasource.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/data/datasources/meal_local_datasource.dart';
import 'package:streetbite/data/datasources/meal_remote_datasource.dart';
import 'package:streetbite/data/repositories/auth_repository_impl.dart';
import 'package:streetbite/data/repositories/meal_repository_impl.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';
import 'package:streetbite/domain/usecases/get_current_user_usecase.dart';
import 'package:streetbite/domain/usecases/get_meals_usecase.dart';
import 'package:streetbite/domain/usecases/login_usecase.dart';
import 'package:streetbite/domain/usecases/logout_usecase.dart';
import 'package:streetbite/domain/usecases/sign_up_usecase.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_cubit.dart';
import 'package:streetbite/presentation/blocs/meals/meals_cubit.dart';
import 'package:streetbite/presentation/blocs/theme/theme_bloc.dart';
import 'package:streetbite/data/repositories/favorites_repository_impl.dart';
import 'package:streetbite/domain/repositories/favorites_repository.dart';
import 'package:streetbite/domain/usecases/add_favorite_usecase.dart';
import 'package:streetbite/domain/usecases/remove_favorite_usecase.dart';
import 'package:streetbite/domain/usecases/watch_favorites_usecase.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_cubit.dart';
import 'package:streetbite/data/repositories/orders_repository_impl.dart';
import 'package:streetbite/domain/repositories/orders_repository.dart';
import 'package:streetbite/domain/usecases/place_order_usecase.dart';
import 'package:streetbite/presentation/blocs/checkout/checkout_cubit.dart';
import 'package:streetbite/domain/usecases/watch_orders_usecase.dart';
import 'package:streetbite/presentation/blocs/orders/orders_cubit.dart';

/// Service locator (GetIt) used for dependency injection.
/// Classes get their dependencies from here instead of creating them,
/// which keeps layers decoupled and makes testing easy.
final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // External services
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService.instance);
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.mealsBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  // Auth
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // Meals
  sl.registerLazySingleton(() => MealRemoteDataSource(sl()));
  sl.registerLazySingleton(() => MealLocalDataSource(sl()));
  sl.registerLazySingleton(() => MealDataSourceFactory(sl(), sl()));
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetMealsUseCase(sl()));

  // Favourites
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => WatchFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteUseCase(sl()));

  // Orders
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(sl()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerLazySingleton(() => WatchOrdersUseCase(sl()));

  // State
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MealsCubit(sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => FavoritesCubit(sl(), sl(), sl()));
  sl.registerFactory(() => CheckoutCubit(sl()));
  sl.registerFactory(() => OrdersCubit(sl()));
}
