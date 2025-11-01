/// Domain model for vendor information in menu response.
class VendorInfo {
  const VendorInfo({
    required this.vendorId,
    required this.branchId,
    required this.vendorName,
    required this.branchName,
    required this.phone,
    required this.logoUrl,
    required this.coverImageUrl,
    required this.avgDeliveryTime,
    required this.minOrder,
    required this.deliveryFee,
  });

  /// Base URL for constructing full image URLs
  static const String _baseImageUrl =
      'https://dealsapps.net/DealsAppData/DealsVendors/';

  /// Creates a VendorInfo from JSON data.
  factory VendorInfo.fromJson(Map<String, dynamic> json) {
    return VendorInfo(
      vendorId: json['vendor_id'] as int? ?? 0,
      branchId: json['branch_id'] as int? ?? 0,
      vendorName: json['vendor_name'] as String? ?? '',
      branchName: json['branch_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      logoUrl: json['logo_url'] as String? ?? '',
      coverImageUrl: json['cover_image_url'] as String? ?? '',
      avgDeliveryTime: json['avg_delivery_time'] as String? ?? '',
      minOrder: (json['min_order'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final int vendorId;
  final int branchId;
  final String vendorName;
  final String branchName;
  final String phone;
  final String logoUrl;
  final String coverImageUrl;
  final String avgDeliveryTime;
  final double minOrder;
  final double deliveryFee;

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

  /// Returns whether delivery is free.
  bool get isFreeDelivery => deliveryFee == 0.0;

  /// Converts VendorInfo to JSON.
  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'branch_id': branchId,
      'vendor_name': vendorName,
      'branch_name': branchName,
      'phone': phone,
      'logo_url': logoUrl,
      'cover_image_url': coverImageUrl,
      'avg_delivery_time': avgDeliveryTime,
      'min_order': minOrder,
      'delivery_fee': deliveryFee,
    };
  }
}
