import 'dart:developer' as developer;

import 'package:engaz_task/app/core/errors/exceptions.dart';
import 'package:engaz_task/app/features/menu/domain/usecases/get_menu_usecase.dart';
import 'package:engaz_task/app/features/menu/presentation/cubit/menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Cubit for managing menu data state.
/// Handles fetching and error states for menu items.
@injectable
class MenuCubit extends Cubit<MenuState> {
  MenuCubit({required this.getMenuUseCase}) : super(const MenuInitial());

  final GetMenuUseCase getMenuUseCase;

  /// Fetches menu data from the API for a specific vendor and branch.
  ///
  /// [vendorId] - The ID of the vendor/restaurant
  /// [branchId] - The ID of the branch
  Future<void> fetchMenu({
    required int vendorId,
    required int branchId,
  }) async {
    try {
      // Emit loading state
      emit(const MenuLoading());

      // Log the request
      developer.log(
        'Fetching menu',
        name: 'MenuCubit',
        error: {
          'vendorId': vendorId,
          'branchId': branchId,
        },
      );

      // Call the use case
      final response = await getMenuUseCase(
        vendorId: vendorId,
        branchId: branchId,
      );

      // Check if the request was successful
      if (!response.success) {
        emit(MenuError(message: response.message));
        return;
      }

      // Get only groups with products
      final groupsWithProducts = response.groupsWithProducts;

      // Check if data is empty
      if (groupsWithProducts.isEmpty) {
        emit(MenuEmpty(
          message: response.message.isEmpty
              ? 'No menu items available'
              : response.message,
          vendorInfo: response.vendorInfo,
        ));
        return;
      }

      // Emit success state
      emit(MenuSuccess(
        vendorInfo: response.vendorInfo,
        menuGroups: response.data,
        message: response.message,
      ));

      // Log success
      developer.log(
        'Menu fetched successfully',
        name: 'MenuCubit',
        error: {
          'total_groups': response.data.length,
          'groups_with_products': groupsWithProducts.length,
          'total_products': response.totalProductCount,
        },
      );
    } on ServerException catch (e) {
      // Handle server exceptions
      developer.log(
        'Server error while fetching menu',
        name: 'MenuCubit',
        level: 1000,
        error: e,
      );

      emit(MenuError(message: e.message));
    } catch (e, stackTrace) {
      // Handle other exceptions
      developer.log(
        'Unexpected error while fetching menu',
        name: 'MenuCubit',
        level: 1000,
        error: e,
        stackTrace: stackTrace,
      );

      emit(const MenuError(
        message: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  /// Refreshes the menu data.
  Future<void> refreshMenu({
    required int vendorId,
    required int branchId,
  }) async {
    await fetchMenu(vendorId: vendorId, branchId: branchId);
  }

  /// Filters menu groups by name.
  void filterByGroupName(String query) {
    if (state is MenuSuccess) {
      final currentState = state as MenuSuccess;

      if (query.isEmpty) {
        // Reset to original data
        emit(currentState);
        return;
      }

      final filteredGroups = currentState.menuGroups
          .where((group) =>
              group.groupName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filteredGroups.isEmpty) {
        emit(MenuEmpty(
          message: 'No menu groups found matching "$query"',
          vendorInfo: currentState.vendorInfo,
        ));
      } else {
        emit(currentState.copyWith(menuGroups: filteredGroups));
      }
    }
  }
}
