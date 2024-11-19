import 'package:flutter/material.dart';

enum TransportMode {
  driving,
  walking,
  biking,
}

class AppConstants {
  // App Information
  static const String appName = 'MealMatcher';
  
  // Travel Times (in minutes)
  static const int maxDrivingTime = 60;
  static const int maxBikingTime = 45;
  static const int maxWalkingTime = 30;
  
  // Default Values
  static const double defaultMaxDistance = 5.0;
  static const double maxSearchRadius = 20.0;

  // Price Ranges
  static const List<String> priceRanges = [
    '\$',
    '\$\$',
    '\$\$\$',
  ];

  // Colors
  static const Map<TransportMode, Color> transportModeColors = {
    TransportMode.driving: Colors.blue,
    TransportMode.walking: Colors.green,
    TransportMode.biking: Colors.orange,
  };

  // Icons
  static const Map<TransportMode, IconData> transportModeIcons = {
    TransportMode.driving: Icons.directions_car,
    TransportMode.walking: Icons.directions_walk,
    TransportMode.biking: Icons.directions_bike,
  };

  // Transport Mode Labels
  static const Map<TransportMode, String> transportModeLabels = {
    TransportMode.driving: 'Drive',
    TransportMode.walking: 'Walk',
    TransportMode.biking: 'Bike',
  };
}