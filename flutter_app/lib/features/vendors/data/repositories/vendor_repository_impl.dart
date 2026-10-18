import 'package:streetbite/features/vendors/data/datasources/vendors_local_datasource.dart';
import 'package:streetbite/features/vendors/domain/entities/vendor.dart';
import 'package:streetbite/features/vendors/domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  VendorRepositoryImpl(this._dataSource);

  final VendorsLocalDataSource _dataSource;

  @override
  List<Vendor> getVendors() => _dataSource.getVendors();
}
