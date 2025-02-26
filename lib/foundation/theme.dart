import 'package:chipfit/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'textstyle.dart';

ThemeData fitLightTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
}) {
  final FitColors updatedColors = lightFitColors.copyWith(
    main: mainColor ?? lightFitColors.main,
    sub: subColor ?? lightFitColors.sub,
  );

  final isDarkMode = FitThemeModeExtension(brightness: Brightness.light);

  return ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    checkboxTheme: _checkboxThemeData(updatedColors),
    unselectedWidgetColor: updatedColors.grey800,
    scaffoldBackgroundColor: updatedColors.grey900,
    fontFamily: Assets.fonts.pretendardRegular,
    appBarTheme: appBarTheme(context, updatedColors, false),
    elevatedButtonTheme: elevatedButtonTheme(context, updatedColors),
    textButtonTheme: textButtonTheme(updatedColors),
    bottomSheetTheme: bottomSheetTheme(updatedColors),
    textSelectionTheme: TextSelectionThemeData(cursorColor: updatedColors.main),
    inputDecorationTheme: inputDecorationTheme(updatedColors),
    bottomNavigationBarTheme: bottomNavigationBarTheme(updatedColors),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [
      updatedColors,
      isDarkMode,
    ],
  );
}

ThemeData fitDarkTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
}) {
  final FitColors updatedColors = darkFitColors.copyWith(
    main: mainColor ?? darkFitColors.main,
    sub: subColor ?? darkFitColors.sub,
  );

  final isDarkMode = FitThemeModeExtension(brightness: Brightness.dark);

  return ThemeData(
    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    checkboxTheme: _checkboxThemeData(updatedColors),
    unselectedWidgetColor: updatedColors.grey800,
    scaffoldBackgroundColor: updatedColors.grey900,
    fontFamily: Assets.fonts.pretendardRegular,
    appBarTheme: appBarTheme(context, updatedColors, true),
    elevatedButtonTheme: elevatedButtonTheme(context, updatedColors),
    textButtonTheme: textButtonTheme(updatedColors),
    bottomSheetTheme: bottomSheetTheme(updatedColors),
    textSelectionTheme: TextSelectionThemeData(cursorColor: updatedColors.main),
    inputDecorationTheme: inputDecorationTheme(updatedColors),
    bottomNavigationBarTheme: bottomNavigationBarTheme(updatedColors),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [updatedColors, isDarkMode],
  );
}

_checkboxThemeData(FitColors fitColors) {
  return CheckboxThemeData(
    side: BorderSide(
      width: 1.5,
      color: fitColors.grey400,
    ),
    splashRadius: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    ),
    checkColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.black),
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (!states.contains(MaterialState.selected)) {
          return fitColors.grey400; // 체크박스가 선택된경우.
        }
        return fitColors.main; // 체크박스가 활성화된 경우
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(MaterialState.pressed)) {
          return fitColors.main; // 체크박스가 눌린 경우
        }
        return Colors.transparent; // 체크박스가 눌리지 않은 경우
      },
    ),
  );
}

bottomSheetTheme(FitColors fitColors) {
  return BottomSheetThemeData(
    backgroundColor: fitColors.grey800,
  );
}

elevatedButtonTheme(BuildContext context, FitColors fitColors) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
      ),
      // Enabled button color
      backgroundColor: fitColors.main,
      // Disabled button color
      disabledBackgroundColor: fitColors.grey600,
      // Enabled text color
      foregroundColor: fitColors.grey900,
      // Disabled text color
      disabledForegroundColor: fitColors.grey400,
      textStyle: context.button1().copyWith(color: fitColors.grey0),
    ).copyWith(
      overlayColor: MaterialStateProperty.all(Colors.transparent), // 리플 효과 제거
      shadowColor: MaterialStateProperty.all(Colors.transparent), // 그림자 제거
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent), // 클릭 시 잔여 색상 제거
    ),
  );
}

bottomNavigationBarTheme(FitColors fitColors) {
  return BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedLabelStyle: TextStyle(
      fontFamily: Assets.fonts.pretendardRegular,
      color: Colors.white,
      fontSize: 13.sp,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: Assets.fonts.pretendardRegular,
      color: fitColors.grey700,
      fontSize: 13.sp,
    ),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: fitColors.grey700,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  );
}

inputDecorationTheme(FitColors fitColors) {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    // contentPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.main),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.redBase),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.redBase),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    counterStyle: TextStyle(color: fitColors.main),
  );
}

textButtonTheme(FitColors fitColors) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      // 버튼의 텍스트 색상을 변경
      foregroundColor: Colors.white,
      // 버튼의 배경색을 변경
      backgroundColor: fitColors.grey800,
      disabledBackgroundColor: fitColors.grey700,
      // 버튼의 최소 크기 설정
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    ),
  );
}

appBarTheme(BuildContext context, FitColors fitColors, bool isDark) {
  return AppBarTheme(
    color: fitColors.grey900,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: fitColors.grey0),
    toolbarTextStyle: context.subtitle2().copyWith(color: fitColors.grey0),
    titleTextStyle: context.subtitle2().copyWith(color: fitColors.grey0),
    titleSpacing: 0,
    toolbarHeight: 60,
    systemOverlayStyle: customSystemUiOverlayStyle(
      isDark: isDark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: fitColors.grey900,
    ),
  );
}

SystemUiOverlayStyle customSystemUiOverlayStyle({
  required bool isDark,
  required Color systemNavigationBarColor,
  Color statusBarColor = Colors.transparent,
}) {
  return SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    // iOS 상태바 아이콘 밝기
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    // Android 상태바 아이콘 밝기
    systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    // 내비게이션 바 아이콘 밝기
    systemNavigationBarColor: systemNavigationBarColor, // 내비게이션 바 색상
  );
}
class FitThemeModeExtension extends ThemeExtension<FitThemeModeExtension> {
  final Brightness brightness;

  const FitThemeModeExtension({required this.brightness});

  bool get isDarkMode => brightness == Brightness.dark;
  bool get isBright => brightness == Brightness.light;

  @override
  FitThemeModeExtension copyWith({Brightness? brightness}) {
    return FitThemeModeExtension(
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  ThemeExtension<FitThemeModeExtension> lerp(
      covariant ThemeExtension<FitThemeModeExtension>? other, double t) {
    if (other is! FitThemeModeExtension) {
      return this;
    }
    return FitThemeModeExtension(
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}

/// **BuildContext에서 ThemeExtension을 쉽게 가져오는 확장 메서드**
extension FitThemeModeExtensionOnContext on BuildContext {
  FitThemeModeExtension get fitThemeMode {
    final theme = Theme.of(this);
    final brightness = theme.brightness; // 현재 밝기 상태 가져오기
    return FitThemeModeExtension(brightness: brightness);
  }
}
