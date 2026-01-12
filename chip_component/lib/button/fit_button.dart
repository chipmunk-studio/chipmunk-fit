import 'dart:async';

import 'package:chip_component/fit_dot_loading.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprung/sprung.dart';

class FitButton extends StatefulWidget {
  const FitButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onDisabledPressed,
    this.type = FitButtonType.primary,
    this.style,
    this.padding,
    this.isExpanded = false,
    this.isEnabled = true,
    this.isLoading = false,
    this.enableRipple = false,
    this.loadingColor,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onDisabledPressed;
  final FitButtonType type;
  final ButtonStyle? style;
  final EdgeInsets? padding;
  final bool isExpanded;
  final bool isEnabled;
  final bool isLoading;
  final bool enableRipple;
  final Color? loadingColor;

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> {
  // 애니메이션 상수
  static const _kDebounceDuration = Duration(seconds: 1);
  static const _kAnimDuration = Duration(milliseconds: 600);
  static const _kPressedScale = 0.95;
  static final _kPressedCurve = Sprung.custom(damping: 8);
  static final _kReleasedCurve = Sprung.custom(damping: 6);

  bool _isPressed = false;
  Timer? _debounceTimer;

  bool get _isInteractive => widget.isEnabled && !widget.isLoading;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (_debounceTimer?.isActive ?? false) return;
    widget.onPressed?.call();
    _debounceTimer = Timer(_kDebounceDuration, () {});
  }

  void _setPressed(bool pressed) {
    if (mounted) setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: widget.isExpanded ? 20 : 12,
          horizontal: widget.isExpanded ? 20 : 14,
        );

    final button = GestureDetector(
      onTapDown: (_) {
        if (_isInteractive) {
          _setPressed(true);
        } else {
          widget.onDisabledPressed?.call();
        }
      },
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: _kAnimDuration,
        curve: _isPressed ? _kPressedCurve : _kReleasedCurve,
        transform: Matrix4.diagonal3Values(
          _isPressed ? _kPressedScale : 1.0,
          _isPressed ? _kPressedScale : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: FilledButton(
          style: _buildStyle(context, padding),
          onPressed: _isInteractive ? _handlePress : null,
          child: _buildContent(context),
        ),
      ),
    );

    return widget.isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : IntrinsicWidth(child: button);
  }

  /// 타입별 색상과 커스텀 스타일을 병합한 ButtonStyle 반환
  ButtonStyle _buildStyle(BuildContext context, EdgeInsets padding) {
    final colors = context.fitColors;
    final (bg, disabledBg, fg, disabledFg, border) = _resolveColors(colors);

    final baseStyle = FilledButton.styleFrom(
      backgroundColor: bg,
      disabledBackgroundColor: disabledBg,
      foregroundColor: fg,
      disabledForegroundColor: disabledFg,
      padding: padding,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: border ?? BorderSide.none,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(
        widget.enableRipple ? colors.grey600.withValues(alpha: 0.2) : Colors.transparent,
      ),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );

    // 커스텀 스타일이 있으면 병합 (커스텀 우선)
    return widget.style?.merge(baseStyle) ?? baseStyle;
  }

  /// 버튼 타입별 색상 반환 (bg, disabledBg, fg, disabledFg, border)
  (Color, Color, Color, Color, BorderSide?) _resolveColors(FitColors colors) {
    final theme = Theme.of(context).filledButtonTheme.style;
    final themeDisabledBg =
        theme?.backgroundColor?.resolve({WidgetState.disabled}) ?? colors.green50;
    final themeFg =
        theme?.foregroundColor?.resolve({WidgetState.selected}) ?? colors.staticBlack;

    return switch (widget.type) {
      FitButtonType.primary => (
          colors.main,
          themeDisabledBg,
          themeFg,
          colors.inverseDisabled,
          null,
        ),
      FitButtonType.secondary => (
          colors.grey900,
          colors.grey300,
          colors.inverseText,
          colors.textSecondary,
          null,
        ),
      FitButtonType.tertiary => (
          colors.fillStrong,
          colors.fillAlternative,
          colors.textDisabled,
          colors.textTertiary,
          null,
        ),
      FitButtonType.ghost => (
          Colors.transparent,
          Colors.transparent,
          colors.grey900,
          colors.grey300,
          BorderSide(color: colors.grey400, width: 1.0),
        ),
      FitButtonType.destructive => (
          colors.red500,
          colors.red50,
          colors.staticWhite,
          colors.inverseDisabled,
          null,
        ),
    };
  }

  /// 로딩 상태일 때 로딩 인디케이터 표시
  Widget _buildContent(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    return Stack(
      alignment: Alignment.center,
      children: [
        // 크기 유지용 숨김 child
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: widget.child,
        ),
        FitDotLoading(
          dotSize: 8,
          color: widget.loadingColor ?? FitButtonStyle.loadingColorOf(context, widget.type),
        ),
      ],
    );
  }
}
