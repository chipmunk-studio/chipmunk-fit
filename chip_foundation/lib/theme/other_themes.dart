import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../textstyle.dart';

/// TextSelection 테마
TextSelectionThemeData textSelectionTheme(FitColors colors, bool isDark) {
  return TextSelectionThemeData(
    cursorColor: colors.main,
    selectionColor: colors.main.withValues(alpha: 0.3),
    selectionHandleColor: isDark ? colors.sub : colors.main,
  );
}

/// Scrollbar 테마
ScrollbarThemeData scrollbarTheme(FitColors colors) {
  return ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(colors.grey400),
    trackColor: WidgetStateProperty.all(Colors.transparent),
    radius: const Radius.circular(4),
    thickness: WidgetStateProperty.all(4),
  );
}

/// AppBar 테마
AppBarTheme appBarTheme(BuildContext context, FitColors colors, bool isDark) {
  return AppBarTheme(
    backgroundColor: colors.backgroundBase,
    foregroundColor: colors.textPrimary,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: colors.textPrimary),
    actionsIconTheme: IconThemeData(color: colors.textPrimary),
    titleTextStyle: context.subtitle2().copyWith(color: colors.textPrimary),
    toolbarTextStyle: context.subtitle2().copyWith(color: colors.textPrimary),
    titleSpacing: 0,
    toolbarHeight: 56,
    centerTitle: true,
    systemOverlayStyle: customSystemUiOverlayStyle(
      isDark: isDark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: colors.backgroundBase,
    ),
  );
}

/// 시스템 UI 오버레이 스타일
SystemUiOverlayStyle customSystemUiOverlayStyle({
  required bool isDark,
  required Color systemNavigationBarColor,
  Color statusBarColor = Colors.transparent,
}) {
  return SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: systemNavigationBarColor,
  );
}
