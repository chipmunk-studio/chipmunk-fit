import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FitCheckBox extends StatelessWidget {
  final bool state;
  final Function1<bool, void>? onCheck;

  // 스타일 관련 속성들
  final Color? color;
  final Color? checkColor;
  final Color? activeColor;
  final Color? hoverColor;
  final Color? focusColor;
  final Color? overlayColor;
  final BorderSide? side;
  final OutlinedBorder? shape;

  // 동작 관련 속성들
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final bool autofocus;

  // 크기 설정
  final double width;
  final double height;

  const FitCheckBox({
    super.key,
    required this.state,
    this.onCheck,
    this.color,
    this.checkColor,
    this.activeColor,
    this.hoverColor,
    this.focusColor,
    this.overlayColor,
    this.side,
    this.shape,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.visualDensity,
    this.autofocus = false,
    this.width = 16.0, // 기본 너비
    this.height = 16.0, // 기본 높이
  });

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = width / 16.0; // 기본 크기(16.0)에 비례한 스케일링
    return Transform.scale(
      scale: scaleFactor,
      child: SizedBox(
        width: width,
        height: height,
        child: Checkbox(
          value: state,
          onChanged: onCheck != null ? (value) => onCheck!(value!) : null,
          activeColor: activeColor,
          checkColor: checkColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          side: side,
          shape: shape,
          materialTapTargetSize: materialTapTargetSize,
          visualDensity: visualDensity ?? VisualDensity(horizontal: -4, vertical: -4),
          autofocus: autofocus,
          overlayColor: overlayColor != null ? WidgetStateProperty.all(overlayColor) : null,
        ),
      ),
    );
  }
}
