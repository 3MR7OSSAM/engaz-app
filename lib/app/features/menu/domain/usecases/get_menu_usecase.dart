import 'package:engaz_task/app/features/menu/domain/models/menu_api_response.dart';
import 'package:engaz_task/app/features/menu/domain/repositories/menu_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching menu data.
///
/// Encapsulates the business logic for retrieving menu data from the repository.
/// This follows the Clean Architecture pattern by separating business logic
/// from the presentation layer.
@lazySingleton
class GetMenuUseCase {
  GetMenuUseCase({required this.repository});

  final MenuRepository repository;

  /// Fetches menu data for a specific vendor and branch.
  ///
  /// [vendorId] - The ID of the vendor/restaurant
  /// [branchId] - The ID of the branch
  ///
  /// Returns a [MenuApiResponse] containing vendor info and grouped menu items.
  Future<MenuApiResponse> call({
    required int vendorId,
    required int branchId,
  }) async {
    return repository.getMenuData(
      vendorId: vendorId,
      branchId: branchId,
    );
  }
}
