import 'package:chipfit/foundation/index.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class FitButton extends StatefulWidget {
  final dartz.Function0? onPress;
  final dartz.Function0? onDisablePress;
  final ButtonStyle? style;
  final FitButtonType type;
  final FitTextSp textSp;
  final TextStyle? textStyle;
  final bool isExpand;
  final bool isEnabled;
  final bool isRipple;
  final EdgeInsets? padding;
  final Widget? child; // 기존 child 유지
  final String? text; // 추가된 텍스트 옵션

  const FitButton({
    super.key,
    this.onPress,
    this.onDisablePress,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isExpand = false,
    this.isRipple = false,
    this.textSp = FitTextSp.MIN,
    this.textStyle = null,
    this.padding,
    this.child,
    this.text,
  });

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTapDown: widget.onPress != null ? _onTapDown : _onDisableTap,
      onTapUp: widget.onPress != null ? _onTapUp : null,
      onTapCancel: widget.onPress != null ? _onTapCancel : null,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 600),
        curve: isPressed ? Sprung.custom(damping: 8) : Sprung.custom(damping: 6),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
        child: ElevatedButton(
          style: widget.style ??
              context.getButtonStyle(
                widget.type,
                isRipple: widget.isRipple,
                isEnabled: widget.isEnabled,
              ),
          onPressed: widget.isEnabled ? widget.onPress : null,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  vertical: widget.isExpand ? 16 : 12,
                  horizontal: widget.isExpand ? 0 : 14,
                ),
            child: widget.child ??
                Text(
                  widget.text ?? '',
                  textAlign: TextAlign.center,
                  style: widget.textStyle ??
                      _getTextStyle(
                        context,
                        widget.isEnabled,
                        widget.textSp,
                      ),
                ),
          ),
        ),
      ),
    );

    if (widget.isExpand) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: button,
        ),
      );
    }
  }

  TextStyle _getTextStyle(
    BuildContext context,
    bool isEnabled,
    FitTextSp type,
  ) {
    final color = isEnabled
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

    // 기본 색상 설정
    return context.button1(type: type).copyWith(
          color: color[widget.type] ?? context.fitColors.grey0,
        );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      isPressed = false;
    });
  }

  void _onDisableTap(TapDownDetails details) {
    if (widget.onDisablePress != null) {
      widget.onDisablePress?.call();
    }
  }
}
