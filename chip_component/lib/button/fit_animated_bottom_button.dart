import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 버튼
///
/// 키보드 상태에 따라 radius와 padding이 자동 애니메이션 처리됩니다.
/// [KeyboardVisibilityBuilder]를 통해 키보드 변화를 자체적으로 감지합니다.
///
/// ```dart
/// FitAnimatedBottomButton(
///   isEnabled: state.isValid,
///   isLoading: state.isSubmitting,
///   onPressed: () => _submit(),
///   child: Text('확인'),
/// )
/// ```
class FitAnimatedBottomButton extends StatelessWidget {
  const FitAnimatedBottomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isLoading = false,
    this.loadingColor,
    this.useSafeArea = true,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final FitButtonType type;
  final ButtonStyle? style;
  final bool isEnabled;
  final bool isLoading;
  final Color? loadingColor;

  /// SafeArea 하단 패딩 사용 여부 (기본: true, 바텀시트에서는 false 권장)
  final bool useSafeArea;

  /// 배경색 (기본: backgroundBase)
  final Color? backgroundColor;

  static const _kAnimationDuration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;
    final bgColor = backgroundColor ?? colors.backgroundBase;
    final bottomPadding =
        useSafeArea ? MediaQueryData.fromView(View.of(context)).padding.bottom : 0.0;

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return TweenAnimationBuilder<double>(
          duration: _kAnimationDuration,
          curve: Curves.easeOutCubic,
          tween: Tween(end: isKeyboardVisible ? 0.0 : 1.0),
          builder: (context, animValue, _) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                boxShadow: animValue > 0.5
                    ? [
                        BoxShadow(
                            color: bgColor.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, -2))
                      ]
                    : null,
              ),
              padding: EdgeInsets.only(
                left: 20.w * animValue,
                right: 20.w * animValue,
                top: 12.h * animValue,
                bottom: bottomPadding > 0 ? bottomPadding + 8 : 16.h * animValue,
              ),
              child: FitButton(
                isExpanded: true,
                type: type,
                isLoading: isLoading,
                loadingColor: loadingColor ?? colors.violet500,
                isEnabled: isEnabled && !isLoading,
                style: _buildButtonStyle(animValue),
                onPressed: onPressed,
                child: child,
              ),
            );
          },
        );
      },
    );
  }

  ButtonStyle _buildButtonStyle(double animValue) {
    final animatedShape = ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r * animValue)),
      ),
    );
    return style?.merge(animatedShape) ?? animatedShape;
  }
}
