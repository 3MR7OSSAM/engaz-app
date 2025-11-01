import 'package:engaz_task/app/features/menu/domain/models/menu_group.dart';
import 'package:engaz_task/app/features/menu/domain/models/vendor_info.dart';

/// Domain model for the complete menu API response.
class MenuApiResponse {
  const MenuApiResponse({
    required this.statusCode,
    required this.success,
    required this.vendorInfo,
    required this.data,
    required this.message,
  });

  /// Creates a MenuApiResponse from JSON data.
  factory MenuApiResponse.fromJson(Map<String, dynamic> json) {
    return MenuApiResponse(
      statusCode: json['status_code'] as int? ?? 0,
      success: json['success'] as bool? ?? false,
      vendorInfo: json['vendor_info'] != null
          ? VendorInfo.fromJson(json['vendor_info'] as Map<String, dynamic>)
          : const VendorInfo(
              vendorId: 0,
              branchId: 0,
              vendorName: '',
              branchName: '',
              phone: '',
              logoUrl: '',
              coverImageUrl: '',
              avgDeliveryTime: '',
              minOrder: 0,
              deliveryFee: 0,
            ),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => MenuGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message'] as String? ?? '',
    );
  }

  final int statusCode;
  final bool success;
  final VendorInfo vendorInfo;
  final List<MenuGroup> data;
  final String message;

  /// Returns only groups that have products.
  List<MenuGroup> get groupsWithProducts =>
      data.where((group) => group.hasProducts).toList();

  /// Returns the total number of products across all groups.
  int get totalProductCount =>
      data.fold(0, (sum, group) => sum + group.productCount);

  /// Converts MenuApiResponse to JSON.
  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'success': success,
      'vendor_info': vendorInfo.toJson(),
      'data': data.map((g) => g.toJson()).toList(),
      'message': message,
    };
  }
}
