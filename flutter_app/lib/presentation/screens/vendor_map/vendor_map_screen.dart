import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/vendor.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/vendors/vendors_cubit.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});

  // Centered on Egypt so all six cities are visible at once.
  static const _initialCamera = CameraPosition(
    target: LatLng(27.0, 30.8),
    zoom: 5.4,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final ratingFormat = NumberFormat('0.0', locale.toString());

    return BlocProvider(
      create: (_) => sl<VendorsCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.nearbyVendorsTitle)),
        body: BlocBuilder<VendorsCubit, List<Vendor>>(
          builder: (context, vendors) {
            final markers = vendors.map((vendor) {
              return Marker(
                markerId: MarkerId(vendor.id),
                position: LatLng(vendor.latitude, vendor.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ),
                // Info window: vendor name, cuisine type and rating.
                infoWindow: InfoWindow(
                  title: vendor.name(locale.languageCode),
                  snippet: l10n.vendorInfoSnippet(
                    vendor.cuisine(locale.languageCode),
                    ratingFormat.format(vendor.rating),
                  ),
                ),
              );
            }).toSet();

            return GoogleMap(
              initialCameraPosition: _initialCamera,
              markers: markers,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
            );
          },
        ),
      ),
    );
  }
}