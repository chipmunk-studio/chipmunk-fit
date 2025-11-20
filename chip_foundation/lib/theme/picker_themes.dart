import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// DatePicker 테마
DatePickerThemeData datePickerTheme(FitColors colors) {
  return DatePickerThemeData(
    backgroundColor: colors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    headerBackgroundColor: colors.main,
    headerForegroundColor: colors.staticBlack,
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.main;
      return Colors.transparent;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return colors.staticBlack;
      return colors.textPrimary;
    }),
    todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
    todayForegroundColor: WidgetStateProperty.all(colors.main),
    todayBorder: BorderSide(color: colors.main),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
  );
}

/// TimePicker 테마
TimePickerThemeData timePickerTheme(FitColors colors) {
  return TimePickerThemeData(
    backgroundColor: colors.backgroundElevated,
    hourMinuteColor: colors.fillAlternative,
    hourMinuteTextColor: colors.textPrimary,
    dialBackgroundColor: colors.fillAlternative,
    dialHandColor: colors.main,
    dialTextColor: colors.textPrimary,
    entryModeIconColor: colors.textSecondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
  );
}
