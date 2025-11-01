import 'package:flutter/material.dart';

import '../../domain/models/menu_group.dart';

/// Bottom sheet displaying all categories with their counts.
class CategoriesBottomSheet extends StatelessWidget {
  /// Creates a [CategoriesBottomSheet].
  const CategoriesBottomSheet({
    required this.menuGroups,
    super.key,
  });

  /// List of menu groups to display.
  final List<MenuGroup> menuGroups;

  /// Shows the categories bottom sheet.
  static void show(BuildContext context, List<MenuGroup> menuGroups) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CategoriesBottomSheet(menuGroups: menuGroups),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter groups that have products
    final groupsWithProducts =
        menuGroups.where((group) => group.hasProducts).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(groupCount: groupsWithProducts.length),
          const Divider(),
          _CategoriesList(menuGroups: groupsWithProducts),
        ],
      ),
    );
  }
}

/// Private widget for displaying the header of the categories bottom sheet.
class _Header extends StatelessWidget {
  const _Header({
    required this.groupCount,
  });

  final int groupCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

/// Private widget for displaying the categories list.
class _CategoriesList extends StatelessWidget {
  const _CategoriesList({
    required this.menuGroups,
  });

  final List<MenuGroup> menuGroups;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuGroups.length,
      itemBuilder: (context, index) {
        final group = menuGroups[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                group.groupName,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                group.productCount.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
