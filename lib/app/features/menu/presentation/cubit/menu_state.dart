import 'package:engaz_task/app/features/menu/domain/models/menu_group.dart';
import 'package:engaz_task/app/features/menu/domain/models/vendor_info.dart';
import 'package:equatable/equatable.dart';

/// Base class for all menu states.
sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded.
final class MenuInitial extends MenuState {
  const MenuInitial();
}

/// State when menu data is being loaded.
final class MenuLoading extends MenuState {
  const MenuLoading();
}

/// State when menu data is successfully loaded.
final class MenuSuccess extends MenuState {
  const MenuSuccess({
    required this.vendorInfo,
    required this.menuGroups,
    required this.message,
  });

  final VendorInfo vendorInfo;
  final List<MenuGroup> menuGroups;
  final String message;

  /// Returns only menu groups that have products.
  List<MenuGroup> get groupsWithProducts =>
      menuGroups.where((group) => group.hasProducts).toList();

  /// Returns the total number of products across all groups.
  int get totalProductCount =>
      menuGroups.fold(0, (sum, group) => sum + group.productCount);

  @override
  List<Object?> get props => [vendorInfo, menuGroups, message];

  /// Creates a copy of this state with the given fields replaced.
  MenuSuccess copyWith({
    VendorInfo? vendorInfo,
    List<MenuGroup>? menuGroups,
    String? message,
  }) {
    return MenuSuccess(
      vendorInfo: vendorInfo ?? this.vendorInfo,
      menuGroups: menuGroups ?? this.menuGroups,
      message: message ?? this.message,
    );
  }
}

/// State when an error occurs while fetching menu data.
final class MenuError extends MenuState {
  const MenuError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// State when no menu items are found.
final class MenuEmpty extends MenuState {
  const MenuEmpty({required this.message, this.vendorInfo});

  final String message;
  final VendorInfo? vendorInfo;

  @override
  List<Object?> get props => [message, vendorInfo];
}
