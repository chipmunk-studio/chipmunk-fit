import 'dart:async';

import 'package:chip_component/fit_dot_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:sprung/sprung.dart';

/// 커스텀 버튼 위젯 (스케일 애니메이션 및 디바운스 기능)
class FitButton extends StatefulWidget {
  /// 버튼 클릭 콜백
  final VoidCallback? onPressed;

  /// 비활성화 상태에서 클릭 시 콜백
  final VoidCallback? onDisabledPressed;

  /// 버튼 타입 (primary, secondary, tertiary, ghost, destructive)
  final FitButtonType type;

  /// 커스텀 버튼 스타일 (type 기본 스타일을 오버라이드)
  final ButtonStyle? style;

  /// 버튼 내부 위젯
  final Widget child;

  /// 버튼 패딩
  final EdgeInsets? padding;

  /// 가로 전체 확장 여부
  final bool isExpanded;

  /// 활성화 상태
  final bool isEnabled;

  /// 로딩 상태
  final bool isLoading;

  /// 리플 효과 활성화
  final bool enableRipple;

  /// 로딩 인디케이터 색상
  final Color? loadingColor;

  const FitButton({
    super.key,
    this.onPressed,
    this.onDisabledPressed,
    this.type = FitButtonType.primary,
    this.style,
    required this.child,
    this.padding,
    this.isExpanded = false,
    this.isEnabled = true,
    this.isLoading = false,
    this.enableRipple = false,
    this.loadingColor,
  });

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> {
  static const _debounceDuration = Duration(seconds: 1);
  static const _animationDuration = Duration(milliseconds: 600);
  static const _pressedScale = 0.95;

  bool _isPressed = false;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  bool get _isInteractive => widget.isEnabled && !widget.isLoading;

  void _handlePress() {
    if (_debounceTimer?.isActive ?? false) return;
    widget.onPressed?.call();
    _debounceTimer = Timer(_debounceDuration, () {});
  }

  void _onTapDown(TapDownDetails details) {
    if (_isInteractive && mounted) {
      setState(() => _isPressed = true);
    } else {
      widget.onDisabledPressed?.call();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (mounted) setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    if (mounted) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: widget.isExpanded ? 20 : 12,
          horizontal: widget.isExpanded ? 20 : 14,
        );

    final buttonStyle = _resolveButtonStyle(context, effectivePadding);

    final button = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: _isPressed ? Sprung.custom(damping: 8) : Sprung.custom(damping: 6),
        transform: Matrix4.identity()..scale(_isPressed ? _pressedScale : 1.0),
        transformAlignment: Alignment.center,
        child: FilledButton(
          style: buttonStyle,
          onPressed: _isInteractive ? _handlePress : null,
          child: _buildContent(),
        ),
      ),
    );

    return widget.isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : IntrinsicWidth(child: button);
  }

  ButtonStyle _resolveButtonStyle(BuildContext context, EdgeInsets padding) {
    final colors = context.fitColors;
    final buttonColors = _getButtonColors(colors);

    final baseStyle = FilledButton.styleFrom(
      backgroundColor: buttonColors.background,
      disabledBackgroundColor: buttonColors.disabledBackground,
      foregroundColor: buttonColors.foreground,
      disabledForegroundColor: buttonColors.disabledForeground,
      padding: padding,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: buttonColors.border ?? BorderSide.none,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(
        widget.enableRipple ? colors.grey600.withValues(alpha: 0.2) : Colors.transparent,
      ),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );

    if (widget.style == null) return baseStyle;
    return baseStyle.merge(widget.style);
  }

  _ButtonColors _getButtonColors(FitColors colors) {
    switch (widget.type) {
      case FitButtonType.primary:
        return _ButtonColors(
          background: colors.main,
          disabledBackground: colors.green50,
          foreground: colors.staticBlack,
          disabledForeground: colors.inverseDisabled,
        );
      case FitButtonType.secondary:
        return _ButtonColors(
          background: colors.grey900,
          disabledBackground: colors.grey300,
          foreground: colors.inverseText,
          disabledForeground: colors.textSecondary,
        );
      case FitButtonType.tertiary:
        return _ButtonColors(
          background: colors.fillStrong,
          disabledBackground: colors.fillAlternative,
          foreground: colors.textDisabled,
          disabledForeground: colors.textTertiary,
        );
      case FitButtonType.ghost:
        return _ButtonColors(
          background: Colors.transparent,
          disabledBackground: Colors.transparent,
          foreground: colors.grey900,
          disabledForeground: colors.grey300,
          border: BorderSide(color: colors.grey400, width: 1.0),
        );
      case FitButtonType.destructive:
        return _ButtonColors(
          background: colors.red500,
          disabledBackground: colors.red50,
          foreground: colors.staticWhite,
          disabledForeground: colors.inverseDisabled,
        );
    }
  }

  Widget _buildContent() {
    final content = FittedBox(
      fit: BoxFit.scaleDown,
      child: widget.child,
    );

    if (!widget.isLoading) return content;

    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: content,
        ),
        FitDotLoading(
          dotSize: 8,
          color: widget.loadingColor ?? FitButtonStyle.loadingColorOf(context, widget.type),
        ),
      ],
    );
  }
}

class _ButtonColors {
  final Color background;
  final Color disabledBackground;
  final Color foreground;
  final Color disabledForeground;
  final BorderSide? border;

  _ButtonColors({
    required this.background,
    required this.disabledBackground,
    required this.foreground,
    required this.disabledForeground,
    this.border,
  });
}
