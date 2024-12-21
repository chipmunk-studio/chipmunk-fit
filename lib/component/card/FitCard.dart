import 'package:chipfit/foundation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Widget child;

  const FitCard({
    super.key,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.margin,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 0,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      ),
      color: backgroundColor ?? context.fitColors.grey800,
      shadowColor: shadowColor ?? Colors.transparent,
      child: Padding(
        padding: padding ?? EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
