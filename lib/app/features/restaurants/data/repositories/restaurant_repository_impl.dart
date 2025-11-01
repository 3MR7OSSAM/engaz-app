import 'package:engaz_task/app/features/restaurants/data/datasources/restaurant_remote_data_source.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant_api_response.dart';
import 'package:engaz_task/app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:injectable/injectable.dart';

/// Implementation of the RestaurantRepository.
/// This handles data operations and delegates to data sources.
@LazySingleton(as: RestaurantRepository)
class RestaurantRepositoryImpl implements RestaurantRepository {
  RestaurantRepositoryImpl({
    required this.remoteDataSource,
  });
  final RestaurantRemoteDataSource remoteDataSource;

  @override
  Future<RestaurantApiResponse> getRestaurantData({
    double? latitude,
    double? longitude,
    int? page,
  }) async {
    try {
      return await remoteDataSource.fetchRestaurantData(
        latitude: latitude ?? 29.9681281,
        longitude: longitude ?? 31.1001428,
      );
    } catch (e) {
      // In a real app, you might want to handle errors more gracefully
      // or convert them to domain-specific exceptions
      rethrow;
    }
  }

  @override
  Future<List<Branch>> getTopRatedBranches() async {
    try {
      return await remoteDataSource.fetchTopRatedBranches();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Restaurant>> getRestaurants({
    String? category,
    double? minRating,
    bool? freeDeliveryOnly,
  }) async {
    try {
      return await remoteDataSource.fetchRestaurants(
        category: category,
        minRating: minRating,
        freeDeliveryOnly: freeDeliveryOnly,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      return await remoteDataSource.searchRestaurants(query);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    try {
      return await remoteDataSource.fetchRestaurantById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Branch>> getBranchesByRestaurantId(String restaurantId) async {
    try {
      return await remoteDataSource.fetchBranchesByRestaurantId(restaurantId);
    } catch (e) {
      rethrow;
    }
  }
}
