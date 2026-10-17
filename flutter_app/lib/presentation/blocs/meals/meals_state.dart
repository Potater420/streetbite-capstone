import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/meal.dart';

sealed class MealsState {
  const MealsState();
}

class MealsLoading extends MealsState {
  const MealsLoading();
}

class MealsError extends MealsState {
  const MealsError(this.failure);
  final Failure failure;
}

class MealsLoaded extends MealsState {
  const MealsLoaded({required this.meals, this.query = '', this.category});

  final List<Meal> meals;
  final String query;
  final String? category; // null means "All"

  /// First four meals feed the banner, the next five are the Hot Offers.
  List<Meal> get featured => meals.take(4).toList();
  List<Meal> get hotOffers => meals.skip(4).take(5).toList();

  List<String> get categories =>
      meals.map((m) => m.category).where((c) => c.isNotEmpty).toSet().toList();

  List<Meal> get filtered {
    final q = query.trim().toLowerCase();
    return meals.where((m) {
      final matchesCategory = category == null || m.category == category;
      final matchesQuery = q.isEmpty || m.name.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  MealsLoaded copyWith({
    List<Meal>? meals,
    String? query,
    String? category,
    bool clearCategory = false,
  }) {
    return MealsLoaded(
      meals: meals ?? this.meals,
      query: query ?? this.query,
      category: clearCategory ? null : (category ?? this.category),
    );
  }
}
