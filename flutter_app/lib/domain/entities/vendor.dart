import 'package:equatable/equatable.dart';

class Vendor extends Equatable {
  const Vendor({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.cuisineEn,
    required this.cuisineAr,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String cuisineEn;
  final String cuisineAr;
  final double rating;
  final double latitude;
  final double longitude;

  String name(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;

  String cuisine(String languageCode) =>
      languageCode == 'ar' ? cuisineAr : cuisineEn;

  @override
  List<Object?> get props => [id, nameEn, nameAr, cuisineEn, cuisineAr, rating];
}