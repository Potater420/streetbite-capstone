import 'package:streetbite/domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.instructions,
    required super.thumbnail,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
    id: json['idMeal'] as String? ?? '',
    name: json['strMeal'] as String? ?? '',
    category: json['strCategory'] as String? ?? '',
    area: json['strArea'] as String? ?? '',
    instructions: json['strInstructions'] as String? ?? '',
    thumbnail: json['strMealThumb'] as String? ?? '',
  );

  factory MealModel.fromEntity(Meal meal) => MealModel(
    id: meal.id,
    name: meal.name,
    category: meal.category,
    area: meal.area,
    instructions: meal.instructions,
    thumbnail: meal.thumbnail,
  );

  /// Uses the API's own keys, so cached JSON is read back by [fromJson].
  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strCategory': category,
    'strArea': area,
    'strInstructions': instructions,
    'strMealThumb': thumbnail,
  };
}
