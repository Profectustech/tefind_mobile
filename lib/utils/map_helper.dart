import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// ========== GLOBALS ==============
ValueNotifier<Position?> currentPosition = ValueNotifier(null);
ValueNotifier<Address?> currentAddress = ValueNotifier(null);
bool isRequestingPermission = false;
bool locationServiceAlertShown = false;
bool locationPermissionAlertShown = false;

/// ========== LOGGER ===============
void logger(String message) => print("[LOG] $message");

/// ========== ALERT MOCK ============
Future<void> noPermissionAlert({required String title, required String message}) async {
  print("ALERT: $title\n$message");
}

/// ========== MODELS ===============
class Address {
  final double latitude;
  final double longitude;
  final String placeName;

  Address({
    required this.latitude,
    required this.longitude,
    required this.placeName,
  });
}

class Prediction {
  final String description;
  Prediction({required this.description});
  factory Prediction.fromJson(Map<String, dynamic> json) =>
      Prediction(description: json['description'] ?? '');
}

class DirectionDetails {
  String? distanceText;
  String? durationText;
  String? encodedPoints;
  int? distanceValue;
  int? durationValue;
}

/// ========== HTTP HELPER ============
class HttpHelper {
  final Dio _dio = Dio();

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      logger("HTTP GET Failed: $e");
      return Response(
        requestOptions: RequestOptions(path: url),
        data: 'failed',
        statusCode: 500,
      );
    }
  }
}

/// ========== CREDENTIALS ============
class Credentials {
  static const String googleApiKey = "AIzaSyBSzjGUZiQN3ixGLGVHs1p3o6mUm9GxYfs"; // Replace with your key
}

/// ========== DIALOG HELPER ============
class DialogHelper {
  void showHelpInfo({required String title, required String description}) {
    logger("DIALOG: $title - $description");
  }
}

/// ========== LANGUAGE STRINGS ============
class Lang {
  static const String locationPermission = "Location Permission";
  static const String needAccessToLocation = "Location access is required.";
}

/// ========== MAP HELPER ============
class MapHelper {
  final HttpHelper _http = HttpHelper();

  Future<bool> getLocationPermission({bool mustShowErrMessage = false}) async {
    logger('Checking location permission...');
    if (isRequestingPermission) return true;

    if (!(await Geolocator.isLocationServiceEnabled())) {
      logger('Location services disabled.');
      if (locationServiceAlertShown && !mustShowErrMessage) return false;
      locationServiceAlertShown = true;
      DialogHelper().showHelpInfo(
        title: 'Enable Location Services',
        description: 'Please turn on location services.',
      );
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        logger('Location permission denied.');
        if (locationPermissionAlertShown && !mustShowErrMessage) return false;
        locationPermissionAlertShown = true;
        await noPermissionAlert(
          title: Lang.locationPermission,
          message: Lang.needAccessToLocation,
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      logger('Location permission permanently denied.');
      if (locationPermissionAlertShown) return false;
      locationPermissionAlertShown = true;
      await noPermissionAlert(
        title: Lang.locationPermission,
        message: Lang.needAccessToLocation,
      );
      return false;
    }

    return true;
  }

  Future<void> setCurrentLocation({bool updateAddress = true}) async {
    bool positionChanged = false;

    try {
      if (!await getLocationPermission()) return;

      currentPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      positionChanged = true;

      currentAddress.value = Address(
        latitude: currentPosition.value!.latitude,
        longitude: currentPosition.value!.longitude,
        placeName: 'Current Location',
      );
    } catch (e) {
      logger('Error getting location: $e');
    }

    if (!updateAddress) return;

    if (positionChanged) {
      final address = await MapHelper.findCoordinateAddress(currentPosition.value!);
      if (address != null) currentAddress.value = address;
    }
  }

  static Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      } else {
        return "No address found";
      }
    } catch (e) {
      return "Failed to get address";
    }
  }

  static final Map<String, Address> _cache = {};

  static Future<Address?> findCoordinateAddress(Position position) async {
    final key = "${position.latitude},${position.longitude}";
    if (_cache.containsKey(key)) return _cache[key];

    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$key&key=${Credentials.googleApiKey}";

    final response = await HttpHelper().get(url);

    if (response.statusCode == 200 && response.data != 'failed') {
      final formatted = response.data['results'][0]['formatted_address'];

      final address = Address(
        latitude: position.latitude,
        longitude: position.longitude,
        placeName: formatted,
      );

      _cache[key] = address;
      return address;
    }

    return null;
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}

