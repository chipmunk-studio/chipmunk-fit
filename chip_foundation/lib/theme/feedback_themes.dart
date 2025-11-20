import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// Tooltip 테마
TooltipThemeData tooltipTheme(FitColors colors) {
  return TooltipThemeData(
    decoration: BoxDecoration(
      color: colors.inverseBackground,
      borderRadius: BorderRadius.circular(8.r),
    ),
    textStyle: TextStyle(color: colors.inverseText, fontSize: 12.sp),
  );
}

/// ProgressIndicator 테마
ProgressIndicatorThemeData progressIndicatorTheme(FitColors colors) {
  return ProgressIndicatorThemeData(
    color: colors.main,
    linearTrackColor: colors.fillStrong,
    circularTrackColor: colors.fillStrong,
  );
}

/// Badge 테마
BadgeThemeData badgeTheme(FitColors colors) {
  return BadgeThemeData(
    backgroundColor: colors.red500,
    textColor: colors.staticWhite,
    smallSize: 8,
    largeSize: 16,
  );
}
