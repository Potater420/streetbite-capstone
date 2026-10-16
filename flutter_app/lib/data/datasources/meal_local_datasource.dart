import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

/// Meals cached on the device with shared_preferences.
class MealLocalDataSource implements MealDataSource {
  MealLocalDataSource(this._prefs);
  final SharedPreferences _prefs;

  bool get hasFreshCache {
    final savedAt = _prefs.getInt(AppConstants.cachedMealsTimeKey);
    if (savedAt == null || !_prefs.containsKey(AppConstants.cachedMealsKey)) {
      return false;
    }
    final age = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(savedAt),
    );
    return age < AppConstants.cacheTtl;
  }

  @override
  Future<List<MealModel>> fetchMeals() async {
    final raw = _prefs.getString(AppConstants.cachedMealsKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> cacheMeals(List<MealModel> meals) async {
    await _prefs.setString(
      AppConstants.cachedMealsKey,
      jsonEncode(meals.map((m) => m.toJson()).toList()),
    );
    await _prefs.setInt(
      AppConstants.cachedMealsTimeKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}