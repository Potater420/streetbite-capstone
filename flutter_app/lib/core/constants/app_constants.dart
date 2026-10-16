class AppConstants {
  AppConstants._();

  static const String mealsBaseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const String cachedMealsKey = 'cached_meals';
  static const String cachedMealsTimeKey = 'cached_meals_time';
  static const Duration cacheTtl = Duration(minutes: 30);
}