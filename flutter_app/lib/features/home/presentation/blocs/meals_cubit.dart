import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/home/domain/usecases/get_meals_usecase.dart';
import 'package:streetbite/features/home/presentation/blocs/meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit(this._getMeals) : super(const MealsLoading());

  final GetMealsUseCase _getMeals;

  Future<void> load({bool forceRefresh = false}) async {
    final previous = state;
    // Pull-to-refresh keeps the current content visible while loading.
    if (!forceRefresh) emit(const MealsLoading());
    try {
      final meals = await _getMeals(forceRefresh: forceRefresh);
      emit(
        previous is MealsLoaded
            ? previous.copyWith(meals: meals)
            : MealsLoaded(meals: meals),
      );
    } on Failure catch (failure) {
      emit(MealsError(failure));
    }
  }

  void search(String query) {
    final current = state;
    if (current is MealsLoaded) emit(current.copyWith(query: query));
  }

  void selectCategory(String? category) {
    final current = state;
    if (current is MealsLoaded) {
      emit(
        current.copyWith(category: category, clearCategory: category == null),
      );
    }
  }
}
