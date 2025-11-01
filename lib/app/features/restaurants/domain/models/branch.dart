/// Domain model for a restaurant branch.
/// This model is used across all layers (domain, data, presentation).
class Branch {
  const Branch({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.name,
    required this.logoUrl,
    required this.coverImageUrl,
    required this.phone,
    required this.deliveryFee,
    required this.avgDeliveryTime,
    required this.minOrder,
    required this.cityName,
    required this.stateName,
    required this.rating,
    required this.ratingsCount,
    required this.isFreeDelivery,
    required this.distance,
    required this.inHome,
  });

  /// Base URL for constructing full image URLs
  static const String _baseImageUrl =
      'https://dealsapps.net/DealsAppData/DealsVendors/';

  /// Creates a Branch from JSON data.
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['branch_id']?.toString() ?? '',
      vendorId: json['vendor_id']?.toString() ?? '',
      vendorName: json['vendor_name'] as String? ?? '',
      name: json['branch_name'] as String? ?? '',
      logoUrl: json['logo_url'] as String? ?? '',
      coverImageUrl: json['cover_image_url'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      avgDeliveryTime: json['avg_delivery_time'] as String? ?? '',
      minOrder: (json['min_order'] as num?)?.toDouble() ?? 0.0,
      cityName: json['city_name'] as String? ?? '',
      stateName: json['state_name'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: json['ratings_count'] as int? ?? 0,
      isFreeDelivery: json['is_free_delivery'] as bool? ?? false,
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      inHome: json['in_home'] as int? ?? 0,
    );
  }

  final String id;
  final String vendorId;
  final String vendorName;
  final String name;
  final String logoUrl;
  final String coverImageUrl;
  final String phone;
  final double deliveryFee;
  final String avgDeliveryTime;
  final double minOrder;
  final String cityName;
  final String stateName;
  final double rating;
  final int ratingsCount;
  final bool isFreeDelivery;
  final double distance;
  final int inHome;

  /// Returns the full URL for the logo image.
  String get fullLogoUrl {
    if (logoUrl.isEmpty) return '';
    if (logoUrl.startsWith('http')) return logoUrl;
    return '$_baseImageUrl$logoUrl';
  }

  /// Returns the full URL for the cover image.
  String get fullCoverImageUrl {
    if (coverImageUrl.isEmpty) return '';
    if (coverImageUrl.startsWith('http')) return coverImageUrl;
    return '$_baseImageUrl$coverImageUrl';
  }

  /// Converts Branch to JSON.
  Map<String, dynamic> toJson() {
    return {
      'branch_id': id,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'branch_name': name,
      'logo_url': logoUrl,
      'cover_image_url': coverImageUrl,
      'phone': phone,
      'delivery_fee': deliveryFee,
      'avg_delivery_time': avgDeliveryTime,
      'min_order': minOrder,
      'city_name': cityName,
      'state_name': stateName,
      'rating': rating,
      'ratings_count': ratingsCount,
      'is_free_delivery': isFreeDelivery,
      'distance': distance,
      'in_home': inHome,
    };
  }

  /// Creates a copy of this Branch with the given fields replaced.
  Branch copyWith({
    String? id,
    String? vendorId,
    String? vendorName,
    String? name,
    String? logoUrl,
    String? coverImageUrl,
    String? phone,
    double? deliveryFee,
    String? avgDeliveryTime,
    double? minOrder,
    String? cityName,
    String? stateName,
    double? rating,
    int? ratingsCount,
    bool? isFreeDelivery,
    double? distance,
    int? inHome,
  }) {
    return Branch(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      phone: phone ?? this.phone,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      avgDeliveryTime: avgDeliveryTime ?? this.avgDeliveryTime,
      minOrder: minOrder ?? this.minOrder,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      rating: rating ?? this.rating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      isFreeDelivery: isFreeDelivery ?? this.isFreeDelivery,
      distance: distance ?? this.distance,
      inHome: inHome ?? this.inHome,
    );
  }
}
