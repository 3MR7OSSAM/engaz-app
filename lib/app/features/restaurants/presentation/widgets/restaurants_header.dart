import 'package:engaz_task/app/features/restaurants/presentation/widgets/cart_icon_button.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/wave_header_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantsHeader extends StatelessWidget {
  const RestaurantsHeader({
    this.cartItemCount = 0,
    this.onBackPressed,
    this.onCartPressed,
    this.onSearchChanged,
    super.key,
  });
  final int cartItemCount;
  final VoidCallback? onBackPressed;
  final VoidCallback? onCartPressed;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(double.infinity, 210.h),
            painter: const WaveHeaderPainter(),
          ),

          // Header content
          Padding(
            padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onBackPressed,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Restaurants',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 18.w),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    CartIconButton(
                      itemCount: cartItemCount,
                      onTap: onCartPressed,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          onChanged: onSearchChanged,
                          decoration: InputDecoration(
                            hintText: 'Search for your favorite brand',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 22.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
