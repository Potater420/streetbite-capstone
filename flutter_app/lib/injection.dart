import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/home/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/features/home/data/datasources/meal_local_datasource.dart';
import 'package:streetbite/features/home/data/datasources/meal_remote_datasource.dart';
import 'package:streetbite/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:streetbite/features/home/data/repositories/meal_repository_impl.dart';
import 'package:streetbite/features/auth/domain/repositories/auth_repository.dart';
import 'package:streetbite/features/home/domain/repositories/meal_repository.dart';
import 'package:streetbite/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:streetbite/features/home/domain/usecases/get_meals_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/login_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/logout_usecase.dart';
import 'package:streetbite/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:streetbite/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/settings/presentation/blocs/locale_cubit.dart';
import 'package:streetbite/features/home/presentation/blocs/meals_cubit.dart';
import 'package:streetbite/features/settings/presentation/blocs/theme_bloc.dart';
import 'package:streetbite/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:streetbite/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:streetbite/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:streetbite/features/favorites/domain/usecases/watch_favorites_usecase.dart';
import 'package:streetbite/features/favorites/presentation/blocs/favorites_cubit.dart';
import 'package:streetbite/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:streetbite/features/orders/domain/repositories/orders_repository.dart';
import 'package:streetbite/features/orders/domain/usecases/place_order_usecase.dart';
import 'package:streetbite/features/orders/presentation/blocs/checkout_cubit.dart';
import 'package:streetbite/features/orders/domain/usecases/watch_orders_usecase.dart';
import 'package:streetbite/features/orders/presentation/blocs/orders_cubit.dart';
import 'package:streetbite/features/profile/data/datasources/device_datasource.dart';
import 'package:streetbite/features/profile/data/repositories/device_repository_impl.dart';
import 'package:streetbite/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:streetbite/features/profile/domain/repositories/device_repository.dart';
import 'package:streetbite/features/profile/domain/repositories/profile_repository.dart';
import 'package:streetbite/features/profile/domain/usecases/authenticate_with_biometrics_usecase.dart';
import 'package:streetbite/features/profile/domain/usecases/get_device_details_usecase.dart';
import 'package:streetbite/features/profile/domain/usecases/update_profile_photo_usecase.dart';
import 'package:streetbite/features/profile/domain/usecases/watch_profile_photo_usecase.dart';
import 'package:streetbite/features/profile/presentation/blocs/profile_cubit.dart';
import 'package:streetbite/features/vendors/data/datasources/vendors_local_datasource.dart';
import 'package:streetbite/features/vendors/data/repositories/vendor_repository_impl.dart';
import 'package:streetbite/features/vendors/domain/repositories/vendor_repository.dart';
import 'package:streetbite/features/vendors/domain/usecases/get_vendors_usecase.dart';
import 'package:streetbite/features/vendors/presentation/blocs/vendors_cubit.dart';

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

  // Profile and device features
  sl.registerLazySingleton(() => DeviceDataSource());
  sl.registerLazySingleton<DeviceRepository>(() => DeviceRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => AuthenticateWithBiometricsUseCase(sl()));
  sl.registerLazySingleton(() => GetDeviceDetailsUseCase(sl()));
  sl.registerLazySingleton(() => WatchProfilePhotoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfilePhotoUseCase(sl(), sl()));

  // Vendors
  sl.registerLazySingleton(() => VendorsLocalDataSource());
  sl.registerLazySingleton<VendorRepository>(() => VendorRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetVendorsUseCase(sl()));

  // State
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MealsCubit(sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => FavoritesCubit(sl(), sl(), sl()));
  sl.registerFactory(() => CheckoutCubit(sl()));
  sl.registerFactory(() => OrdersCubit(sl()));
  sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));
  sl.registerFactory(() => VendorsCubit(sl()));
}
