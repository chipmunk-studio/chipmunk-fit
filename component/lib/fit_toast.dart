import 'package:chip_assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';

/// Toast 콘텐츠 빌더
Widget buildFitToastContent(
  BuildContext context, {
  required String content,
  SvgPicture? icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.r),
      color: context.fitColors.inverseBackground,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ?? ChipAssets.icons.icCheckCircleFill24.svg(),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            content,
            style: context.body3().copyWith(
                  color: context.fitColors.inverseText,
                ),
          ),
        ),
        const SizedBox(width: 12.0),
      ],
    ),
  );
}
