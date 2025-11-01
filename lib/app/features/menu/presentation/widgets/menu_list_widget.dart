import 'package:flutter/material.dart';

import '../../domain/models/menu_group.dart';
import 'menu_item_widget.dart';

/// Widget displaying a list of menu items grouped by category.
class MenuListWidget extends StatelessWidget {
  /// Creates a [MenuListWidget].
  const MenuListWidget({
    required this.menuGroups,
    this.selectedCategory,
    super.key,
  });

  /// List of all menu groups to display.
  final List<MenuGroup> menuGroups;

  /// The currently selected category to filter by.
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final filteredGroups = _filterGroups();

    if (filteredGroups.isEmpty) {
      return const Center(
        child: Text(
          'No items available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _getItemCount(filteredGroups),
      itemBuilder: (context, index) {
        return _ListItem(
          index: index,
          groupedItems: filteredGroups,
        );
      },
    );
  }

  /// Filters menu groups based on selected category.
  List<MenuGroup> _filterGroups() {
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      return menuGroups.where((group) => group.hasProducts).toList();
    }

    return menuGroups
        .where(
            (group) => group.groupName == selectedCategory && group.hasProducts)
        .toList();
  }

  /// Calculates the total number of items (group headers + products).
  int _getItemCount(List<MenuGroup> groups) {
    int count = 0;
    for (final group in groups) {
      count++; // Group header
      count += group.products.length; // Products in group
    }
    return count;
  }
}

/// Private widget for building a list item (either category header or menu item).
class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.index,
    required this.groupedItems,
  });

  final int index;
  final List<MenuGroup> groupedItems;

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    for (final group in groupedItems) {
      // Check if this is the group header
      if (currentIndex == index) {
        return _CategoryHeader(category: group.groupName);
      }
      currentIndex++;

      // Check if this is one of the products in this group
      for (final product in group.products) {
        if (currentIndex == index) {
          return MenuItemWidget(product: product);
        }
        currentIndex++;
      }
    }

    return const SizedBox.shrink();
  }
}

/// Private widget for displaying a category header.
class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        category,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
