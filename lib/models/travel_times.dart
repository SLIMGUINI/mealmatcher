class TravelTimes {
  final int walking;    // in minutes
  final int biking;     // in minutes
  final int driving;    // in minutes

  const TravelTimes({
    required this.walking,
    required this.biking,
    required this.driving,
  });

  factory TravelTimes.fromJson(Map<String, dynamic> json) {
    return TravelTimes(
      walking: json['walking'] as int,
      biking: json['biking'] as int,
      driving: json['driving'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'walking': walking,
      'biking': biking,
      'driving': driving,
    };
  }

  TravelTimes copyWith({
    int? walking,
    int? biking,
    int? driving,
  }) {
    return TravelTimes(
      walking: walking ?? this.walking,
      biking: biking ?? this.biking,
      driving: driving ?? this.driving,
    );
  }
}