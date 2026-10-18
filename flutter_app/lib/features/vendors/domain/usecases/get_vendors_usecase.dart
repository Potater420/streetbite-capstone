import 'package:streetbite/features/vendors/domain/entities/vendor.dart';
import 'package:streetbite/features/vendors/domain/repositories/vendor_repository.dart';

class GetVendorsUseCase {
  GetVendorsUseCase(this._repository);
  final VendorRepository _repository;

  List<Vendor> call() => _repository.getVendors();
}
