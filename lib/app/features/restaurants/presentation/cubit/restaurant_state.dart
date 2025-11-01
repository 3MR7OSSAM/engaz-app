import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/pagination.dart';
import 'package:equatable/equatable.dart';

/// Base class for all restaurant states.
sealed class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded.
final class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

/// State when restaurant data is being loaded.
final class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

/// State when restaurant data is successfully loaded.
final class RestaurantSuccess extends RestaurantState {
  const RestaurantSuccess({
    required this.branches,
    required this.pagination,
    required this.message,
  });

  final List<Branch> branches;
  final Pagination pagination;
  final String message;

  @override
  List<Object?> get props => [branches, pagination, message];

  /// Creates a copy of this state with the given fields replaced.
  RestaurantSuccess copyWith({
    List<Branch>? branches,
    Pagination? pagination,
    String? message,
  }) {
    return RestaurantSuccess(
      branches: branches ?? this.branches,
      pagination: pagination ?? this.pagination,
      message: message ?? this.message,
    );
  }
}

/// State when loading more data (pagination).
final class RestaurantLoadingMore extends RestaurantState {
  const RestaurantLoadingMore({
    required this.currentBranches,
    required this.currentPagination,
  });

  final List<Branch> currentBranches;
  final Pagination currentPagination;

  @override
  List<Object?> get props => [currentBranches, currentPagination];
}

/// State when an error occurs while fetching restaurant data.
final class RestaurantError extends RestaurantState {
  const RestaurantError({
    required this.message,
    this.previousBranches,
    this.previousPagination,
  });

  final String message;
  final List<Branch>? previousBranches;
  final Pagination? previousPagination;

  @override
  List<Object?> get props => [message, previousBranches, previousPagination];

  /// Creates a copy of this error state with the given fields replaced.
  RestaurantError copyWith({
    String? message,
    List<Branch>? previousBranches,
    Pagination? previousPagination,
  }) {
    return RestaurantError(
      message: message ?? this.message,
      previousBranches: previousBranches ?? this.previousBranches,
      previousPagination: previousPagination ?? this.previousPagination,
    );
  }
}

/// State when no restaurants are found.
final class RestaurantEmpty extends RestaurantState {
  const RestaurantEmpty({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
