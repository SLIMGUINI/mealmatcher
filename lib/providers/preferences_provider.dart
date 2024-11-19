import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class PreferencesProvider with ChangeNotifier {
  TransportMode _transportMode = TransportMode.driving;
  int _maxTravelTime = 30;

  TransportMode get transportMode => _transportMode;
  int get maxTravelTime => _maxTravelTime;

  void setTransportMode(TransportMode mode) {
    _transportMode = mode;
    notifyListeners();
  }

  void setMaxTravelTime(int minutes) {
    _maxTravelTime = minutes;
    notifyListeners();
  }

  int getMaxTimeForMode(TransportMode mode) {
    switch (mode) {
      case TransportMode.driving:
        return AppConstants.maxDrivingTime;
      case TransportMode.biking:
        return AppConstants.maxBikingTime;
      case TransportMode.walking:
        return AppConstants.maxWalkingTime;
    }
  }
}