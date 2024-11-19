import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../constants/app_constants.dart';
import '../screens/restaurant_details_screen.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final TransportMode transportMode;

  const RestaurantCard({
    required this.restaurant,
    required this.transportMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailsScreen(
                restaurant: restaurant,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.network(
                restaurant.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, size: 50),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(restaurant.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Cuisine and Price Range
                  Row(
                    children: [
                      Text(
                        restaurant.cuisine,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Text(
                        restaurant.priceRange.join(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Travel Time
                  Row(
                    children: [
                      Icon(_getTransportIcon(), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurant.getTravelTime(transportMode)} min',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTransportIcon() {
    switch (transportMode) {
      case TransportMode.driving:
        return Icons.directions_car;
      case TransportMode.walking:
        return Icons.directions_walk;
      case TransportMode.biking:
        return Icons.directions_bike;
    }
  }
}