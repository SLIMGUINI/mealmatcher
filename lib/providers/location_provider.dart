import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _error;
  bool _isLoading = false;

  Position? get currentPosition => _currentPosition;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> getCurrentLocation() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permissions are permanently denied, cannot request permissions.');
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Calculate distance between two points
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1609.34; // Convert to miles
  }
}