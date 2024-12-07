import 'package:chipfit/foundation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitCard extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const FitCard({
    super.key,
    this.leading,
    this.trailing,
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
      elevation: elevation ?? 6,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      ),
      color: backgroundColor ?? context.fitColors.grey800,
      shadowColor: shadowColor ?? Colors.transparent,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null || trailing != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading ?? SizedBox.shrink(),
                  trailing ?? SizedBox.shrink(),
                ],
              ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
