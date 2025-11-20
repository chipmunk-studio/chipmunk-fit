import 'package:chip_assets/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chip_foundation/colors.dart';

/// 공통 Bottom Sheet 유틸리티
class FitBottomSheet {
  /// 기본 Bottom Sheet 표시
  ///
  /// [content] - 표시할 내용 위젯 빌더
  /// [isShowCloseButton] - 닫기 버튼 표시 여부
  /// [isDismissible] - 외부 터치로 닫기 가능 여부
  /// [isShowTopBar] - 상단 드래그 바 표시 여부
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

  /// 전체 화면 Bottom Sheet 표시
  ///
  /// [scrollContent] - 스크롤 가능한 내용 위젯 빌더
  /// [topContent] - 상단 고정 위젯 빌더
  /// [heightFactor] - 화면 비율 (기본값: 0.97)
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
        return _buildDraggableSheet(
          context,
          scrollContent: scrollContent,
          topContent: topContent,
          isShowCloseButton: isShowCloseButton,
          isShowTopBar: isShowTopBar,
          initialChildSize: adjustedHeightFactor,
          maxChildSize: adjustedHeightFactor,
          minChildSize: 0.1,
        );
      },
    );
  }

  /// 드래그 가능한 Bottom Sheet 표시
  ///
  /// [scrollContent] - 스크롤 가능한 내용 위젯 빌더
  /// [topContent] - 상단 고정 위젯 빌더
  /// [initialHeightFactor] - 초기 높이 비율 (기본값: 0.5)
  /// [maxHeightFactor] - 최대 높이 비율 (기본값: 0.97)
  /// [minHeightFactor] - 최소 높이 비율 (기본값: 0.2)
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
        final adjustedInitialFactor = _calculateHeightFactor(context, initialHeightFactor);
        return _buildDraggableSheet(
          context,
          scrollContent: scrollContent,
          topContent: topContent,
          isShowCloseButton: isShowCloseButton,
          isShowTopBar: isShowTopBar,
          initialChildSize: adjustedInitialFactor,
          maxChildSize: maxHeightFactor,
          minChildSize: minHeightFactor,
        );
      },
    );
  }

  /// 공통 Modal Bottom Sheet 설정
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

  /// DraggableScrollableSheet 생성
  static Widget _buildDraggableSheet(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    required bool isShowCloseButton,
    required bool isShowTopBar,
    required double initialChildSize,
    required double maxChildSize,
    required double minChildSize,
  }) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      builder: (context, scrollController) => _buildFullSheetContent(
        context,
        scrollController: scrollController,
        scrollContent: scrollContent,
        topContent: topContent,
        isShowCloseButton: isShowCloseButton,
        isShowTopBar: isShowTopBar,
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

  /// Top Bar 생성 (드래그 인디케이터)
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

  /// Height Factor 계산 (상태바 높이 보정)
  ///
  /// 상태바 높이를 제외한 실제 화면 비율 계산
  static double _calculateHeightFactor(BuildContext context, double heightFactor) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    return (heightFactor - (statusBarHeight / screenHeight)).clamp(0.1, 1.0);
  }
}
