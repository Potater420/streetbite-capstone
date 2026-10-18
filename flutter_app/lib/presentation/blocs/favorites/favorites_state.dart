import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/meal.dart';

// No Equatable on purpose: every emission is a new state, so repeated
// errors still show their SnackBar.
class FavoritesState {
  const FavoritesState({this.meals = const [], this.failure});

  final List<Meal> meals;
  final Failure? failure;

  bool isFavorite(String mealId) => meals.any((m) => m.id == mealId);
}
