import 'package:flutter/material.dart';

class DrawerItem {
  const DrawerItem({
    required this.label,
    required this.icon,
    required this.route,
    this.routeName,
    this.description,
  });

  final String label;
  final IconData icon;
  final String route;
  final String? routeName;
  final String? description;
}
