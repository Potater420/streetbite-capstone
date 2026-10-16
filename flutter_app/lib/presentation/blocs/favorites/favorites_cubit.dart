import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/usecases/add_favorite_usecase.dart';
import 'package:streetbite/domain/usecases/remove_favorite_usecase.dart';
import 'package:streetbite/domain/usecases/watch_favorites_usecase.dart';
import 'package:streetbite/presentation/blocs/favorites/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._watchFavorites, this._addFavorite, this._removeFavorite)
      : super(const FavoritesState());

  final WatchFavoritesUseCase _watchFavorites;
  final AddFavoriteUseCase _addFavorite;
  final RemoveFavoriteUseCase _removeFavorite;

  StreamSubscription<List<Meal>>? _subscription;
  String? _uid;

  /// Starts listening to the signed-in user's favourites.
  void watch(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _subscription?.cancel();
    _subscription = _watchFavorites(uid).listen(
      (meals) => emit(FavoritesState(meals: meals)),
      onError: (Object error) {
        if (error is Failure) {
          emit(FavoritesState(meals: state.meals, failure: error));
        }
      },
    );
  }

  /// Stops listening and forgets the user (called on logout).
  void clear() {
    _subscription?.cancel();
    _subscription = null;
    _uid = null;
    emit(const FavoritesState());
  }

  Future<void> toggle(Meal meal) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      if (state.isFavorite(meal.id)) {
        await _removeFavorite(uid, meal.id);
      } else {
        await _addFavorite(uid, meal);
      }
    } on Failure catch (failure) {
      emit(FavoritesState(meals: state.meals, failure: failure));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}