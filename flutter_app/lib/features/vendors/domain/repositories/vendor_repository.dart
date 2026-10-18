import 'package:streetbite/features/vendors/domain/entities/vendor.dart';

abstract class VendorRepository {
  List<Vendor> getVendors();
}
