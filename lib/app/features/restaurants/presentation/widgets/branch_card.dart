import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget displaying branch information.
class BranchCard extends StatelessWidget {
  const BranchCard({
    required this.branch,
    this.onTap,
    super.key,
  });
  final Branch branch;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Image
            Container(
              width: 60.w,
              height: 60.h,
              margin: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: NetworkImage(branch.fullLogoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Text Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Branch name
                    Text(
                      branch.name,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 12.sp,
                          color: const Color(0xFFFFB300),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          '${branch.rating.toStringAsFixed(2)} (${branch.ratingsCount}),',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // Distance + Delivery
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 11.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '${branch.distance.toStringAsFixed(2)} KM',
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.motorcycle,
                          size: 11.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '${branch.deliveryFee.toStringAsFixed(2)} EGP',
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
