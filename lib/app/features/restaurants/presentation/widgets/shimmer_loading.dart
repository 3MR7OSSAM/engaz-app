import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// A reusable shimmer loading widget for loading states.
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    required this.width,
    required this.height,
    this.borderRadius = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer loading for branch card.
class BranchCardShimmer extends StatelessWidget {
  const BranchCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ShimmerLoading(
            width: 60.w,
            height: 60.h,
            borderRadius: 8.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  width: double.infinity,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                ShimmerLoading(
                  width: 100.w,
                  height: 10.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                ShimmerLoading(
                  width: 120.w,
                  height: 9.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading for restaurant card.
class RestaurantCardShimmer extends StatelessWidget {
  const RestaurantCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerLoading(
              width: 80.w,
              height: 80.h,
              borderRadius: 8.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerLoading(
                    width: double.infinity,
                    height: 13.h,
                    borderRadius: 4.r,
                  ),
                  SizedBox(height: 8.h),
                  ShimmerLoading(
                    width: 100.w,
                    height: 10.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ShimmerLoading(
                  width: 60.w,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                ShimmerLoading(
                  width: 60.w,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer loading for top rated branches section.
class TopRatedBranchesShimmer extends StatelessWidget {
  const TopRatedBranchesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ShimmerLoading(
            width: 150.w,
            height: 17.h,
            borderRadius: 4.r,
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ShimmerLoading(
            width: 200.w,
            height: 13.h,
            borderRadius: 4.r,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 260.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 2,
            itemBuilder: (context, pageIndex) {
              return Container(
                margin: EdgeInsets.only(right: 16.w),
                width: 500.w,
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: List.generate(
                    5,
                    (index) => const BranchCardShimmer(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Shimmer loading for restaurant list.
class RestaurantListShimmer extends StatelessWidget {
  const RestaurantListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (context, index) => const RestaurantCardShimmer(),
    );
  }
}
