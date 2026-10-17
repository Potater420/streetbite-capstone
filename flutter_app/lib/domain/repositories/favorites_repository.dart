import 'package:streetbite/domain/entities/meal.dart';

abstract class FavoritesRepository {
  /// Live list of the user's favourite meals.
  Stream<List<Meal>> watchFavorites(String uid);

  Future<void> addFavorite(String uid, Meal meal);

  Future<void> removeFavorite(String uid, String mealId);
}
