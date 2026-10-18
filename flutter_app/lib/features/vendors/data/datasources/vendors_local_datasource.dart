import 'package:streetbite/features/vendors/domain/entities/vendor.dart';

/// Hardcoded vendors (fictional), one per city, as the brief requires.
class VendorsLocalDataSource {
  List<Vendor> getVendors() => const [
    Vendor(
      id: 'cairo',
      nameEn: 'Downtown Koshary Cart',
      nameAr: 'عربة كشري وسط البلد',
      cuisineEn: 'Koshary',
      cuisineAr: 'كشري',
      rating: 4.7,
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    Vendor(
      id: 'alexandria',
      nameEn: 'Corniche Grill',
      nameAr: 'شواية الكورنيش',
      cuisineEn: 'Seafood',
      cuisineAr: 'مأكولات بحرية',
      rating: 4.5,
      latitude: 31.2001,
      longitude: 29.9187,
    ),
    Vendor(
      id: 'tanta',
      nameEn: 'Tanta Fiteer House',
      nameAr: 'بيت الفطير بطنطا',
      cuisineEn: 'Fiteer',
      cuisineAr: 'فطير',
      rating: 4.6,
      latitude: 30.7865,
      longitude: 31.0004,
    ),
    Vendor(
      id: 'mansoura',
      nameEn: 'Mansoura Falafel Stand',
      nameAr: 'فلافل المنصورة',
      cuisineEn: 'Falafel',
      cuisineAr: 'فلافل',
      rating: 4.4,
      latitude: 31.0409,
      longitude: 31.3785,
    ),
    Vendor(
      id: 'luxor',
      nameEn: 'Luxor Nile Shawarma',
      nameAr: 'شاورما النيل بالأقصر',
      cuisineEn: 'Shawarma',
      cuisineAr: 'شاورما',
      rating: 4.3,
      latitude: 25.6872,
      longitude: 32.6396,
    ),
    Vendor(
      id: 'aswan',
      nameEn: 'Aswan Sweets Cart',
      nameAr: 'عربة حلويات أسوان',
      cuisineEn: 'Desserts',
      cuisineAr: 'حلويات',
      rating: 4.8,
      latitude: 24.0889,
      longitude: 32.8998,
    ),
  ];
}
