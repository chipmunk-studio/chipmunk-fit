import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// ListTile 테마
ListTileThemeData listTileTheme(FitColors colors) {
  return ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: colors.fillAlternative,
    iconColor: colors.textSecondary,
    textColor: colors.textPrimary,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  );
}

/// Divider 테마
DividerThemeData dividerTheme(FitColors colors) {
  return DividerThemeData(
    color: colors.dividerPrimary,
    thickness: 1,
    space: 1,
  );
}

/// PopupMenu 테마
PopupMenuThemeData popupMenuTheme(FitColors colors) {
  return PopupMenuThemeData(
    color: colors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    textStyle: TextStyle(color: colors.textPrimary),
  );
}

/// DropdownMenu 테마
DropdownMenuThemeData dropdownMenuTheme(FitColors colors) {
  return DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.fillAlternative,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(colors.backgroundElevated),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(4),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    ),
  );
}

/// Menu 테마
MenuThemeData menuTheme(FitColors colors) {
  return MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(colors.backgroundElevated),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(4),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    ),
  );
}
