import 'dart:async';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/home/data/models/meal_model.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._service);

  final FirestoreService _service;

  @override
  Stream<List<Meal>> watchFavorites(String uid) {
    // Stream errors are converted to Failures, like in the other repositories.
    return _service
        .watchFavorites(uid)
        .transform(
          StreamTransformer<List<MealModel>, List<Meal>>.fromHandlers(
            handleData: (meals, sink) => sink.add(meals),
            handleError: (error, stackTrace, sink) =>
                sink.addError(ErrorHandler.handle(error), stackTrace),
          ),
        );
  }

  @override
  Future<void> addFavorite(String uid, Meal meal) async {
    try {
      await _service.addFavorite(uid, MealModel.fromEntity(meal));
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> removeFavorite(String uid, String mealId) async {
    try {
      await _service.removeFavorite(uid, mealId);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
