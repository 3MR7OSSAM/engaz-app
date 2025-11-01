import 'package:engaz_task/app/core/injection/injection.dart';
import 'package:engaz_task/app/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:engaz_task/app/features/menu/presentation/cubit/menu_state.dart';
import 'package:engaz_task/app/features/menu/presentation/widgets/menu_item_widget.dart';
import 'package:engaz_task/app/features/menu/presentation/widgets/menu_shimmer_loading.dart';
import 'package:engaz_task/app/features/menu/presentation/widgets/restaurant_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Screen displaying the restaurant menu with categories and items.
class MenuScreen extends StatelessWidget {
  const MenuScreen({
    super.key,
    required this.vendorId,
    required this.branchId,
  });

  /// Route name for navigation.
  static const String name = 'menu';

  final String vendorId;
  final String branchId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MenuCubit>()
        ..fetchMenu(
          vendorId: int.parse(vendorId),
          branchId: int.parse(branchId),
        ),
      child: const _MenuView(),
    );
  }
}

class _MenuView extends StatelessWidget {
  const _MenuView();

  Future<void> _onRefresh(
      BuildContext context, int vendorId, int branchId) async {
    await context.read<MenuCubit>().refreshMenu(
          vendorId: vendorId,
          branchId: branchId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const MenuScreenShimmer();
          } else if (state is MenuSuccess) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(
                context,
                state.vendorInfo.vendorId,
                state.vendorInfo.branchId,
              ),
              child: CustomScrollView(
                slivers: [
                  // Restaurant Header
                  SliverToBoxAdapter(
                    child: RestaurantHeaderWidget(
                      vendorInfo: state.vendorInfo,
                      onBackPressed: () => context.pop(),
                      onCartPressed: () {
                        // TODO: Navigate to cart
                      },
                    ),
                  ),

                  // Menu Groups
                  ...state.groupsWithProducts.map((group) {
                    return SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Text(
                              group.groupName,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...group.products.map((product) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              child: MenuItemWidget(
                                product: product,
                                onTap: () {
                                  // TODO: Navigate to product details
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),

                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                ],
              ),
            );
          } else if (state is MenuError) {
            return _buildErrorContent(context, state);
          } else if (state is MenuEmpty) {
            return _buildEmptyContent(context, state);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, MenuError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Colors.red[300],
            ),
            SizedBox(height: 16.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyContent(BuildContext context, MenuEmpty state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu_outlined,
              size: 64.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'No Menu Available',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
