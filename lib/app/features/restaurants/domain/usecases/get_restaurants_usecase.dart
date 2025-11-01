import 'package:engaz_task/app/features/restaurants/domain/models/restaurant_api_response.dart';
import 'package:engaz_task/app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching restaurant data.
/// This encapsulates the business logic for getting restaurants.
@lazySingleton
class GetRestaurantsUseCase {
  GetRestaurantsUseCase({required this.repository});

  final RestaurantRepository repository;

  /// Executes the use case to fetch restaurant data.
  ///
  /// [latitude] - User's latitude for distance calculation
  /// [longitude] - User's longitude for distance calculation
  /// [page] - Page number for pagination (default: 1)
  Future<RestaurantApiResponse> call({
    double? latitude,
    double? longitude,
    int? page,
  }) async {
    return await repository.getRestaurantData(
      latitude: latitude,
      longitude: longitude,
      page: page ?? 1,
    );
  }
}
