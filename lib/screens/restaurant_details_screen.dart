import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/preferences_provider.dart';
import '../constants/app_constants.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({
    required this.restaurant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transportMode = context.watch<PreferencesProvider>().transportMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.cuisine,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('${restaurant.rating}'),
                      const SizedBox(width: 16),
                      Text(restaurant.priceRange.join()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(restaurant.address),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(_getTransportIcon(transportMode)),
                      const SizedBox(width: 8),
                      Text(
                        '${restaurant.getTravelTime(transportMode)} minutes',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement navigation
                      },
                      child: const Text('Get Directions'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTransportIcon(TransportMode mode) {
    switch (mode) {
      case TransportMode.driving:
        return Icons.directions_car;
      case TransportMode.walking:
        return Icons.directions_walk;
      case TransportMode.biking:
        return Icons.directions_bike;
    }
  }
}