import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';

class WatchFavoritesUseCase {
  WatchFavoritesUseCase(this._repository);
  final FavoritesRepository _repository;

  Stream<List<Meal>> call(String uid) => _repository.watchFavorites(uid);
}
