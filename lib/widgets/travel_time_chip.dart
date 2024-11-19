import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class TravelTimeChip extends StatelessWidget {
  final int minutes;
  final TransportMode mode;

  const TravelTimeChip({
    required this.minutes,
    required this.mode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getTransportIcon(), size: 16),
          const SizedBox(width: 4),
          Text('$minutes min'),
        ],
      ),
    );
  }

  IconData _getTransportIcon() {
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