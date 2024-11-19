import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences_provider.dart';
import '../providers/restaurant_provider.dart';
import '../constants/app_constants.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, RestaurantProvider>(
      builder: (context, prefsProvider, restaurantProvider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBar(
                  hintText: 'Search restaurants...',
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    restaurantProvider.updateSearchQuery(value);
                  },
                ),
              ),

              // Transport Mode Section
              _buildSectionHeader('Transport Mode'),
              _buildTransportModeFilter(prefsProvider, restaurantProvider),

              // Travel Time Section
              _buildTravelTimeSlider(prefsProvider, restaurantProvider),

              // Cuisine Section
              _buildSectionHeader('Cuisine'),
              _buildCuisineFilter(restaurantProvider),

              // Price Range Section
              _buildSectionHeader('Price Range'),
              _buildPriceRangeFilter(restaurantProvider),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTransportModeFilter(
    PreferencesProvider prefsProvider,
    RestaurantProvider restaurantProvider,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: TransportMode.values.map((mode) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AppConstants.transportModeIcons[mode], size: 16),
                  const SizedBox(width: 4),
                  Text(AppConstants.transportModeLabels[mode]!),
                ],
              ),
              selected: prefsProvider.transportMode == mode,
              onSelected: (selected) {
                if (selected) {
                  prefsProvider.setTransportMode(mode);
                  restaurantProvider.setTransportModeAndTime(
                    mode,
                    prefsProvider.maxTravelTime,
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTravelTimeSlider(
    PreferencesProvider prefsProvider,
    RestaurantProvider restaurantProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Maximum Travel Time: ${prefsProvider.maxTravelTime} min',
            style: const TextStyle(fontSize: 14),
          ),
          Slider(
            value: prefsProvider.maxTravelTime.toDouble(),
            min: 5,
            max: prefsProvider.getMaxTimeForMode(
              prefsProvider.transportMode,
            ).toDouble(),
            divisions: null,
            label: '${prefsProvider.maxTravelTime} min',
            onChanged: (value) {
              prefsProvider.setMaxTravelTime(value.round());
              restaurantProvider.setTransportModeAndTime(
                prefsProvider.transportMode,
                value.round(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineFilter(RestaurantProvider restaurantProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: restaurantProvider.selectedCuisine.isEmpty,
            onSelected: (selected) {
              if (selected) {
                restaurantProvider.setSelectedCuisine('');
              }
            },
          ),
          const SizedBox(width: 8),
          ...restaurantProvider.availableCuisines.map((cuisine) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(cuisine),
                selected: restaurantProvider.selectedCuisine == cuisine,
                onSelected: (selected) {
                  restaurantProvider.setSelectedCuisine(
                    selected ? cuisine : '',
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriceRangeFilter(RestaurantProvider restaurantProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: restaurantProvider.selectedPriceRange.isEmpty,
            onSelected: (selected) {
              if (selected) {
                restaurantProvider.setSelectedPriceRange('');
              }
            },
          ),
          const SizedBox(width: 8),
          ...restaurantProvider.availablePriceRanges.map((price) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(price),
                selected: restaurantProvider.selectedPriceRange == price,
                onSelected: (selected) {
                  restaurantProvider.setSelectedPriceRange(
                    selected ? price : '',
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}