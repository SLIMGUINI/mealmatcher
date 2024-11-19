import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../services/mock_data.dart';
import '../constants/app_constants.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _selectedCuisine = '';
  String _selectedPriceRange = '';
  int _maxTravelTime = 30;
  TransportMode _transportMode = TransportMode.driving;

  RestaurantProvider() {
    loadRestaurants();
  }

  // Getters
  List<Restaurant> get restaurants => _filterRestaurants();
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedCuisine => _selectedCuisine;
  String get selectedPriceRange => _selectedPriceRange;
  
  List<String> get availableCuisines {
    if (_restaurants.isEmpty) return [];
    
    return _restaurants
        .where((r) => _isWithinTravelTime(r))
        .where((r) => _selectedPriceRange.isEmpty || 
            r.priceRange.contains(_selectedPriceRange))
        .map((r) => r.cuisine)
        .toSet()
        .toList();
  }

  List<String> get availablePriceRanges {
    if (_restaurants.isEmpty) return [];
    
    return _restaurants
        .where((r) => _isWithinTravelTime(r))
        .where((r) => _selectedCuisine.isEmpty || 
            r.cuisine == _selectedCuisine)
        .expand((r) => r.priceRange)
        .toSet()
        .toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCuisine(String cuisine) {
    _selectedCuisine = cuisine;
    notifyListeners();
  }

  void setSelectedPriceRange(String priceRange) {
    _selectedPriceRange = priceRange;
    notifyListeners();
  }

  void setTransportModeAndTime(TransportMode mode, int maxMinutes) {
    _transportMode = mode;
    _maxTravelTime = maxMinutes;
    notifyListeners();
  }

  Future<void> loadRestaurants() async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));
      _restaurants = MockData.restaurants;
      _error = null;

    } catch (e) {
      print('Error loading restaurants: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _isWithinTravelTime(Restaurant restaurant) {
    int travelTime = restaurant.getTravelTime(_transportMode);
    return travelTime <= _maxTravelTime;
  }

  List<Restaurant> _filterRestaurants() {
    if (_restaurants.isEmpty) {
      return [];
    }

    return _restaurants.where((restaurant) {
      if (!_isWithinTravelTime(restaurant)) {
        return false;
      }

      if (_selectedCuisine.isNotEmpty && 
          restaurant.cuisine != _selectedCuisine) {
        return false;
      }

      if (_selectedPriceRange.isNotEmpty && 
          !restaurant.priceRange.contains(_selectedPriceRange)) {
        return false;
      }

      if (_searchQuery.isNotEmpty) {
        final nameMatch = restaurant.name
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final cuisineMatch = restaurant.cuisine
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        if (!nameMatch && !cuisineMatch) return false;
      }

      return true;
    }).toList();
  }

  void resetFilters() {
    _selectedCuisine = '';
    _selectedPriceRange = '';
    _searchQuery = '';
    notifyListeners();
  }
}