import 'package:chip_assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'textstyle.dart';

/// 라이트 테마 생성
ThemeData fitLightTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
}) {
  final updatedColors = lightFitColors.copyWith(
    main: mainColor,
    sub: subColor,
  );

  return _buildThemeData(
    context,
    brightness: Brightness.light,
    colors: updatedColors,
  );
}

/// 다크 테마 생성
ThemeData fitDarkTheme(
  BuildContext context, {
  Color? mainColor,
  Color? subColor,
}) {
  final updatedColors = darkFitColors.copyWith(
    main: mainColor,
    sub: subColor,
  );

  return _buildThemeData(
    context,
    brightness: Brightness.dark,
    colors: updatedColors,
  );
}

/// 공통 ThemeData 생성 (중복 코드 제거)
ThemeData _buildThemeData(
  BuildContext context, {
  required Brightness brightness,
  required FitColors colors,
}) {
  final isDarkMode = FitThemeModeExtension(brightness: brightness);
  final isDark = brightness == Brightness.dark;

  return ThemeData(
    brightness: brightness,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    checkboxTheme: _checkboxThemeData(colors),
    unselectedWidgetColor: colors.grey800,
    scaffoldBackgroundColor: colors.grey900,
    fontFamily: ChipAssets.fonts.pretendardRegular,
    appBarTheme: _appBarTheme(context, colors, isDark),
    elevatedButtonTheme: _elevatedButtonTheme(context, colors),
    textButtonTheme: _textButtonTheme(colors),
    bottomSheetTheme: _bottomSheetTheme(colors),
    textSelectionTheme: _textSelectionTheme(colors, isDark),
    inputDecorationTheme: _inputDecorationTheme(colors),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(colors),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [colors, isDarkMode],
  );
}

/// 체크박스 테마
CheckboxThemeData _checkboxThemeData(FitColors fitColors) {
  return CheckboxThemeData(
    side: BorderSide(width: 1.5, color: fitColors.grey400),
    splashRadius: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    checkColor: MaterialStateProperty.all(Colors.black),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      return states.contains(MaterialState.selected) ? fitColors.main : fitColors.grey400;
    }),
    overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
      return states.contains(MaterialState.pressed) ? fitColors.main : Colors.transparent;
    }),
  );
}

/// 바텀 시트 테마
BottomSheetThemeData _bottomSheetTheme(FitColors fitColors) {
  return BottomSheetThemeData(backgroundColor: fitColors.grey800);
}

/// 엘리베이티드 버튼 테마
ElevatedButtonThemeData _elevatedButtonTheme(BuildContext context, FitColors fitColors) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: fitColors.main,
      disabledBackgroundColor: fitColors.grey600,
      foregroundColor: fitColors.grey900,
      disabledForegroundColor: fitColors.grey400,
      textStyle: context.button1().copyWith(color: fitColors.grey0),
    ).copyWith(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
    ),
  );
}

/// 바텀 네비게이션 바 테마
BottomNavigationBarThemeData _bottomNavigationBarTheme(FitColors fitColors) {
  final baseLabelStyle = TextStyle(
    fontFamily: ChipAssets.fonts.pretendardRegular,
    fontSize: 13,
  );

  return BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedLabelStyle: baseLabelStyle.copyWith(color: Colors.white),
    unselectedLabelStyle: baseLabelStyle.copyWith(color: fitColors.grey700),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: fitColors.grey700,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  );
}

/// 입력 필드 데코레이션 테마
InputDecorationTheme _inputDecorationTheme(FitColors fitColors) {
  final baseBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
  );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    disabledBorder: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    enabledBorder: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    focusedBorder: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.main),
    ),
    errorBorder: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.redBase),
    ),
    focusedErrorBorder: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.redBase),
    ),
    border: baseBorder.copyWith(
      borderSide: BorderSide(color: fitColors.dividerSecondary),
    ),
    counterStyle: TextStyle(color: fitColors.main),
  );
}

/// 텍스트 버튼 테마
TextButtonThemeData _textButtonTheme(FitColors fitColors) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: fitColors.grey800,
      disabledBackgroundColor: fitColors.grey700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    ),
  );
}

/// 텍스트 선택 테마
TextSelectionThemeData _textSelectionTheme(FitColors fitColors, bool isDark) {
  return TextSelectionThemeData(
    cursorColor: fitColors.main,
    selectionHandleColor: isDark ? fitColors.sub : null,
  );
}

/// AppBar 테마
AppBarTheme _appBarTheme(BuildContext context, FitColors fitColors, bool isDark) {
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

/// 시스템 UI 오버레이 스타일 (상태바, 네비게이션 바)
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

/// 테마 모드 확장 (다크/라이트 모드 판별)
class FitThemeModeExtension extends ThemeExtension<FitThemeModeExtension> {
  final Brightness brightness;

  const FitThemeModeExtension({required this.brightness});

  bool get isDarkMode => brightness == Brightness.dark;

  bool get isBright => brightness == Brightness.light;

  @override
  FitThemeModeExtension copyWith({Brightness? brightness}) {
    return FitThemeModeExtension(brightness: brightness ?? this.brightness);
  }

  @override
  ThemeExtension<FitThemeModeExtension> lerp(
    covariant ThemeExtension<FitThemeModeExtension>? other,
    double t,
  ) {
    if (other is! FitThemeModeExtension) return this;
    return FitThemeModeExtension(
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}

/// BuildContext에서 ThemeExtension을 쉽게 가져오는 확장 메서드
extension FitThemeModeExtensionOnContext on BuildContext {
  FitThemeModeExtension get fitThemeMode {
    return FitThemeModeExtension(brightness: Theme.of(this).brightness);
  }
}
