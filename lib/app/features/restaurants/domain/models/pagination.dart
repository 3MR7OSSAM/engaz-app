/// Pagination model for API responses.
class Pagination {
  const Pagination({
    required this.totalBranches,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  /// Creates a Pagination from JSON data.
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalBranches: json['total_branches'] as int? ?? 0,
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      hasNextPage: json['has_next_page'] as bool? ?? false,
      hasPrevPage: json['has_prev_page'] as bool? ?? false,
    );
  }

  final int totalBranches;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  /// Converts Pagination to JSON.
  Map<String, dynamic> toJson() {
    return {
      'total_branches': totalBranches,
      'current_page': currentPage,
      'total_pages': totalPages,
      'has_next_page': hasNextPage,
      'has_prev_page': hasPrevPage,
    };
  }

  /// Creates a copy of this Pagination with the given fields replaced.
  Pagination copyWith({
    int? totalBranches,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPrevPage,
  }) {
    return Pagination(
      totalBranches: totalBranches ?? this.totalBranches,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
    );
  }
}
