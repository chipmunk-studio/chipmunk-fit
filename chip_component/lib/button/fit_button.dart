import 'dart:async';

import 'package:chip_component/fit_dot_loading.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprung/sprung.dart';

/// 커스텀 버튼 위젯 (스케일 애니메이션 및 디바운스 기능)
class FitButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onDisabledPressed;
  final FitButtonType type;
  final ButtonStyle? style;
  final Widget child;
  final EdgeInsets? padding;
  final bool isExpanded;
  final bool isEnabled;
  final bool isLoading;
  final bool enableRipple;
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
  static final _pressedCurve = Sprung.custom(damping: 8);
  static final _releasedCurve = Sprung.custom(damping: 6);

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
    _debounceTimer = Timer(_debounceDuration, () {});
  }

  void _onTapDown(TapDownDetails _) {
    if (_isInteractive && mounted) {
      setState(() => _isPressed = true);
    } else {
      widget.onDisabledPressed?.call();
    }
  }

  void _onTapUp(TapUpDetails _) {
    if (mounted) setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    if (mounted) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: widget.isExpanded ? 20 : 12,
          horizontal: widget.isExpanded ? 20 : 14,
        );

    final button = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: _isPressed ? _pressedCurve : _releasedCurve,
        transform: Matrix4.identity()..scale(_isPressed ? _pressedScale : 1.0),
        transformAlignment: Alignment.center,
        child: FilledButton(
          style: _resolveButtonStyle(context, padding),
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
    final btnColors = _getButtonColors(colors);

    final baseStyle = FilledButton.styleFrom(
      backgroundColor: btnColors.bg,
      disabledBackgroundColor: btnColors.disabledBg,
      foregroundColor: btnColors.fg,
      disabledForegroundColor: btnColors.disabledFg,
      padding: padding,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.r),
        side: btnColors.border ?? BorderSide.none,
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.all(
        widget.enableRipple ? colors.grey600.withValues(alpha: 0.2) : Colors.transparent,
      ),
      elevation: WidgetStateProperty.all(0),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    );

    return baseStyle.merge(widget.style);
  }

  _ButtonColors _getButtonColors(FitColors colors) {
    final themeStyle = Theme.of(context).filledButtonTheme.style;
    final themeDisabledBg =
        themeStyle?.backgroundColor?.resolve({WidgetState.disabled}) ?? colors.green50;
    final themeFg =
        themeStyle?.foregroundColor?.resolve({WidgetState.selected}) ?? colors.staticBlack;

    return switch (widget.type) {
      FitButtonType.primary => _ButtonColors(
          bg: colors.main,
          disabledBg: themeDisabledBg,
          fg: themeFg,
          disabledFg: colors.inverseDisabled,
        ),
      FitButtonType.secondary => _ButtonColors(
          bg: colors.grey900,
          disabledBg: colors.grey300,
          fg: colors.inverseText,
          disabledFg: colors.textSecondary,
        ),
      FitButtonType.tertiary => _ButtonColors(
          bg: colors.fillStrong,
          disabledBg: colors.fillAlternative,
          fg: colors.textDisabled,
          disabledFg: colors.textTertiary,
        ),
      FitButtonType.ghost => _ButtonColors(
          bg: Colors.transparent,
          disabledBg: Colors.transparent,
          fg: colors.grey900,
          disabledFg: colors.grey300,
          border: BorderSide(color: colors.grey400, width: 1.0),
        ),
      FitButtonType.destructive => _ButtonColors(
          bg: colors.red500,
          disabledBg: colors.red50,
          fg: colors.staticWhite,
          disabledFg: colors.inverseDisabled,
        ),
    };
  }

  Widget _buildContent() {
    if (!widget.isLoading) return widget.child;

    return Stack(
      alignment: Alignment.center,
      children: [
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

class _ButtonColors {
  final Color bg;
  final Color disabledBg;
  final Color fg;
  final Color disabledFg;
  final BorderSide? border;

  const _ButtonColors({
    required this.bg,
    required this.disabledBg,
    required this.fg,
    required this.disabledFg,
    this.border,
  });
}
