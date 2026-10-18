import 'package:streetbite/features/home/domain/entities/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getMeals({bool forceRefresh = false});
}
