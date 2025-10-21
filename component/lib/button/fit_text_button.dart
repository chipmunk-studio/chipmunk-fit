import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foundation/textstyle.dart';

/// 텍스트 버튼 (디바운스 적용)
class FitTextButton extends StatefulWidget {
  final Function()? onPress;
  final String text;
  final TextStyle? textStyle;
  final Duration debounceDuration;

  const FitTextButton({
    super.key,
    required this.onPress,
    required this.text,
    this.textStyle,
    this.debounceDuration = const Duration(seconds: 3),
  });

  @override
  State<FitTextButton> createState() => _FitTextButtonState();
}

class _FitTextButtonState extends State<FitTextButton> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (_debounceTimer?.isActive ?? false) return;

    widget.onPress?.call();
    _debounceTimer = Timer(widget.debounceDuration, () {});
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPress != null ? _handlePress : null,
      child: Text(
        widget.text,
        style: widget.textStyle ?? context.body4(),
      ),
    );
  }
}
