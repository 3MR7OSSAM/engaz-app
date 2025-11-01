/// Domain model representing a menu item.
class MenuItemModel {
  /// Creates a [MenuItemModel].
  const MenuItemModel({
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    this.discount,
    this.imageUrl,
  });

  /// The category this item belongs to.
  final String category;

  /// The name of the menu item.
  final String name;

  /// A description of the menu item.
  final String description;

  /// The price of the item in EGP.
  final double price;

  /// Optional discount percentage.
  final int? discount;

  /// Optional image URL for the item.
  final String? imageUrl;

  /// Calculates the final price after discount.
  double get finalPrice {
    if (discount == null || discount == 0) return price;
    return price * (1 - discount! / 100);
  }

  /// Creates a copy of this [MenuItemModel] with the given fields replaced.
  MenuItemModel copyWith({
    String? category,
    String? name,
    String? description,
    double? price,
    int? discount,
    String? imageUrl,
  }) {
    return MenuItemModel(
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }


}
