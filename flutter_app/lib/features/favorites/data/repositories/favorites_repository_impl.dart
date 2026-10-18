import 'dart:async';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:streetbite/features/home/data/models/meal_model.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._service);

  final FirestoreService _service;

  /// Favourites are a map field in the user's document, keyed by meal id.
  static const _field = 'favorites';

  @override
  Stream<List<Meal>> watchFavorites(String uid) {
    // Stream errors are converted to Failures, like in the other repositories.
    return _service
        .watchUserData(uid)
        .transform(
          StreamTransformer<Map<String, dynamic>?, List<Meal>>.fromHandlers(
            handleData: (data, sink) {
              try {
                final favorites = (data?[_field] as Map<String, dynamic>?) ?? {};
                final meals = favorites.values
                    .map(
                      (e) => MealModel.fromJson(
                        Map<String, dynamic>.from(e as Map),
                      ),
                    )
                    .toList();
                meals.sort((a, b) => a.name.compareTo(b.name));
                sink.add(meals);
              } catch (e) {
                sink.addError(ErrorHandler.handle(e));
              }
            },
            handleError: (error, stackTrace, sink) =>
                sink.addError(ErrorHandler.handle(error), stackTrace),
          ),
        );
  }

  @override
  Future<void> addFavorite(String uid, Meal meal) async {
    try {
      await _service.setUserData(uid, {
        _field: {meal.id: MealModel.fromEntity(meal).toJson()},
      });
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> removeFavorite(String uid, String mealId) async {
    try {
      await _service.removeUserMapEntry(uid, _field, mealId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}