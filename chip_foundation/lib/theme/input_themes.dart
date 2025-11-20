import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// SearchBar 테마
SearchBarThemeData searchBarTheme(FitColors colors) {
  return SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(colors.fillAlternative),
    elevation: WidgetStateProperty.all(0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
    hintStyle: WidgetStateProperty.all(TextStyle(color: colors.textTertiary)),
  );
}

/// SegmentedButton 테마
SegmentedButtonThemeData segmentedButtonTheme(FitColors colors) {
  return SegmentedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.main;
        return Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.staticBlack;
        return colors.textPrimary;
      }),
      side: WidgetStateProperty.all(BorderSide(color: colors.grey400)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      ),
    ),
  );
}

/// InputDecoration 테마
InputDecorationTheme inputDecorationTheme(FitColors colors) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(color: colors.dividerSecondary),
  );

  return InputDecorationTheme(
    filled: true,
    fillColor: colors.fillAlternative,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: BorderSide(color: colors.main, width: 1.5),
    ),
    errorBorder: border.copyWith(
      borderSide: BorderSide(color: colors.red500),
    ),
    focusedErrorBorder: border.copyWith(
      borderSide: BorderSide(color: colors.red500, width: 1.5),
    ),
    disabledBorder: border,
    hintStyle: TextStyle(color: colors.textTertiary),
    labelStyle: TextStyle(color: colors.textSecondary),
    errorStyle: TextStyle(color: colors.red500),
  );
}
