import 'package:engaz_task/app/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:engaz_task/app/features/menu/domain/models/menu_api_response.dart';
import 'package:engaz_task/app/features/menu/domain/repositories/menu_repository.dart';
import 'package:injectable/injectable.dart';

/// Implementation of MenuRepository.
/// Delegates data fetching to the remote data source.
@LazySingleton(as: MenuRepository)
class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required this.remoteDataSource});

  final MenuRemoteDataSource remoteDataSource;

  @override
  Future<MenuApiResponse> getMenuData({
    required int vendorId,
    required int branchId,
  }) async {
    return remoteDataSource.fetchMenuData(
      vendorId: vendorId,
      branchId: branchId,
    );
  }
}
