import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

/// 커스텀 체크박스 위젯 (크기 조절 가능)
class FitCheckBox extends StatelessWidget {
  final bool state;
  final Function1<bool, void>? onCheck;
  final Color? activeColor;
  final Color? checkColor;
  final Color? hoverColor;
  final Color? focusColor;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final MaterialTapTargetSize materialTapTargetSize;
  final VisualDensity? visualDensity;
  final bool autofocus;
  final double size;

  const FitCheckBox({
    super.key,
    required this.state,
    this.onCheck,
    this.activeColor,
    this.checkColor,
    this.hoverColor,
    this.focusColor,
    this.side,
    this.shape,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.visualDensity,
    this.autofocus = false,
    this.size = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    const baseSize = 16.0;
    final scaleFactor = size / baseSize;

    return Transform.scale(
      scale: scaleFactor,
      child: SizedBox(
        width: size,
        height: size,
        child: Checkbox(
          value: state,
          onChanged: onCheck != null ? (value) => onCheck!(value ?? false) : null,
          activeColor: activeColor,
          checkColor: checkColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          side: side,
          shape: shape,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity ?? const VisualDensity(horizontal: -4, vertical: -4),
          autofocus: autofocus,
        ),
      ),
    );
  }
}
