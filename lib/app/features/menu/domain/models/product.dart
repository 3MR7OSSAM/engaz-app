import 'package:engaz_task/app/features/menu/domain/models/product_image.dart';

/// Domain model for a menu product.
class Product {
  const Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.quantity,
    required this.sku,
    required this.isFeatured,
    required this.images,
  });

  /// Creates a Product from JSON data.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discount_price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
      sku: json['sku'] as String? ?? '',
      isFeatured: (json['is_featured'] as int?) == 1,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  final int productId;
  final String name;
  final String description;
  final double price;
  final double discountPrice;
  final int quantity;
  final String sku;
  final bool isFeatured;
  final List<ProductImage> images;

  /// Returns the primary image or the first image if no primary is set.
  ProductImage? get primaryImage {
    if (images.isEmpty) return null;
    try {
      return images.firstWhere((img) => img.isPrimary);
    } catch (e) {
      return images.first;
    }
  }

  /// Returns whether the product has a discount.
  bool get hasDiscount => discountPrice > 0 && discountPrice < price;

  /// Returns the discount percentage.
  double get discountPercentage {
    if (!hasDiscount) return 0.0;
    return ((price - discountPrice) / price * 100).roundToDouble();
  }

  /// Returns the final price (discount price if available, otherwise regular price).
  double get finalPrice => hasDiscount ? discountPrice : price;

  /// Converts Product to JSON.
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'quantity': quantity,
      'sku': sku,
      'is_featured': isFeatured ? 1 : 0,
      'images': images.map((img) => img.toJson()).toList(),
    };
  }
}
