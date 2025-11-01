/// Domain model representing restaurant information.
class RestaurantInfoModel {
  /// Creates a [RestaurantInfoModel].
  const RestaurantInfoModel({
    required this.name,
    required this.branch,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.phone,
    this.imageUrl,
  });

  /// The name of the restaurant.
  final String name;

  /// The branch location.
  final String branch;

  /// Delivery fee in EGP.
  final double deliveryFee;

  /// Estimated delivery time in minutes.
  final int deliveryTime;

  /// Contact phone number.
  final String phone;

  /// Optional header image URL.
  final String? imageUrl;

  /// Creates a copy of this [RestaurantInfoModel] with the given fields replaced.
  RestaurantInfoModel copyWith({
    String? name,
    String? branch,
    double? deliveryFee,
    int? deliveryTime,
    String? phone,
    String? imageUrl,
  }) {
    return RestaurantInfoModel(
      name: name ?? this.name,
      branch: branch ?? this.branch,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantInfoModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          branch == other.branch &&
          deliveryFee == other.deliveryFee &&
          deliveryTime == other.deliveryTime &&
          phone == other.phone &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      branch.hashCode ^
      deliveryFee.hashCode ^
      deliveryTime.hashCode ^
      phone.hashCode ^
      imageUrl.hashCode;

  @override
  String toString() {
    return 'RestaurantInfoModel(name: $name, branch: $branch, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, phone: $phone, imageUrl: $imageUrl)';
  }
}
