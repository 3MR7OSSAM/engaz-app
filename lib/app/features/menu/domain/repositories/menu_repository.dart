import 'package:engaz_task/app/features/menu/domain/models/menu_api_response.dart';

/// Repository interface for menu operations.
/// This defines the contract that the data layer must implement.
abstract class MenuRepository {
  /// Fetches menu data for a specific vendor and branch.
  ///
  /// [vendorId] - The ID of the vendor/restaurant
  /// [branchId] - The ID of the branch
  Future<MenuApiResponse> getMenuData({
    required int vendorId,
    required int branchId,
  });
}
