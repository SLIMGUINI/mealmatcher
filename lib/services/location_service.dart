import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission != LocationPermission.denied && 
           permission != LocationPermission.deniedForever;
  }

  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      if (!await hasLocationPermission()) {
        return null;
      }
      if (!await isLocationEnabled()) {
        return null;
      }
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
    } catch (e) {
      return null;
    }
  }
}