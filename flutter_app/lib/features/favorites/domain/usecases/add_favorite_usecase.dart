import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavoriteUseCase {
  AddFavoriteUseCase(this._repository);
  final FavoritesRepository _repository;

  Future<void> call(String uid, Meal meal) =>
      _repository.addFavorite(uid, meal);
}
