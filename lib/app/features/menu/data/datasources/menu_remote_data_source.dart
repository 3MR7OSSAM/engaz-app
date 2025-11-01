import 'package:engaz_task/app/core/constants/app_endpoints.dart';
import 'package:engaz_task/app/core/network/api_consumer.dart';
import 'package:engaz_task/app/features/menu/domain/models/menu_api_response.dart';
import 'package:injectable/injectable.dart';

/// Abstract contract for Menu remote data source.
abstract class MenuRemoteDataSource {
  /// Fetches menu data for a specific vendor and branch.
  ///
  /// [vendorId] - The ID of the vendor/restaurant
  /// [branchId] - The ID of the branch
  Future<MenuApiResponse> fetchMenuData({
    required int vendorId,
    required int branchId,
  });
}

/// Implementation using Dio via ApiConsumer (Clean + Injectable).
@LazySingleton(as: MenuRemoteDataSource)
class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  MenuRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<MenuApiResponse> fetchMenuData({
    required int vendorId,
    required int branchId,
  }) async {
    // The backend expects form-data with vendor_id and branch_id
    final body = {
      'vendor_id': vendorId.toString(),
      'branch_id': branchId.toString(),
    };

    final response = await apiConsumer.postWithFile(
      EndpointConstants.getRestaurantMenuData,
      fields: body,
    );

    return MenuApiResponse.fromJson(response as Map<String, dynamic>);
  }
}
