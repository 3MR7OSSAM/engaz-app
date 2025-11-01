import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A filter chip button with optional icon.
class FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool hasDropdown;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterChip({
    required this.label,
    this.icon,
    this.hasDropdown = false,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF5722).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5722) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 14.sp,
                color: isSelected ? const Color(0xFFFF5722) : Colors.black87,
              ),
            if (icon != null) SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFF5722) : Colors.black87,
              ),
            ),
            if (hasDropdown) ...[
              SizedBox(width: 3.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16.sp,
                color: isSelected ? const Color(0xFFFF5722) : Colors.black54,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
