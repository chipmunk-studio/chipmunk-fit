import 'package:assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundation/colors.dart';

class FitBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext bottomSheetContext) content,
    bool isShowCloseButton = false,
    bool isDismissible = true,
    bool isShowTopBar = true,
  }) async {
    return await _showBaseModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      builder: (context) => _buildBottomSheetContent(
        context,
        content: content,
        isShowCloseButton: isShowCloseButton,
        isShowTopBar: isShowTopBar,
      ),
    );
  }

  static Future<T?> showFull<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
    double heightFactor = 0.97,
  }) async {
    return await _showBaseModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        final adjustedHeightFactor = _calculateHeightFactor(context, heightFactor);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: adjustedHeightFactor,
          maxChildSize: adjustedHeightFactor,
          minChildSize: 0.1,
          builder: (context, scrollController) => _buildFullSheetContent(
            context,
            scrollController: scrollController,
            scrollContent: scrollContent,
            topContent: topContent,
            isShowCloseButton: isShowCloseButton,
            isShowTopBar: isShowTopBar,
          ),
        );
      },
    );
  }

  static Future<T?> showDraggable<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
    double initialHeightFactor = 0.5,
    double maxHeightFactor = 0.97,
    double minHeightFactor = 0.2,
  }) async {
    return await _showBaseModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        final initialFactor = _calculateHeightFactor(context, initialHeightFactor);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: initialFactor,
          maxChildSize: maxHeightFactor,
          minChildSize: minHeightFactor,
          builder: (context, scrollController) => _buildFullSheetContent(
            context,
            scrollController: scrollController,
            scrollContent: scrollContent,
            topContent: topContent,
            isShowCloseButton: isShowCloseButton,
            isShowTopBar: isShowTopBar,
          ),
        );
      },
    );
  }

  /// 공통적인 Modal Bottom Sheet 설정
  static Future<T?> _showBaseModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required bool isDismissible,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.fitColors.backgroundElevated,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      builder: builder,
    );
  }

  /// 기본 BottomSheet Content 생성
  static Widget _buildBottomSheetContent(
    BuildContext context, {
    required Widget Function(BuildContext) content,
    required bool isShowCloseButton,
    required bool isShowTopBar,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isShowTopBar) _buildTopBar(context, isShowCloseButton),
            if (isShowCloseButton) _buildCloseButton(context),
            content(context),
          ],
        ),
      ),
    );
  }

  /// 풀스크린 및 드래그 가능한 Sheet Content 생성
  static Widget _buildFullSheetContent(
    BuildContext context, {
    required ScrollController scrollController,
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    required bool isShowCloseButton,
    required bool isShowTopBar,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isShowTopBar) _buildTopBar(context, isShowCloseButton),
        if (isShowCloseButton) _buildCloseButton(context),
        topContent(context),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: scrollContent(context),
          ),
        ),
      ],
    );
  }

  /// Top Bar 생성
  static Widget _buildTopBar(BuildContext context, bool isShowCloseButton) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const Spacer(),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: context.fitColors.fillEmphasize,
              ),
            ),
            const Spacer(),
          ],
        ),
        if (!isShowCloseButton) const SizedBox(height: 36),
      ],
    );
  }

  /// Close 버튼 생성
  static Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 25, right: 20),
        child: Bounceable(
          onTap: () => Navigator.pop(context),
          child: ChipAssets.icons.icXcircleFill24.svg(width: 28, height: 28),
        ),
      ),
    );
  }

  /// Height Factor 계산
  static double _calculateHeightFactor(BuildContext context, double heightFactor) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    return (heightFactor - (statusBarHeight / screenHeight)).clamp(0.1, 1.0);
  }
}
