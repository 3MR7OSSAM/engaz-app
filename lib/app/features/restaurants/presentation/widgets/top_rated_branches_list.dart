import 'package:engaz_task/app/features/restaurants/domain/models/branch.dart';
import 'package:engaz_task/app/features/restaurants/presentation/widgets/branch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A horizontal scrollable list displaying top-rated restaurant branches.
class TopRatedBranchesList extends StatelessWidget {
  const TopRatedBranchesList({
    required this.branches,
    this.onBranchTap,
    super.key,
  });
  final List<Branch> branches;
  final void Function(Branch)? onBranchTap;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffF5EDE2),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Top rated restaurants',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Here's what everyone loves near you",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: branches.length > 3 ? 260.h : 165.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: (branches.length / 5).ceil(),
                itemBuilder: (context, pageIndex) {
                  final startIndex = pageIndex * 5;
                  final endIndex = (startIndex + 5).clamp(0, branches.length);
                  final pageItems = branches.sublist(startIndex, endIndex);

                  return Container(
                    margin: EdgeInsets.only(right: 16.w),
                    width: 500.w,
                    child: Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: pageItems.map((branch) {
                        return BranchCard(
                          branch: branch,
                          onTap: () => onBranchTap?.call(branch),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
