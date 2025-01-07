import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

buildFitToastContent(
  BuildContext context, {
  required String content,
  SvgPicture? icon,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: context.fitColors.grey0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? Assets.icons.icCheckCircleFill24.svg(),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              content,
              style: context.body3().copyWith(color: context.fitColors.grey900),
            ),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
