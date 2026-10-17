import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
  });

  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;

  /// TheMealDB has no prices, so we derive a stable demo price from the id.
  double get price => 6 + ((int.tryParse(id) ?? 0) % 15) + 0.99;

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    area,
    instructions,
    thumbnail,
  ];
}
