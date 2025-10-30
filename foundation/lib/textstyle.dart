import 'package:chip_assets/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

/// 폰트 크기 타입
enum FitTextSp {
  /// 최소 크기 (화면 비율 무시)
  MIN,

  /// 최대 크기 (화면 비율 무시)
  MAX,

  /// 화면 비율 적용
  SP,

  /// 웹 반응형 (데스크톱/태블릿/모바일 자동)
  RESPONSIVE
}

/// BuildContext에 텍스트 스타일 생성 기능 추가
extension FitTextStyleExtension on BuildContext {
  /// 기본 텍스트 스타일 설정
  static const double _defaultLetterSpacing = -0.06;
  static const double _defaultLineHeight = 1.4;
  static const double _captionLineHeight = 1.0;

  // 반응형 체크 헬퍼
  bool get _isDesktop => MediaQuery.of(this).size.width > 900;

  bool get _isTablet =>
      MediaQuery.of(this).size.width > 600 && MediaQuery.of(this).size.width <= 900;

  bool get _isMobile => MediaQuery.of(this).size.width <= 600;

  // Heading Styles
  TextStyle h1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 28,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
      // 반응형일 때 데스크톱/태블릿/모바일 크기
      desktopSize: 40,
      tabletSize: 32,
    );
  }

  TextStyle h2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 24,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
      desktopSize: 32,
      tabletSize: 28,
    );
  }

  TextStyle h3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      color: this.fitColors.grey900,
      desktopSize: 24,
      tabletSize: 22,
    );
  }

  // Subtitle Styles
  TextStyle subtitle1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      desktopSize: 22,
      tabletSize: 21,
    );
  }

  TextStyle subtitle2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 20,
      type: type,
      fontFamily: FontFamily.pretendardMedium,
      desktopSize: 22,
      tabletSize: 21,
    );
  }

  TextStyle subtitle3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      desktopSize: 20,
      tabletSize: 19,
    );
  }

  TextStyle subtitle4({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 16,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      desktopSize: 18,
      tabletSize: 17,
    );
  }

  TextStyle subtitle5({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 15,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      desktopSize: 17,
      tabletSize: 16,
    );
  }

  TextStyle subtitle6({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 14,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      desktopSize: 15,
      tabletSize: 14,
    );
  }

  // Body Styles
  TextStyle body1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
      desktopSize: 19,
      tabletSize: 18,
    );
  }

  TextStyle body2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 16,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
      desktopSize: 17,
      tabletSize: 16,
    );
  }

  TextStyle body3({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 15,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
      desktopSize: 16,
      tabletSize: 15,
    );
  }

  TextStyle body4({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 14,
      type: type,
      fontFamily: FontFamily.pretendardRegular,
      desktopSize: 15,
      tabletSize: 14,
    );
  }

  // Button Style
  TextStyle button1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 18,
      type: type,
      fontFamily: FontFamily.pretendardMedium,
      desktopSize: 19,
      tabletSize: 18,
    );
  }

  // Caption Styles
  TextStyle caption1({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 12,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      lineHeight: _captionLineHeight,
      desktopSize: 13,
      tabletSize: 12,
    );
  }

  TextStyle caption2({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 10,
      type: type,
      fontFamily: FontFamily.pretendardSemiBold,
      lineHeight: _captionLineHeight,
      desktopSize: 11,
      tabletSize: 10,
    );
  }

  // Special Font
  TextStyle neodgm({FitTextSp type = FitTextSp.MIN}) {
    return _createTextStyle(
      fontSize: 30,
      type: type,
      fontFamily: FontFamily.neodgm,
      lineHeight: _captionLineHeight,
      desktopSize: 32,
      tabletSize: 31,
    );
  }

  /// 공통 텍스트 스타일 생성
  ///
  /// [fontSize] - 모바일 기본 폰트 크기
  /// [type] - 폰트 크기 타입
  /// [fontFamily] - 폰트 패밀리
  /// [lineHeight] - 줄 높이
  /// [color] - 텍스트 색상
  /// [desktopSize] - 데스크톱 폰트 크기 (RESPONSIVE일 때만 사용)
  /// [tabletSize] - 태블릿 폰트 크기 (RESPONSIVE일 때만 사용)
  TextStyle _createTextStyle({
    required double fontSize,
    required FitTextSp type,
    required String fontFamily,
    double lineHeight = _defaultLineHeight,
    Color? color,
    double? desktopSize,
    double? tabletSize,
  }) {
    return TextStyle(
      fontSize: _getFontSize(
        baseSize: fontSize,
        type: type,
        desktopSize: desktopSize,
        tabletSize: tabletSize,
      ),
      letterSpacing: _defaultLetterSpacing,
      height: lineHeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontFamily: fontFamily,
    );
  }

  /// 폰트 크기 계산 (타입별 처리)
  double _getFontSize({
    required double baseSize,
    required FitTextSp type,
    double? desktopSize,
    double? tabletSize,
  }) {
    switch (type) {
      case FitTextSp.MIN:
        return baseSize.spMin;
      case FitTextSp.MAX:
        return baseSize.spMax;
      case FitTextSp.SP:
        return baseSize.sp;
      case FitTextSp.RESPONSIVE:
        // 웹 반응형: 화면 크기에 따라 다른 폰트 사이즈 반환
        if (_isDesktop && desktopSize != null) return desktopSize;
        if (_isTablet && tabletSize != null) return tabletSize;
        return baseSize;
    }
  }
}

/// 반응형 값을 쉽게 가져오는 Extension
extension ResponsiveSizeExtension on BuildContext {
  /// 반응형 값 반환 헬퍼
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.of(this).size.width;
    if (width > 900 && desktop != null) return desktop;
    if (width > 600 && width <= 900 && tablet != null) return tablet;
    return mobile;
  }

  /// 반응형 double 값 (숫자만 필요할 때)
  double responsiveDouble({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(this).size.width;
    if (width > 900 && desktop != null) return desktop;
    if (width > 600 && width <= 900 && tablet != null) return tablet;
    return mobile;
  }

  /// 반응형 EdgeInsets
  EdgeInsets responsivePadding({
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    final width = MediaQuery.of(this).size.width;
    if (width > 900 && desktop != null) return desktop;
    if (width > 600 && width <= 900 && tablet != null) return tablet;
    return mobile;
  }

  /// 간단한 대칭 패딩
  EdgeInsets responsiveSymmetricPadding({
    double? mobileH,
    double? mobileV,
    double? tabletH,
    double? tabletV,
    double? desktopH,
    double? desktopV,
  }) {
    final width = MediaQuery.of(this).size.width;
    if (width > 900) {
      return EdgeInsets.symmetric(
        horizontal: desktopH ?? 60,
        vertical: desktopV ?? 40,
      );
    }
    if (width > 600 && width <= 900) {
      return EdgeInsets.symmetric(
        horizontal: tabletH ?? 40,
        vertical: tabletV ?? 32,
      );
    }
    return EdgeInsets.symmetric(
      horizontal: mobileH ?? 24,
      vertical: mobileV ?? 24,
    );
  }
}
