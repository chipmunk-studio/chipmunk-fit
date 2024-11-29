import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';

class FitButton extends StatefulWidget {
  final dartz.Function0? onPress;
  final dartz.Function0? onDisablePress;
  final ButtonStyle? style;
  final FitButtonType? type;
  final bool isExpand;
  final bool isEnabled;
  final EdgeInsets? padding;
  final Widget child;

  const FitButton({
    super.key,
    this.onPress,
    this.onDisablePress,
    this.type,
    this.style,
    this.isEnabled = true,
    this.isExpand = false,
    this.padding,
    required this.child,
  });

  @override
  State<FitButton> createState() => _FitButtonState();
}

class _FitButtonState extends State<FitButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTapDown: widget.onPress != null ? _onTapDown : _onDisableTap,
      onTapUp: widget.onPress != null ? _onTapUp : null,
      onTapCancel: widget.onPress != null ? _onTapCancel : null,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 0.95).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        ),
        child: ElevatedButton(
          style: widget.style ?? context.getButtonStyle(widget.type),
          onPressed: widget.isEnabled ? widget.onPress : null,
          child: Container(
            width: double.infinity,
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  // 기본값 설정
                  vertical: widget.isExpand ? 20 : 12,
                  horizontal: widget.isExpand ? 0 : 14,
                ),
            child: widget.child,
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
      return IntrinsicWidth(child: button);
    }
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  void _onDisableTap(TapDownDetails details) {
    if (widget.onDisablePress != null) {
      widget.onDisablePress?.call();
    }
  }
}
