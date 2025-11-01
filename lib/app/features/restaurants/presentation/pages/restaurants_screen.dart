import 'package:engaz_task/app/core/injection/injection.dart';
import 'package:engaz_task/app/features/menu/presentation/pages/manu_screen.dart';
import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_cubit.dart';
import 'package:engaz_task/app/features/restaurants/presentation/cubit/restaurant_state.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/restaurant_list_widget.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/restaurants_header.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/shimmer_loading.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/top_rated_branches_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});
  static const String name = 'restaurants';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RestaurantCubit>()
        ..fetchRestaurants(
          latitude: 30.0444, // Cairo coordinates as example
          longitude: 31.2357,
          page: 1,
        ),
      child: const _RestaurantsView(),
    );
  }
}

class _RestaurantsView extends StatefulWidget {
  const _RestaurantsView();

  @override
  State<_RestaurantsView> createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<_RestaurantsView> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<RestaurantCubit>().refreshRestaurants();
  }

  List<Branch> _filterBranches(List<Branch> branches) {
    if (_searchQuery.isEmpty) return branches;
    return branches
        .where(
          (branch) =>
              branch.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: RestaurantsHeader(
                    onBackPressed: () => context.pop(),
                    onCartPressed: () {
                      // TODO: Navigate to cart
                    },
                    onSearchChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                  ),
                ),

                // Content based on state
                if (state is RestaurantLoading)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const TopRatedBranchesShimmer(),
                        SizedBox(height: 20.h),
                        const RestaurantListShimmer(),
                      ],
                    ),
                  )
                else if (state is RestaurantSuccess ||
                    state is RestaurantLoadingMore)
                  ..._buildSuccessContent(state)
                else if (state is RestaurantError)
                  _buildErrorContent(state)
                else if (state is RestaurantEmpty)
                  _buildEmptyContent(state)
                else
                  const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSuccessContent(RestaurantState state) {
    final List<Branch> branches;

    if (state is RestaurantSuccess) {
      branches = state.branches;
    } else if (state is RestaurantLoadingMore) {
      branches = state.currentBranches;
    } else {
      branches = [];
    }

    final filteredBranches = _filterBranches(branches);

    return [
      // Top rated branches
      if (filteredBranches.isNotEmpty)
        SliverToBoxAdapter(
          child: TopRatedBranchesList(
            branches: filteredBranches.take(10).toList(),
            onBranchTap: (branch) {
              context.pushNamed(
                MenuScreen.name,
                pathParameters: {
                  'vendorId': branch.vendorId,
                  'branchId': branch.id,
                },
              );
            },
          ),
        ),

      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
      SliverToBoxAdapter(
        child: RestaurantListWidget(
          branches: filteredBranches,
          onBranchTap: (branch) {
            context.pushNamed(
              MenuScreen.name,
              pathParameters: {
                'vendorId': branch.vendorId,
                'branchId': branch.id,
              },
            );
          },
        ),
      ),

      // Loading more indicator
      if (state is RestaurantLoadingMore)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF5722),
              ),
            ),
          ),
        ),

      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
    ];
  }

  Widget _buildErrorContent(RestaurantError state) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
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
                onPressed: _onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
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
      ),
    );
  }

  Widget _buildEmptyContent(RestaurantEmpty state) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_outlined,
                size: 64.sp,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16.h),
              Text(
                'No Restaurants Found',
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
                onPressed: _onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
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
      ),
    );
  }
}
