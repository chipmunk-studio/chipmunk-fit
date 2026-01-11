import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 버튼
///
/// 키보드 상태에 따라 radius와 padding이 자동 애니메이션 처리됩니다.
///
/// **주의**: [parentContext]에 부모 StatefulWidget의 context를 전달해야 합니다.
///
/// ```dart
/// FitAnimatedBottomButton(
///   parentContext: context,
///   isEnabled: state.isValid,
///   isLoading: state.isSubmitting,
///   onPressed: () => _submit(),
///   child: Text('확인'),
/// )
/// ```
///
/// - Column 마지막에 배치
/// - `SafeArea(bottom: false)` 사용 (내부에서 처리)
class FitAnimatedBottomButton extends StatelessWidget {
  const FitAnimatedBottomButton({
    super.key,
    required this.parentContext,
    required this.onPressed,
    required this.child,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isLoading = false,
    this.loadingColor,
    this.useSafeArea = true,
  });

  /// 부모 위젯의 BuildContext (MediaQuery 감지용, 필수)
  final BuildContext parentContext;
  final VoidCallback? onPressed;
  final Widget child;

  /// 버튼 타입 (기본: primary)
  final FitButtonType type;

  /// 커스텀 버튼 스타일 (선택, type 기본 스타일을 오버라이드)
  final ButtonStyle? style;

  final bool isEnabled;
  final bool isLoading;
  final Color? loadingColor;

  /// SafeArea 하단 패딩 사용 여부 (기본: true, 바텀시트에서는 false 권장)
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final colors = parentContext.fitColors;
    final keyboardHeight = MediaQuery.of(parentContext).viewInsets.bottom;
    final bottomPadding = useSafeArea ? MediaQuery.of(parentContext).padding.bottom : 0.0;
    final isKeyboardVisible = keyboardHeight > 50;
    final targetValue = isKeyboardVisible ? 0.0 : 1.0;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 10),
      curve: Curves.easeInCubic,
      tween: Tween(end: targetValue),
      builder: (_, animValue, __) {
        // 키보드 상태에 따른 borderRadius 애니메이션을 위한 shape 스타일
        final animatedShapeStyle = ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r * animValue)),
          ),
        );

        // 최종 스타일: 사용자 커스텀 스타일 + 애니메이션 shape
        final effectiveStyle = style?.merge(animatedShapeStyle) ?? animatedShapeStyle;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.backgroundBase,
            boxShadow: animValue > 0.5
                ? [
                    BoxShadow(
                      color: colors.backgroundBase.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
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
            style: effectiveStyle,
            onPressed: onPressed,
            child: child,
          ),
        );
      },
    );
  }
}
