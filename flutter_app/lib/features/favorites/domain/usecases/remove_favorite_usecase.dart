import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {
  RemoveFavoriteUseCase(this._repository);
  final FavoritesRepository _repository;

  Future<void> call(String uid, String mealId) =>
      _repository.removeFavorite(uid, mealId);
}
