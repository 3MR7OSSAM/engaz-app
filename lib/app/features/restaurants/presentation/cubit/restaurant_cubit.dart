import 'dart:developer' as developer;

import 'package:engaz_task/app/core/errors/exceptions.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/pagination.dart';
import 'package:engaz_task/app/features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Cubit for managing restaurant data state.
/// Handles fetching, pagination, and error states for restaurant branches.
@injectable
class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit({required this.getRestaurantsUseCase})
      : super(const RestaurantInitial());

  final GetRestaurantsUseCase getRestaurantsUseCase;

  // Store current data for pagination
  List<Branch> _currentBranches = [];
  Pagination? _currentPagination;

  /// Fetches restaurant data from the API.
  ///
  /// [latitude] - User's latitude for distance calculation
  /// [longitude] - User's longitude for distance calculation
  /// [page] - Page number for pagination (default: 1)
  /// [isLoadMore] - Whether this is a load more operation (default: false)
  Future<void> fetchRestaurants({
    double? latitude,
    double? longitude,
    int? page,
    bool isLoadMore = false,
  }) async {
    try {
      // Emit loading state
      if (isLoadMore && _currentBranches.isNotEmpty) {
        emit(RestaurantLoadingMore(
          currentBranches: _currentBranches,
          currentPagination: _currentPagination!,
        ));
      } else {
        emit(const RestaurantLoading());
      }

      // Log the request
      developer.log(
        'Fetching restaurants',
        name: 'RestaurantCubit',
        error: {
          'latitude': latitude,
          'longitude': longitude,
          'page': page,
        },
      );

      // Call the use case
      final response = await getRestaurantsUseCase(
        latitude: latitude,
        longitude: longitude,
        page: page,
      );

      // Check if the request was successful
      if (!response.success) {
        emit(RestaurantError(
          message: response.message,
          previousBranches: _currentBranches.isEmpty ? null : _currentBranches,
          previousPagination: _currentPagination,
        ));
        return;
      }

      // Handle load more: append new data
      if (isLoadMore) {
        _currentBranches = [..._currentBranches, ...response.data];
      } else {
        _currentBranches = response.data;
      }
      _currentPagination = response.pagination;

      // Check if data is empty
      if (_currentBranches.isEmpty) {
        emit(RestaurantEmpty(
          message: response.message.isEmpty
              ? 'No restaurants found'
              : response.message,
        ));
        return;
      }

      // Emit success state
      emit(RestaurantSuccess(
        branches: _currentBranches,
        pagination: _currentPagination!,
        message: response.message,
      ));

      // Log success
      developer.log(
        'Restaurants fetched successfully',
        name: 'RestaurantCubit',
        error: {
          'count': _currentBranches.length,
          'current_page': _currentPagination?.currentPage,
          'total_pages': _currentPagination?.totalPages,
        },
      );
    } on ServerException catch (e) {
      // Handle server exceptions
      developer.log(
        'Server error while fetching restaurants',
        name: 'RestaurantCubit',
        level: 1000,
        error: e,
      );

      emit(RestaurantError(
        message: e.message,
        previousBranches: _currentBranches.isEmpty ? null : _currentBranches,
        previousPagination: _currentPagination,
      ));
    } catch (e, stackTrace) {
      // Handle other exceptions
      developer.log(
        'Unexpected error while fetching restaurants',
        name: 'RestaurantCubit',
        level: 1000,
        error: e,
        stackTrace: stackTrace,
      );

      emit(RestaurantError(
        message: 'An unexpected error occurred. Please try again.',
        previousBranches: _currentBranches.isEmpty ? null : _currentBranches,
        previousPagination: _currentPagination,
      ));
    }
  }

  /// Loads the next page of restaurants.
  Future<void> loadMoreRestaurants({
    double? latitude,
    double? longitude,
  }) async {
    // Check if there's a next page
    if (_currentPagination == null || !_currentPagination!.hasNextPage) {
      developer.log(
        'No more pages to load',
        name: 'RestaurantCubit',
      );
      return;
    }

    final nextPage = _currentPagination!.currentPage + 1;

    await fetchRestaurants(
      latitude: latitude,
      longitude: longitude,
      page: nextPage,
      isLoadMore: true,
    );
  }

  /// Refreshes the restaurant data (resets to page 1).
  Future<void> refreshRestaurants({
    double? latitude,
    double? longitude,
  }) async {
    _currentBranches = [];
    _currentPagination = null;

    await fetchRestaurants(
      latitude: latitude,
      longitude: longitude,
      page: 1,
    );
  }

  /// Applies filters to the branches based on provided criteria.
  ///
  /// [filterFreeDelivery] - If true, only show branches with free delivery
  /// [filterMinRating] - If provided, only show branches with rating >= this value
  void applyFilters({
    bool filterFreeDelivery = false,
    double? filterMinRating,
  }) {
    if (state is RestaurantSuccess || state is RestaurantEmpty) {
      var filteredBranches = _currentBranches;

      // Apply rating filter
      if (filterMinRating != null) {
        filteredBranches = filteredBranches
            .where((branch) => branch.rating >= filterMinRating)
            .toList();
      }

      // Apply free delivery filter
      if (filterFreeDelivery) {
        filteredBranches = filteredBranches
            .where((branch) => branch.deliveryFee == 0)
            .toList();
      }

      if (filteredBranches.isEmpty) {
        emit(const RestaurantEmpty(
          message: 'No restaurants match your filters',
        ));
      } else {
        emit(RestaurantSuccess(
          branches: filteredBranches,
          pagination: _currentPagination!,
          message: 'Filtered restaurants',
        ));
      }
    }
  }

  /// Filters branches by free delivery.
  void filterByFreeDelivery() {
    applyFilters(filterFreeDelivery: true);
  }

  /// Filters branches by minimum rating.
  void filterByMinRating(double minRating) {
    applyFilters(filterMinRating: minRating);
  }

  /// Resets all filters and shows all branches.
  void resetFilters() {
    if (state is RestaurantSuccess || state is RestaurantEmpty) {
      if (_currentBranches.isEmpty) {
        emit(const RestaurantEmpty(message: 'No restaurants found'));
      } else {
        emit(RestaurantSuccess(
          branches: _currentBranches,
          pagination: _currentPagination!,
          message: 'All restaurants',
        ));
      }
    }
  }
}
