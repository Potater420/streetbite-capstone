import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

class MealRemoteDataSource implements MealDataSource {
  MealRemoteDataSource(this._dio);
  final Dio _dio;

  @override
  Future<List<MealModel>> fetchMeals() async {
    // An empty search term returns the first 25 meals.
    final response = await _dio.get<dynamic>(
      'search.php',
      queryParameters: {'s': ''},
    );
    final raw = response.data;
    final json = raw is String
        ? jsonDecode(raw) as Map<String, dynamic>
        : raw as Map<String, dynamic>;
    final meals = json['meals'] as List<dynamic>? ?? [];
    return meals
        .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}