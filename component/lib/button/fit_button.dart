import 'dart:async';

import 'package:component/fit_dot_loading.dart';
import 'package:flutter/material.dart';
import 'package:foundation/buttonstyle.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';
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
  final Widget? child;

  /// 버튼 텍스트 (child가 없을 때 사용)
  final String? text;

  /// 텍스트 스타일
  final TextStyle? textStyle;

  /// 텍스트 SP 타입
  final FitTextSp textSp;

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

  /// 디바운스 시간
  final Duration debounceDuration;

  /// 스케일 애니메이션 시간
  final Duration animationDuration;

  /// 눌렸을 때 스케일
  final double pressedScale;

  const FitButton({
    super.key,
    this.onPressed,
    this.onDisabledPressed,
    this.type = FitButtonType.primary,
    this.style,
    this.child,
    this.text,
    this.textStyle,
    this.textSp = FitTextSp.SP,
    this.padding,
    this.isExpanded = false,
    this.isEnabled = true,
    this.isLoading = false,
    this.enableRipple = false,
    this.loadingColor,
    this.debounceDuration = const Duration(seconds: 1),
    this.animationDuration = const Duration(milliseconds: 600),
    this.pressedScale = 0.95,
  });

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> {
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
    _debounceTimer = Timer(widget.debounceDuration, () {});
  }

  void _onTapDown(TapDownDetails details) {
    if (_isInteractive && mounted) {
      setState(() => _isPressed = true);
    } else {
      widget.onDisabledPressed?.call();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isInteractive && mounted) {
      setState(() => _isPressed = false);
    }
  }

  void _onTapCancel() {
    if (_isInteractive && mounted) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: widget.isExpanded ? 20 : 12,
          horizontal: widget.isExpanded ? 0 : 14,
        );

    final buttonStyle = _resolveButtonStyle(context);
    final buttonContent = _buildContent(context);

    final button = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _isInteractive ? _onTapUp : null,
      onTapCancel: _isInteractive ? _onTapCancel : null,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: _isPressed ? Sprung.custom(damping: 8) : Sprung.custom(damping: 6),
        transform: Matrix4.identity()..scale(_isPressed ? widget.pressedScale : 1.0),
        transformAlignment: Alignment.center,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: _isInteractive ? _handlePress : null,
          child: Container(
            alignment: Alignment.center,
            width: widget.isExpanded ? double.infinity : null,
            padding: effectivePadding,
            child: buttonContent,
          ),
        ),
      ),
    );

    return widget.isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : IntrinsicWidth(child: button);
  }

  ButtonStyle _resolveButtonStyle(BuildContext context) {
    final baseStyle = FitButtonStyle.of(
      context,
      widget.type,
      isRipple: widget.enableRipple,
    );

    if (widget.style == null) return baseStyle;
    return baseStyle.merge(widget.style);
  }

  Widget _buildContent(BuildContext context) {
    final content = widget.child ??
        Text(
          widget.text ?? '',
          textAlign: TextAlign.center,
          style: widget.textStyle ?? _getTextStyle(context),
        );

    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !widget.isLoading,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: content,
        ),
        if (widget.isLoading)
          FitDotLoading(
            dotSize: 8,
            color: widget.loadingColor ??
                FitButtonStyle.loadingColorOf(context, widget.type),
          ),
      ],
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final color = FitButtonStyle.textColorOf(
      context,
      widget.type,
      isEnabled: widget.isEnabled,
    );

    return context.button1(type: widget.textSp).copyWith(
          color: color,
          height: 1.0,
        );
  }
}
