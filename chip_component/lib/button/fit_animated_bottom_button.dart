import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 고정 버튼
///
/// 키보드 표시 여부에 따라 radius/padding 애니메이션 자동 처리.
/// WidgetsBindingObserver로 키보드 감지 (BlocBuilder 등에서도 동작).
///
/// ```dart
/// // 일반 화면
/// FitAnimatedBottomButton(
///   isEnabled: state.isValid,
///   onPressed: () => _submit(),
///   child: Text('확인'),
/// )
///
/// // 바텀시트 (useSafeArea: false 권장)
/// FitAnimatedBottomButton(
///   useSafeArea: false,
///   onPressed: () => Navigator.pop(context),
///   child: Text('확인'),
/// )
/// ```
class FitAnimatedBottomButton extends StatefulWidget {
  const FitAnimatedBottomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isLoading = false,
    this.loadingColor,
    this.useSafeArea = true,
    this.backgroundColor,
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final FitButtonType type;
  final ButtonStyle? style;
  final bool isEnabled;
  final bool isLoading;
  final Color? loadingColor;
  final bool useSafeArea;
  final Color? backgroundColor;
  final double? borderRadius;

  @override
  State<FitAnimatedBottomButton> createState() => _FitAnimatedBottomButtonState();
}

class _FitAnimatedBottomButtonState extends State<FitAnimatedBottomButton>
    with WidgetsBindingObserver {
  static const _kKeyboardThreshold = 50.0;
  static const _kAnimDuration = Duration(milliseconds: 30);
  static const _kSafeAreaPadding = 8.0;

  double _keyboardHeight = 0;
  double? _cachedRadius;

  bool get _isKeyboardVisible => _keyboardHeight > _kKeyboardThreshold;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncKeyboardHeight());
  }

  @override
  void didUpdateWidget(FitAnimatedBottomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // borderRadius나 style 변경 시 캐시 무효화
    if (oldWidget.borderRadius != widget.borderRadius || oldWidget.style != widget.style) {
      _cachedRadius = null;
    }
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
    final view = View.of(context);
    final height = view.viewInsets.bottom / view.devicePixelRatio;
    if (_keyboardHeight != height) {
      setState(() => _keyboardHeight = height);
    }
  }

  /// borderRadius 우선순위: widget.borderRadius > style.shape > 기본값
  double get _baseRadius => _cachedRadius ??= _resolveRadius();

  double _resolveRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!;

    final shape = widget.style?.shape?.resolve({});
    if (shape is RoundedRectangleBorder) {
      final br = shape.borderRadius;
      if (br is BorderRadius) return br.topLeft.x;
    }
    return 100.r;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;
    final query = MediaQuery.of(context);
    final bgColor = widget.backgroundColor ?? colors.backgroundAlternative;
    final safeBottom = widget.useSafeArea ? query.padding.bottom : 0.0;

    return TweenAnimationBuilder<double>(
      duration: _kAnimDuration,
      curve: Curves.easeOutCubic,
      tween: Tween(end: _isKeyboardVisible ? 0.0 : 1.0),
      builder: (context, anim, _) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: anim > 0.5
              ? [
                  BoxShadow(
                      color: bgColor.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, -2))
                ]
              : null,
        ),
        padding: EdgeInsets.only(
          left: 20.w * anim,
          right: 20.w * anim,
          top: 12.h * anim,
          bottom: safeBottom > 0 ? safeBottom + _kSafeAreaPadding : 16.h * anim,
        ),
        child: FitButton(
          isExpanded: true,
          type: widget.type,
          style: _animatedStyle(anim),
          isEnabled: widget.isEnabled && !widget.isLoading,
          isLoading: widget.isLoading,
          loadingColor: widget.loadingColor ?? colors.violet500,
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }

  /// 애니메이션 값에 따라 shape만 동적 적용
  ButtonStyle _animatedStyle(double anim) {
    final shape = WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_baseRadius * anim),
      ),
    );
    return widget.style?.copyWith(shape: shape) ?? ButtonStyle(shape: shape);
  }
}
