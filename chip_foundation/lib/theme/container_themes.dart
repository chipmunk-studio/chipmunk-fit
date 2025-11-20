import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// Chip 테마
ChipThemeData chipTheme(FitColors colors) {
  return ChipThemeData(
    backgroundColor: colors.fillAlternative,
    selectedColor: colors.main,
    disabledColor: colors.fillAlternative,
    labelStyle: TextStyle(color: colors.textPrimary),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  );
}

/// Card 테마
CardThemeData cardTheme(FitColors colors) {
  return CardThemeData(
    color: colors.backgroundElevated,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  );
}

/// Dialog 테마
DialogThemeData dialogTheme(FitColors colors) {
  return DialogThemeData(
    backgroundColor: colors.backgroundElevated,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
    titleTextStyle: TextStyle(
      fontSize: 20.spMin,
      fontWeight: FontWeight.w600,
      color: colors.textPrimary,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16.spMin,
      color: colors.textSecondary,
    ),
  );
}

/// BottomSheet 테마
BottomSheetThemeData bottomSheetTheme(FitColors colors) {
  return BottomSheetThemeData(
    backgroundColor: colors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    dragHandleColor: colors.grey300,
    dragHandleSize: const Size(40, 4),
  );
}

/// SnackBar 테마
SnackBarThemeData snackBarTheme(FitColors colors) {
  return SnackBarThemeData(
    backgroundColor: colors.inverseBackground,
    contentTextStyle: TextStyle(color: colors.inverseText),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
  );
}
