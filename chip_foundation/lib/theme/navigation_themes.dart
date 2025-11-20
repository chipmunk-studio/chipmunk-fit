import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

/// BottomNavigationBar 테마
BottomNavigationBarThemeData bottomNavigationBarTheme(FitColors colors) {
  return BottomNavigationBarThemeData(
    backgroundColor: colors.backgroundElevated,
    selectedItemColor: colors.textPrimary,
    unselectedItemColor: colors.textTertiary,
    selectedLabelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 12.sp),
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  );
}

/// NavigationBar 테마
NavigationBarThemeData navigationBarTheme(FitColors colors) {
  return NavigationBarThemeData(
    backgroundColor: colors.backgroundElevated,
    indicatorColor: colors.main.withValues(alpha: 0.12),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: colors.textPrimary);
      }
      return TextStyle(fontSize: 12.sp, color: colors.textTertiary);
    }),
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: colors.main);
      }
      return IconThemeData(color: colors.textTertiary);
    }),
    elevation: 0,
  );
}

/// NavigationRail 테마
NavigationRailThemeData navigationRailTheme(FitColors colors) {
  return NavigationRailThemeData(
    backgroundColor: colors.backgroundElevated,
    selectedIconTheme: IconThemeData(color: colors.main),
    unselectedIconTheme: IconThemeData(color: colors.textTertiary),
    selectedLabelTextStyle: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600),
    unselectedLabelTextStyle: TextStyle(color: colors.textTertiary),
    indicatorColor: colors.main.withValues(alpha: 0.12),
    elevation: 0,
  );
}

/// TabBar 테마
TabBarThemeData tabBarTheme(FitColors colors) {
  return TabBarThemeData(
    labelColor: colors.textPrimary,
    unselectedLabelColor: colors.textTertiary,
    indicatorColor: colors.main,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: colors.dividerPrimary,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
  );
}

/// Drawer 테마
DrawerThemeData drawerTheme(FitColors colors) {
  return DrawerThemeData(
    backgroundColor: colors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: const RoundedRectangleBorder(),
  );
}
