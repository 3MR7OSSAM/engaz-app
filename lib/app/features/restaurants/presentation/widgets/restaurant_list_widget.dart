import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_cubit.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/filter_chip.dart'
    as custom;
import 'package:engaz_task/app/features/restaurants/presentation/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget displaying a tabbed list of restaurants with filters.
class RestaurantListWidget extends StatefulWidget {
  const RestaurantListWidget({
    required this.branches,
    this.onBranchTap,
    super.key,
  });
  final List<Branch> branches;
  final void Function(Branch)? onBranchTap;

  @override
  State<RestaurantListWidget> createState() => _RestaurantListWidgetState();
}

class _RestaurantListWidgetState extends State<RestaurantListWidget> {
  bool _isFreeDeliverySelected = false;
  bool _isRatingSelected = false;

  void _applyFilters(BuildContext context) {
    final cubit = context.read<RestaurantCubit>();

    if (!_isRatingSelected && !_isFreeDeliverySelected) {
      // Reset filters if nothing is selected
      cubit.resetFilters();
    } else {
      // Apply both filters together
      cubit.applyFilters(
        filterFreeDelivery: _isFreeDeliverySelected,
        filterMinRating: _isRatingSelected ? 4.0 : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayBranches = widget.branches;
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TabBar Section ---
              ColoredBox(
                color: const Color(0xFFFDFBFF), // soft background
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  labelStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  indicatorColor: Colors.black,
                  indicatorWeight: 1.8,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: const Color(0xFFEAEAEA),
                  tabs: const [
                    Tab(text: 'Beverages'),
                    Tab(text: 'Breakfast'),
                    Tab(text: 'Desserts'),
                    Tab(text: 'Fast Food'),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // --- Filter Chips ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      custom.FilterChip(
                        label: 'Sort By',
                        icon: Icons.swap_vert,
                        hasDropdown: true,
                        onTap: () {
                          // Handle sort tap
                        },
                      ),
                      SizedBox(width: 10.w),
                      custom.FilterChip(
                        label: 'Rating 4.0+',
                        isSelected: _isRatingSelected,
                        onTap: () {
                          setState(() {
                            _isRatingSelected = !_isRatingSelected;
                          });
                          _applyFilters(context);
                        },
                      ),
                      SizedBox(width: 10.w),
                      custom.FilterChip(
                        label: 'Free Delivery',
                        icon: Icons.delivery_dining,
                        isSelected: _isFreeDeliverySelected,
                        onTap: () {
                          setState(() {
                            _isFreeDeliverySelected = !_isFreeDeliverySelected;
                          });
                          _applyFilters(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),
              AnimatedBuilder(
                animation: tabController,
                builder: (context, _) {
                  final currentIndex = tabController.index;

                  // If not the first tab, show a no-items placeholder
                  if (currentIndex != 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'No items available',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Otherwise show the restaurant list for Beverages
                  if (displayBranches.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.filter_list_off,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'No restaurants match your filters',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: displayBranches.length,
                    itemBuilder: (context, index) {
                      final branch = displayBranches[index];
                      return RestaurantCard(
                        branch: branch,
                        onTap: () => widget.onBranchTap?.call(branch),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          );
        },
      ),
    );
  }
}
