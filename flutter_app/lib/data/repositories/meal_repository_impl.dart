import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/data/datasources/meal_local_datasource.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  MealRepositoryImpl(this._factory, this._local);

  final MealDataSourceFactory _factory;
  final MealLocalDataSource _local;

  @override
  Future<List<Meal>> getMeals({bool forceRefresh = false}) async {
    final source = _factory.create(forceRefresh: forceRefresh);
    try {
      final meals = await source.fetchMeals();
      // Only API results get saved; cached results are already saved.
      if (source is! MealLocalDataSource && meals.isNotEmpty) {
        await _local.cacheMeals(meals);
      }
      return meals;
    } catch (e) {
      // If the API fails (offline, timeout), fall back to older cached meals.
      final cached = await _local.fetchMeals();
      if (cached.isNotEmpty) return cached;
      throw ErrorHandler.handle(e);
    }
  }
}
