import 'package:flutter/material.dart';

import '../../domain/models/menu_group.dart';

/// Widget displaying horizontal scrollable category tabs.
class CategoryTabsWidget extends StatelessWidget {
  /// Creates a [CategoryTabsWidget].
  const CategoryTabsWidget({
    required this.menuGroups,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onMenuButtonPressed,
    super.key,
  });

  /// List of menu groups to display as tabs.
  final List<MenuGroup> menuGroups;

  /// The currently selected category name.
  final String selectedCategory;

  /// Callback when a category is selected.
  final ValueChanged<String> onCategorySelected;

  /// Callback when the menu button is pressed.
  final VoidCallback onMenuButtonPressed;

  @override
  Widget build(BuildContext context) {
    // Filter groups that have products
    final groupsWithProducts =
        menuGroups.where((group) => group.hasProducts).toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuButtonPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: groupsWithProducts.map((group) {
                  return _CategoryTab(
                    group: group,
                    isSelected: group.groupName == selectedCategory,
                    onSelected: onCategorySelected,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Private widget for displaying a single category tab.
class _CategoryTab extends StatelessWidget {
  const _CategoryTab({
    required this.group,
    required this.isSelected,
    required this.onSelected,
  });

  final MenuGroup group;
  final bool isSelected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => onSelected(group.groupName),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              group.groupName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.orange : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 6),
            if (isSelected)
              Container(
                height: 3,
                width: 40,
                color: Colors.orange,
              ),
          ],
        ),
      ),
    );
  }
}
