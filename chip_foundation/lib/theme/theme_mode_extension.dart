import 'package:flutter/material.dart';

/// 테마 모드 확장
class FitThemeModeExtension extends ThemeExtension<FitThemeModeExtension> {
  final Brightness brightness;

  const FitThemeModeExtension({required this.brightness});

  bool get isDarkMode => brightness == Brightness.dark;
  bool get isLightMode => brightness == Brightness.light;

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
    return t < 0.5 ? this : other;
  }
}

/// BuildContext 테마 모드 확장
extension FitThemeModeExtensionOnContext on BuildContext {
  FitThemeModeExtension get fitThemeMode {
    return Theme.of(this).extension<FitThemeModeExtension>() ??
        FitThemeModeExtension(brightness: Theme.of(this).brightness);
  }

  bool get isDarkMode => fitThemeMode.isDarkMode;
  bool get isLightMode => fitThemeMode.isLightMode;
}
