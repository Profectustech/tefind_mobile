import 'package:geolocator/geolocator.dart';
import 'CustomerAddressModel.dart';
class LocationState {
  final Position? position;
  final CustomerAddress? address;
  final bool isLoading;

  const LocationState({
    this.position,
    this.address,
    this.isLoading = false,
  });

  LocationState copyWith({
    Position? position,
    CustomerAddress? address,
    bool? isLoading,
  }) {
    return LocationState(
      position: position ?? this.position,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
