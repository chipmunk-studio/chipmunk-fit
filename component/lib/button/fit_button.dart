import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foundation/buttonstyle.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';
import 'package:sprung/sprung.dart';

/// 커스텀 버튼 위젯 (스케일 애니메이션 및 디바운스 기능)
class FitButton extends StatefulWidget {
  final Function()? onPress;
  final Function()? onDisablePress;
  final ButtonStyle? style;
  final FitButtonType type;
  final FitTextSp textSp;
  final TextStyle? textStyle;
  final bool isExpand;
  final bool isEnabled;
  final bool isRipple;
  final EdgeInsets? padding;
  final Widget? child;
  final String? text;
  final Duration debounceDuration;
  final Duration animationDuration;
  final double pressedScale;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;

  const FitButton({
    super.key,
    this.onPress,
    this.onDisablePress,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isExpand = false,
    this.isRipple = false,
    this.textSp = FitTextSp.SP,
    this.textStyle,
    this.padding,
    this.child,
    this.text,
    this.debounceDuration = const Duration(seconds: 1),
    this.animationDuration = const Duration(milliseconds: 600),
    this.pressedScale = 0.95,
    this.backgroundColor,
    this.disabledBackgroundColor,
  });

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> {
  bool _isPressed = false;
  final _debouncer = _Debouncer();

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  void _handlePress() {
    _debouncer.run(
      action: widget.onPress,
      duration: widget.debounceDuration,
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPress != null && mounted) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPress != null && mounted) {
      setState(() => _isPressed = false);
    }
  }

  void _onTapCancel() {
    if (widget.onPress != null && mounted) {
      setState(() => _isPressed = false);
    }
  }

  void _onDisableTap(TapDownDetails details) {
    widget.onDisablePress?.call();
  }

  @override
  Widget build(BuildContext context) {
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: widget.isExpand ? 20 : 12,
          horizontal: widget.isExpand ? 0 : 14,
        );

    final buttonContent = widget.child ??
        Text(
          widget.text ?? '',
          textAlign: TextAlign.center,
          style: widget.textStyle ?? _getTextStyle(context),
        );

    final button = GestureDetector(
      onTapDown: widget.isEnabled ? _onTapDown : _onDisableTap,
      onTapUp: widget.isEnabled ? _onTapUp : null,
      onTapCancel: widget.isEnabled ? _onTapCancel : null,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: _isPressed ? Sprung.custom(damping: 8) : Sprung.custom(damping: 6),
        transform: Matrix4.identity()..scale(_isPressed ? widget.pressedScale : 1.0),
        transformAlignment: Alignment.center,
        child: ElevatedButton(
          style: _getButtonStyle(context),
          onPressed: widget.isEnabled ? _handlePress : null,
          child: Container(
            alignment: Alignment.center,
            width: widget.isExpand ? double.infinity : null,
            padding: effectivePadding,
            child: buttonContent,
          ),
        ),
      ),
    );

    return widget.isExpand
        ? SizedBox(width: double.infinity, child: button)
        : IntrinsicWidth(child: button);
  }

  /// 버튼 스타일 생성 (backgroundColor 지원)
  ButtonStyle _getButtonStyle(BuildContext context) {
    // style이 명시적으로 제공된 경우 우선 사용
    if (widget.style != null) {
      return widget.style!;
    }

    // backgroundColor가 제공된 경우 커스텀 스타일 생성
    if (widget.backgroundColor != null) {
      final baseStyle = context.getButtonStyle(
        widget.type,
        isRipple: widget.isRipple,
        isEnabled: widget.isEnabled,
      );

      return baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return widget.disabledBackgroundColor ?? widget.backgroundColor!.withValues(alpha: 0.5);
          }
          return widget.backgroundColor!;
        }),
      );
    }

    // 기본 스타일 사용
    return context.getButtonStyle(
      widget.type,
      isRipple: widget.isRipple,
      isEnabled: widget.isEnabled,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final colorMap = widget.isEnabled
        ? {
            FitButtonType.secondary: context.fitColors.inverseText,
            FitButtonType.tertiary: context.fitColors.grey900,
            FitButtonType.primary: context.fitColors.staticBlack,
            FitButtonType.ghost: context.fitColors.grey900,
            FitButtonType.destructive: context.fitColors.staticWhite,
          }
        : {
            FitButtonType.secondary: context.fitColors.textSecondary,
            FitButtonType.tertiary: context.fitColors.textDisabled,
            FitButtonType.primary: context.fitColors.inverseDisabled,
            FitButtonType.ghost: context.fitColors.grey300,
            FitButtonType.destructive: context.fitColors.inverseDisabled,
          };

    return context.button1(type: widget.textSp).copyWith(
          color: colorMap[widget.type] ?? context.fitColors.grey0,
          height: 1.0,
        );
  }
}

/// 디바운스 헬퍼 클래스
class _Debouncer {
  Timer? _timer;

  void run({
    required Function()? action,
    required Duration duration,
  }) {
    if (_timer?.isActive ?? false) return;

    action?.call();
    _timer = Timer(duration, () {});
  }

  void dispose() {
    _timer?.cancel();
  }
}
