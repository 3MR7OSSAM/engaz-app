/// Domain model representing a menu category.
class CategoryModel {
  /// Creates a [CategoryModel].
  const CategoryModel({
    required this.name,
    required this.count,
  });

  /// The name of the category.
  final String name;

  /// The number of items in this category.
  final int count;

  /// Creates a copy of this [CategoryModel] with the given fields replaced.
  CategoryModel copyWith({
    String? name,
    int? count,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }


}
