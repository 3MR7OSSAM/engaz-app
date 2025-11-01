import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:engaz_task/app/core/constants/app_colors.dart';
import 'package:engaz_task/app/core/models/drower_model.dart';

/// A reusable application drawer that integrates with GoRouter.
///
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.items = const [
      DrawerItem(
        label: 'Home',
        icon: Icons.home_rounded,
        route: '/home',
        routeName: 'home',
        description: 'Dashboard and overview',
      ),
      DrawerItem(
        label: 'Medicine',
        icon: Icons.medication_rounded,
        route: '/medicine',
        routeName: 'medicine',
        description: 'Manage medicines',
      ),
      DrawerItem(
        label: 'Supplier',
        icon: Icons.business_rounded,
        route: '/supplier',
        routeName: 'supplier',
        description: 'Manage suppliers',
      ),
      DrawerItem(
        label: 'Profile',
        icon: Icons.person_rounded,
        route: '/profile',
        routeName: 'profile',
        description: 'Manage your profile',
      ),
      DrawerItem(
        label: 'resumeparser',
        icon: Icons.person_rounded,
        route: '/resume-parser',
        routeName: 'resume-parser',
        description: 'Manage your resume',
      ),
      DrawerItem(
        label: 'formBuilder',
        icon: Icons.settings_rounded,
        route: '/form-builder',
        routeName: 'form-builder',
        description: 'App preferences',
      ),
      DrawerItem(
        label: 'atsDashboard',
        icon: Icons.settings_rounded,
        route: '/ats-dashboard',
        routeName: 'ats-dashboard',
        description: 'App preferences',
      ),
      DrawerItem(
        label: 'Job Matcher',
        icon: Icons.analytics,
        route: '/job-matcher',
        routeName: 'job-matcher',
        description: 'Match resume to job',
      ),
      DrawerItem(
        label: 'HR Resume Matcher',
        icon: Icons.business_center,
        route: '/hr-resume-matcher',
        routeName: 'hr-resume-matcher',
        description: 'HR tool for resume analysis',
      ),
      DrawerItem(
        label: 'manual-resume-builder',
        icon: Icons.settings_rounded,
        route: '/manual-resume-builder',
        routeName: 'manual-resume-builder',
        description: 'App preferences',
      ),
      DrawerItem(
        label: 'Settings',
        icon: Icons.settings_rounded,
        route: '/settings',
        routeName: 'settings',
        description: 'App preferences',
      ),
    ],
    this.header,
  });

  /// Menu items are represented as a list of [DrawerItem].
  final List<DrawerItem> items;

  /// Optional header widget. If null, a default header is shown.
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    // Get current location from GoRouter using the proper method
    final currentLocation = GoRouterState.of(context).matchedLocation;

    return Drawer(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFB), Color(0xFFFFFFFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Enhanced Header
              header ?? _defaultHeader(context),

              // Navigation Items
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => SizedBox(height: 4.h),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final selected = _isRouteSelected(
                        currentLocation,
                        item.route,
                      );

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              if (item.routeName != null &&
                                  item.routeName!.isNotEmpty) {
                                try {
                                  context.goNamed(item.routeName!);
                                } catch (_) {
                                  context.go(item.route);
                                }
                              } else {
                                context.go(item.route);
                              }
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.primary.withValues(
                                        alpha: 0.1,
                                      )
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12.r),
                                border: selected
                                    ? Border.all(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.2),
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: selected
                                          // ignore: lines_longer_than_80_chars
                                          ? AppColors.primary
                                              .withValues(alpha: 0.2)
                                          : AppColors.gray.withValues(
                                              alpha: .1,
                                            ),
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                    ),
                                    child: Icon(
                                      item.icon,
                                      size: 20.sp,
                                      color: selected
                                          ? AppColors.primary
                                          : AppColors.gray,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.label,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: selected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: selected
                                                ? AppColors.primary
                                                : AppColors.primary.withValues(
                                                    alpha: 0.8,
                                                  ),
                                          ),
                                        ),
                                        if (item.description != null) ...[
                                          SizedBox(height: 2.h),
                                          Text(
                                            item.description!,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.gray,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  if (selected)
                                    Container(
                                      width: 4.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                          2.r,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 50 * index),
                            duration: const Duration(milliseconds: 300),
                          )
                          .slideX(
                            begin: -0.2,
                            duration: const Duration(milliseconds: 300),
                          );
                    },
                  ),
                ),
              ),

              // Footer Section
              Container(
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'engaz_task',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.gray),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultHeader(BuildContext context) {
    return Container(
      height: 220.h,
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            right: -50,
            bottom: -20,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 400),
                    )
                    .slideY(begin: 0.3),

                SizedBox(height: 6.h),

                Text(
                  'Discover and showcase talent',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 400),
                    )
                    .slideY(begin: 0.3),

                SizedBox(height: 16.h),

                // Status indicator
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 400),
                    )
                    .scale(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isRouteSelected(String location, String route) {
    // Simple selection heuristics:
    if (route == '/') return location == '/';
    return location.startsWith(route);
  }
}
