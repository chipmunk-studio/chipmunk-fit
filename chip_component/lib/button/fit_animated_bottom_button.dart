import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 버튼
///
/// 키보드 상태에 따라 radius와 padding이 자동 애니메이션 처리됩니다.
/// [WidgetsBindingObserver]를 통해 키보드 변화를 감지합니다.
/// (BlocBuilder 등 InheritedWidget이 아닌 컨텍스트에서도 동작)
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
    this.borderRadius,
  });

  final VoidCallback? onPressed;
  final Widget child;
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
  static const _kAnimationDuration = Duration(milliseconds: 70);
  static const _kSafeAreaExtraPadding = 8.0;
  static const _kShadowOffset = Offset(0, -2);

  double _keyboardHeight = 0;
  double? _cachedBaseRadius;

  bool get _isKeyboardVisible => _keyboardHeight > _kKeyboardThreshold;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateKeyboardHeight());
  }

  @override
  void didUpdateWidget(FitAnimatedBottomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.borderRadius != widget.borderRadius ||
        oldWidget.style != widget.style) {
      _cachedBaseRadius = null;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() => _updateKeyboardHeight();

  void _updateKeyboardHeight() {
    if (!mounted) return;
    final view = View.of(context);
    final newHeight = view.viewInsets.bottom / view.devicePixelRatio;
    if (_keyboardHeight != newHeight) {
      setState(() => _keyboardHeight = newHeight);
    }
  }

  double get _baseRadius {
    return _cachedBaseRadius ??= _resolveBaseRadius();
  }

  double _resolveBaseRadius() {
    final radius = widget.borderRadius;
    if (radius != null) return radius;

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
    final mediaQuery = MediaQuery.of(context);
    final bgColor = widget.backgroundColor ?? colors.backgroundAlternative;
    final safeAreaBottom = widget.useSafeArea ? mediaQuery.padding.bottom : 0.0;
    final hasSafeArea = safeAreaBottom > 0;

    return TweenAnimationBuilder<double>(
      duration: _kAnimationDuration,
      curve: Curves.easeOutCubic,
      tween: Tween(end: _isKeyboardVisible ? 0.0 : 1.0),
      builder: (context, animValue, _) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: animValue > 0.5
                ? [BoxShadow(color: bgColor.withValues(alpha: 0.08), blurRadius: 8, offset: _kShadowOffset)]
                : null,
          ),
          padding: EdgeInsets.only(
            left: 20.w * animValue,
            right: 20.w * animValue,
            top: 12.h * animValue,
            bottom: hasSafeArea ? safeAreaBottom + _kSafeAreaExtraPadding : 16.h * animValue,
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

  ButtonStyle _buildButtonStyle(double animValue) {
    final animatedShape = WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_baseRadius * animValue),
      ),
    );

    // widget.style이 있으면 shape만 animatedShape로 덮어씌움 (다른 속성은 유지)
    return widget.style?.copyWith(shape: animatedShape) ??
        ButtonStyle(shape: animatedShape);
  }
}
