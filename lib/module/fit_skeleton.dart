import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'skeletons/components/stylings.dart';
import 'skeletons/components/widgets.dart';

class FitSkeleton extends StatelessWidget {
  const FitSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 68,
              randomLength: true,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          const SizedBox(height: 60),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              randomLength: true,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          const SizedBox(height: 18),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 100,
              randomLength: true,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          const SizedBox(height: 18),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 60,
              randomLength: true,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ],
      ),
    );
  }
}
