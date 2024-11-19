import 'package:mealmatcher/constants/app_constants.dart';
import 'travel_times.dart';

class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final List<String> priceRange;
  final String address;
  final TravelTimes travelTimes;
  final double lat;
  final double lng;
  final String imageUrl;
  final bool isOpenNow;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.priceRange,
    required this.address,
    required this.travelTimes,
    required this.lat,
    required this.lng,
    required this.imageUrl,
    this.isOpenNow = true,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      cuisine: json['cuisine'] as String,
      rating: (json['rating'] as num).toDouble(),
      priceRange: List<String>.from(json['priceRange'] as List),
      address: json['address'] as String,
      travelTimes: TravelTimes.fromJson(json['travelTimes'] as Map<String, dynamic>),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isOpenNow: json['isOpenNow'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'rating': rating,
      'priceRange': priceRange,
      'address': address,
      'travelTimes': travelTimes.toJson(),
      'lat': lat,
      'lng': lng,
      'imageUrl': imageUrl,
      'isOpenNow': isOpenNow,
    };
  }

  int getTravelTime(TransportMode mode) {
    switch (mode) {
      case TransportMode.driving:
        return travelTimes.driving;
      case TransportMode.walking:
        return travelTimes.walking;
      case TransportMode.biking:
        return travelTimes.biking;
    }
  }
}