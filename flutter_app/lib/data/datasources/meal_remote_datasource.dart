import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

class MealRemoteDataSource implements MealDataSource {
  MealRemoteDataSource(this._dio);
  final Dio _dio;

  @override
  Future<List<MealModel>> fetchMeals() async {
    // search.php?s= only returns 25 meals, so request every first letter.
    final letters = List.generate(26, (i) => String.fromCharCode(97 + i));
    final results = await Future.wait(letters.map(_fetchByLetter));

    final byId = <String, MealModel>{};
    for (final meals in results) {
      for (final meal in meals) {
        byId[meal.id] = meal;
      }
    }
    return byId.values.toList();
  }

  Future<List<MealModel>> _fetchByLetter(String letter) async {
    final response = await _dio.get<dynamic>(
      'search.php',
      queryParameters: {'f': letter},
    );
    final raw = response.data;
    final json = raw is String
        ? jsonDecode(raw) as Map<String, dynamic>
        : raw as Map<String, dynamic>;
    // Letters with no meals return `null`, which becomes an empty list.
    final meals = json['meals'] as List<dynamic>? ?? [];
    return meals
        .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
