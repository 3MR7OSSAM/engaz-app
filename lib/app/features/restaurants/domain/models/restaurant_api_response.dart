import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/pagination.dart';

/// API response model for restaurant data.
class RestaurantApiResponse {
  const RestaurantApiResponse({
    required this.statusCode,
    required this.success,
    required this.pagination,
    required this.data,
    required this.message,
  });

  /// Creates a RestaurantApiResponse from JSON data.
  factory RestaurantApiResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantApiResponse(
      statusCode: json['status_code'] as int? ?? 0,
      success: json['success'] as bool? ?? false,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : const Pagination(
              totalBranches: 0,
              currentPage: 1,
              totalPages: 1,
              hasNextPage: false,
              hasPrevPage: false,
            ),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Branch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      message: json['message'] as String? ?? '',
    );
  }

  final int statusCode;
  final bool success;
  final Pagination pagination;
  final List<Branch> data;
  final String message;

  /// Converts RestaurantApiResponse to JSON.
  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'success': success,
      'pagination': pagination.toJson(),
      'data': data.map((branch) => branch.toJson()).toList(),
      'message': message,
    };
  }

  /// Creates a copy of this RestaurantApiResponse with the given fields replaced.
  RestaurantApiResponse copyWith({
    int? statusCode,
    bool? success,
    Pagination? pagination,
    List<Branch>? data,
    String? message,
  }) {
    return RestaurantApiResponse(
      statusCode: statusCode ?? this.statusCode,
      success: success ?? this.success,
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
