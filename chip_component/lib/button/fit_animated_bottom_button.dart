import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 버튼
///
/// 키보드 상태에 따라 radius와 padding이 자동 애니메이션 처리됩니다.
/// [WidgetsBindingObserver]를 통해 키보드 변화를 자체적으로 감지합니다.
///
/// ## 사용 예시
/// ```dart
/// // 일반 화면에서 사용
/// FitAnimatedBottomButton(
///   isEnabled: state.isValid,
///   isLoading: state.isSubmitting,
///   onPressed: () => _submit(),
///   child: Text('확인'),
/// )
///
/// // 바텀시트에서 사용 (useSafeArea: false 권장)
/// FitAnimatedBottomButton(
///   useSafeArea: false,
///   onPressed: () => Navigator.pop(context),
///   child: Text('확인'),
/// )
/// ```
class FitAnimatedBottomButton extends StatefulWidget {
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

  /// 버튼 클릭 콜백
  final VoidCallback? onPressed;

  /// 버튼 내부 위젯
  final Widget child;

  /// 버튼 타입 (primary, secondary, tertiary, ghost, destructive)
  final FitButtonType type;

  /// 커스텀 버튼 스타일
  final ButtonStyle? style;

  /// 버튼 활성화 여부
  final bool isEnabled;

  /// 로딩 상태
  final bool isLoading;

  /// 로딩 인디케이터 색상
  final Color? loadingColor;

  /// SafeArea 하단 패딩 사용 여부 (기본: true, 바텀시트에서는 false 권장)
  final bool useSafeArea;

  /// 배경색 (기본: backgroundAlternative)
  final Color? backgroundColor;

  @override
  State<FitAnimatedBottomButton> createState() => _FitAnimatedBottomButtonState();
}

class _FitAnimatedBottomButtonState extends State<FitAnimatedBottomButton>
    with WidgetsBindingObserver {
  /// 키보드가 표시되었다고 판단하는 최소 높이 (pixels)
  static const _kKeyboardThreshold = 50.0;

  /// 애니메이션 지속 시간
  static const _kAnimationDuration = Duration(milliseconds: 70);

  /// 키보드 숨김 상태 패딩
  static const _kDefaultHorizontalPadding = 20.0;
  static const _kDefaultTopPadding = 12.0;
  static const _kDefaultBottomPadding = 16.0;
  static const _kSafeAreaExtraPadding = 8.0;

  /// 현재 키보드 높이
  double _keyboardHeight = 0;

  /// 키보드 표시 여부
  bool get _isKeyboardVisible => _keyboardHeight > _kKeyboardThreshold;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncKeyboardHeight());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() => _syncKeyboardHeight();

  void _syncKeyboardHeight() {
    if (!mounted) return;
    final newHeight = MediaQueryData.fromView(View.of(context)).viewInsets.bottom;
    if (_keyboardHeight != newHeight) {
      setState(() => _keyboardHeight = newHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;
    final mediaQueryData = MediaQueryData.fromView(View.of(context));
    final bgColor = widget.backgroundColor ?? colors.backgroundAlternative;
    final safeAreaBottom = widget.useSafeArea ? mediaQueryData.padding.bottom : 0.0;

    return TweenAnimationBuilder<double>(
      duration: _kAnimationDuration,
      curve: Curves.easeOutCubic,
      tween: Tween(end: _isKeyboardVisible ? 0.0 : 1.0),
      builder: (context, animValue, child) {
        final horizontalPadding = _kDefaultHorizontalPadding.w * animValue;
        final topPadding = _kDefaultTopPadding.h * animValue;
        final bottomPadding = safeAreaBottom > 0
            ? safeAreaBottom + _kSafeAreaExtraPadding
            : _kDefaultBottomPadding.h * animValue;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: animValue > 0.5 ? _buildShadow(bgColor) : null,
          ),
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: FitButton(
            isExpanded: true,
            type: widget.type,
            isLoading: widget.isLoading,
            loadingColor: widget.loadingColor ?? colors.violet500,
            isEnabled: widget.isEnabled && !widget.isLoading,
            style: _buildButtonStyle(animValue),
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        );
      },
    );
  }

  List<BoxShadow> _buildShadow(Color bgColor) {
    return [
      BoxShadow(
        color: bgColor.withValues(alpha: 0.08),
        blurRadius: 8,
        offset: const Offset(0, -2),
      ),
    ];
  }

  ButtonStyle _buildButtonStyle(double animValue) {
    final animatedBorderRadius = BorderRadius.circular(100.r * animValue);
    final animatedShape = WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: animatedBorderRadius),
    );

    // 커스텀 스타일이 있어도 shape는 항상 애니메이션 값으로 덮어씌움
    if (widget.style != null) {
      return widget.style!.copyWith(shape: animatedShape);
    }
    return ButtonStyle(shape: animatedShape);
  }
}
