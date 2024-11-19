import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/preferences_provider.dart';
import '../widgets/filter_section.dart';
import '../widgets/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MealMatcher'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<RestaurantProvider>().resetFilters();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => 
            context.read<RestaurantProvider>().loadRestaurants(),
        child: Column(
          children: [
            const FilterSection(),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.error != null) {
                    return Center(
                      child: Text(
                        'Error: ${provider.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final restaurants = provider.restaurants;
                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text('No restaurants found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: restaurants.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return RestaurantCard(
                        restaurant: restaurant,
                        transportMode: context
                            .watch<PreferencesProvider>()
                            .transportMode,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}