import 'package:engaz_task/app/core/constants/app_endpoints.dart';
import 'package:engaz_task/app/core/network/api_consumer.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant_api_response.dart';
import 'package:injectable/injectable.dart';

/// Abstract contract for Restaurant remote data source.
abstract class RestaurantRemoteDataSource {
  Future<RestaurantApiResponse> fetchRestaurantData({
    required double latitude,
    required double longitude,
    int page = 1,
    String searchQuery,
    int vendorTypeId,
  });

  Future<List<Branch>> fetchTopRatedBranches();

  Future<List<Restaurant>> fetchRestaurants({
    String? category,
    double? minRating,
    bool? freeDeliveryOnly,
  });

  Future<List<Restaurant>> searchRestaurants(String query);

  Future<Restaurant> fetchRestaurantById(String id);

  Future<List<Branch>> fetchBranchesByRestaurantId(String restaurantId);
}

/// Implementation using Dio via ApiConsumer (Clean + Injectable).
@LazySingleton(as: RestaurantRemoteDataSource)
class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  RestaurantRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<RestaurantApiResponse> fetchRestaurantData({
    required double latitude,
    required double longitude,
    int page = 1,
    String searchQuery = '',
    int vendorTypeId = 11,
  }) async {
    // The backend expects form-data with specific fields
    final body = {
      'filter_type': '2',
      'sort_by_distance': 'true',
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'search': searchQuery,
      'vendor_type_id': vendorTypeId.toString(),
      'in_home': '1',
      'page': page.toString(),
    };

    final response = await apiConsumer.postWithFile(
      EndpointConstants.getRestaurants,
      fields: body,
    );

    return RestaurantApiResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<List<Branch>> fetchTopRatedBranches() async {
    final response =
        await fetchRestaurantData(latitude: 30.0444, longitude: 31.2357);

    if (!response.success) {
      throw Exception(response.message);
    }

    final sortedBranches = List<Branch>.from(response.data)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return sortedBranches.take(5).toList();
  }

  @override
  Future<List<Restaurant>> fetchRestaurants({
    String? category,
    double? minRating,
    bool? freeDeliveryOnly,
  }) async {
    final response =
        await fetchRestaurantData(latitude: 30.0444, longitude: 31.2357);

    if (!response.success) {
      throw Exception(response.message);
    }

    // Group branches into restaurants
    final restaurantMap = <String, Restaurant>{};

    for (final branch in response.data) {
      restaurantMap.putIfAbsent(branch.vendorId, () {
        return Restaurant(
          id: branch.vendorId,
          name: branch.vendorName,
          imageUrl: branch.fullLogoUrl,
          distance: branch.distance,
          rating: branch.rating,
          reviewCount: branch.ratingsCount,
          deliveryFee: branch.deliveryFee,
        );
      });
    }

    var restaurants = restaurantMap.values.toList();

    // Apply filters
    if (minRating != null) {
      restaurants = restaurants.where((r) => r.rating >= minRating).toList();
    }

    if (freeDeliveryOnly == true) {
      restaurants = restaurants.where((r) => r.deliveryFee == 0.0).toList();
    }

    return restaurants;
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    final allRestaurants = await fetchRestaurants();
    return allRestaurants
        .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<Restaurant> fetchRestaurantById(String id) async {
    final restaurants = await fetchRestaurants();
    return restaurants.firstWhere(
      (r) => r.id == id,
      orElse: () => throw Exception('Restaurant not found'),
    );
  }

  @override
  Future<List<Branch>> fetchBranchesByRestaurantId(String restaurantId) async {
    final response =
        await fetchRestaurantData(latitude: 30.0444, longitude: 31.2357);

    if (!response.success) {
      throw Exception(response.message);
    }

    return response.data
        .where((branch) => branch.vendorId == restaurantId)
        .toList();
  }
}
