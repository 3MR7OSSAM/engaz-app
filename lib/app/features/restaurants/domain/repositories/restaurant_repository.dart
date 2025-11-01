import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/restaurant_api_response.dart';

/// Repository interface for restaurant operations.
/// This defines the contract that the data layer must implement.
abstract class RestaurantRepository {
  /// Fetches restaurant data from the API with optional filters.
  ///
  /// [latitude] - User's latitude for distance calculation
  /// [longitude] - User's longitude for distance calculation
  /// [page] - Page number for pagination
  Future<RestaurantApiResponse> getRestaurantData({
    double? latitude,
    double? longitude,
    int? page,
  });

  /// Fetches a list of top-rated restaurant branches.
  Future<List<Branch>> getTopRatedBranches();

  /// Fetches a list of restaurants based on optional filters.
  ///
  /// [category] - Filter by restaurant
  /// category (e.g., 'Beverages', 'Fast Food')
  /// [minRating] - Minimum rating filter (e.g., 4.0)
  /// [freeDeliveryOnly] - Filter for free delivery only
  Future<List<Restaurant>> getRestaurants({
    String? category,
    double? minRating,
    bool? freeDeliveryOnly,
  });

  /// Searches for restaurants by name or keyword.
  Future<List<Restaurant>> searchRestaurants(String query);

  /// Fetches details for a specific restaurant.
  Future<Restaurant> getRestaurantById(String id);

  /// Fetches all branches for a specific restaurant.
  Future<List<Branch>> getBranchesByRestaurantId(String restaurantId);
}
