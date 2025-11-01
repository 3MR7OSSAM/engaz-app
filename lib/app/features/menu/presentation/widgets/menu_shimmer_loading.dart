import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// A reusable shimmer loading widget for loading states.
class MenuShimmerLoading extends StatelessWidget {
  const MenuShimmerLoading({
    required this.width,
    required this.height,
    this.borderRadius = 8,
    super.key,
  });

  final double width;
  final double height;
  final double borderRadius;

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

/// Shimmer loading for menu screen header.
class MenuHeaderShimmer extends StatelessWidget {
  const MenuHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Bar Shimmer
        Container(
          height: 200.h,
          color: Colors.grey[300],
        ),

        // Vendor Info Card Shimmer
        Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(16.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MenuShimmerLoading(
                    width: 80.w,
                    height: 80.h,
                    borderRadius: 8.r,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuShimmerLoading(
                          width: double.infinity,
                          height: 16.h,
                          borderRadius: 4.r,
                        ),
                        SizedBox(height: 8.h),
                        MenuShimmerLoading(
                          width: 100.w,
                          height: 12.h,
                          borderRadius: 4.r,
                        ),
                        SizedBox(height: 8.h),
                        MenuShimmerLoading(
                          width: 80.w,
                          height: 12.h,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const Divider(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuShimmerLoading(
                    width: 80.w,
                    height: 12.h,
                    borderRadius: 4.r,
                  ),
                  MenuShimmerLoading(
                    width: 80.w,
                    height: 12.h,
                    borderRadius: 4.r,
                  ),
                  MenuShimmerLoading(
                    width: 80.w,
                    height: 12.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shimmer loading for menu group item.
class MenuItemShimmer extends StatelessWidget {
  const MenuItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuShimmerLoading(
                  width: double.infinity,
                  height: 16.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                MenuShimmerLoading(
                  width: 150.w,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                MenuShimmerLoading(
                  width: 100.w,
                  height: 14.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          MenuShimmerLoading(
            width: 90.w,
            height: 90.h,
            borderRadius: 12.r,
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading for menu group section.
class MenuGroupShimmer extends StatelessWidget {
  const MenuGroupShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Title
          MenuShimmerLoading(
            width: 150.w,
            height: 20.h,
            borderRadius: 4.r,
          ),
          SizedBox(height: 16.h),

          // Menu Items
          ...List.generate(
            3,
            (index) => const MenuItemShimmer(),
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading for entire menu screen.
class MenuScreenShimmer extends StatelessWidget {
  const MenuScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          expandedHeight: 200.h,
          pinned: true,
          backgroundColor: Colors.grey[300],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),

        // Vendor Info Card
        const SliverToBoxAdapter(
          child: MenuHeaderShimmer(),
        ),

        // Menu Groups
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const MenuGroupShimmer(),
            childCount: 2,
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
      ],
    );
  }
}
