import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A shopping cart icon button with a badge showing the cart item count.
class CartIconButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onTap;

  const CartIconButton({
    required this.itemCount,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(10.w),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: const Color(0xFFFF5722),
              size: 24.sp,
            ),
          ),
          if (itemCount > 0)
            Positioned(
              right: 4.w,
              top: 2.h,
              child: Container(
                width: 14.w,
                height: 14.h,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    itemCount > 99 ? '99+' : '$itemCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
