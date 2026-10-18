import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/domain/entities/vendor.dart';
import 'package:streetbite/domain/usecases/get_vendors_usecase.dart';

/// The state is simply the list of vendors (hardcoded, so no loading state).
class VendorsCubit extends Cubit<List<Vendor>> {
  VendorsCubit(GetVendorsUseCase getVendors) : super(getVendors());
}
