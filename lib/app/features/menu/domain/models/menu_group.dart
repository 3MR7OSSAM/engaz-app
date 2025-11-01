import 'package:engaz_task/app/features/menu/domain/models/product.dart';

/// Domain model for a menu group (category).
class MenuGroup {
  const MenuGroup({
    required this.groupId,
    required this.groupName,
    required this.products,
  });

  /// Creates a MenuGroup from JSON data.
  factory MenuGroup.fromJson(Map<String, dynamic> json) {
    return MenuGroup(
      groupId: json['group_id'] as int? ?? 0,
      groupName: json['group_name'] as String? ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  final int groupId;
  final String groupName;
  final List<Product> products;

  /// Returns whether this group has products.
  bool get hasProducts => products.isNotEmpty;

  /// Returns the number of products in this group.
  int get productCount => products.length;

  /// Converts MenuGroup to JSON.
  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
