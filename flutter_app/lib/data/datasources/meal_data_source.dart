import 'package:streetbite/data/models/meal_model.dart';

/// Common interface for every place meals can come from.
abstract class MealDataSource {
  Future<List<MealModel>> fetchMeals();
}