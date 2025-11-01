/// Domain model for a product image.
class ProductImage {
  const ProductImage({
    required this.productId,
    required this.imageUrl,
    required this.isPrimary,
    required this.sortOrder,
  });

  /// Base URL for constructing full image URLs
  static const String _baseImageUrl =
      'https://dealsapps.net/DealsAppData/DealsVendors/';

  /// Creates a ProductImage from JSON data.
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      productId: json['product_id'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      isPrimary: (json['is_primary'] as int?) == 1,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  final int productId;
  final String imageUrl;
  final bool isPrimary;
  final int sortOrder;

  /// Returns the full URL for the product image.
  String get fullImageUrl {
    if (imageUrl.isEmpty) return '';
    if (imageUrl.startsWith('http')) return imageUrl;
    return '$_baseImageUrl$imageUrl';
  }

  /// Converts ProductImage to JSON.
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'image_url': imageUrl,
      'is_primary': isPrimary ? 1 : 0,
      'sort_order': sortOrder,
    };
  }
}
