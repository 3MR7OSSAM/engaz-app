/// Domain model for a restaurant.
/// This model is used across all layers (domain, data, presentation).
class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.deliveryFee,
  });

  /// Creates a Restaurant from JSON data.
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
    );
  }
  final String id;
  final String name;
  final String imageUrl;
  final double distance;
  final double rating;
  final int reviewCount;
  final double deliveryFee;

  /// Converts Restaurant to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'distance': distance,
      'rating': rating,
      'reviewCount': reviewCount,
      'deliveryFee': deliveryFee,
    };
  }

  /// Creates a copy of this Restaurant with the given fields replaced.
  Restaurant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? distance,
    double? rating,
    int? reviewCount,
    double? deliveryFee,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
    );
  }
}
