import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/datasources/meal_local_datasource.dart';
import 'package:streetbite/data/datasources/meal_remote_datasource.dart';

/// FACTORY PATTERN: the repository doesn't decide where meals come from;
/// it asks this factory. A fresh cache (under 30 minutes old) is used so the
/// app opens instantly; otherwise, or on pull-to-refresh, the API is used.
class MealDataSourceFactory {
  MealDataSourceFactory(this._remote, this._local);

  final MealRemoteDataSource _remote;
  final MealLocalDataSource _local;

  MealDataSource create({required bool forceRefresh}) {
    if (!forceRefresh && _local.hasFreshCache) return _local;
    return _remote;
  }
}