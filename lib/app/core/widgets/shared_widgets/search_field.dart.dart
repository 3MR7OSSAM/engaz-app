import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {

  const SearchField({
    super.key,
    this.onChanged,
    this.hintText = 'Search',
    this.width = 500,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0x332D3748), // default grayish border
    this.iconColor = const Color(0xFF718096),
    this.hintColor = const Color(0xFF718096),
    this.controller,
  });
  final ValueChanged<String>? onChanged;
  final String hintText;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color hintColor;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: hintColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20.sp,
            color: iconColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
