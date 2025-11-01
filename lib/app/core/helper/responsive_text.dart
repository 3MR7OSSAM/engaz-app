import 'package:flutter_screenutil/flutter_screenutil.dart';

double responsiveFontSize(
    double desktopSize, double tabletSize, double mobileSize,) {
  if (ScreenUtil().screenWidth >= 1000) {
    // Desktop
    return desktopSize.sp * 0.9;
  } else if (ScreenUtil().screenWidth >= 600) {
    // Tablet
    return tabletSize.sp * 0.8;
  } else {
    // Mobile
    return mobileSize.sp * 0.7;
  }
}
