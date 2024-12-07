import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FitBottomSheet {
  /// 기본 바텀시트
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext bottomSheetContext) content,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
  }) async {
    return await _showBottomSheet(
      context,
      content: content,
      isShowCloseButton: isShowCloseButton,
      isDismissible: isDismissible,
      isShowTopBar: isShowTopBar,
    );
  }

  /// 풀스크린 바텀시트
  static Future<T?> showFull<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
    double heightFactor = 1.0,
  }) async {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    final adjustedHeightFactor = (heightFactor - (statusBarHeight / screenHeight)).clamp(0.1, 1.0);

    return await _showBottomSheet(
      context,
      topContent: topContent,
      scrollContent: scrollContent,
      isShowCloseButton: isShowCloseButton,
      isDismissible: isDismissible,
      isShowTopBar: isShowTopBar,
      heightFactor: adjustedHeightFactor,
    );
  }

  /// 드래그 가능한 바텀시트
  static Future<T?> showDraggable<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext) topContent,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
    double initialHeightFactor = 0.5,
    double maxHeightFactor = 1.0,
    double minHeightFactor = 0.2,
  }) async {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.fitColors.grey800,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: (initialHeightFactor - (statusBarHeight / screenHeight)).clamp(0.1, 1.0),
            maxChildSize: maxHeightFactor,
            minChildSize: minHeightFactor,
            builder: (context, scrollController) {
              return _buildBottomSheetContent(
                context,
                topContent: topContent,
                scrollContent: scrollContent,
                isShowCloseButton: isShowCloseButton,
                isShowTopBar: isShowTopBar,
                scrollController: scrollController,
              );
            },
          ),
        ),
      ),
    );
  }

  /// 공통 바텀시트 생성 함수
  static Future<T?> _showBottomSheet<T>(
    BuildContext context, {
    Widget Function(BuildContext)? topContent,
    Widget Function(BuildContext)? scrollContent,
    Widget Function(BuildContext)? content,
    bool isShowCloseButton = true,
    bool isDismissible = true,
    bool isShowTopBar = false,
    double heightFactor = 1.0,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.fitColors.grey800,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      builder: (context) {
        if (content != null) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: content(context),
            ),
          );
        }

        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: heightFactor,
            maxChildSize: heightFactor,
            minChildSize: 0.1,
            builder: (context, scrollController) {
              return _buildBottomSheetContent(
                context,
                topContent: topContent,
                scrollContent: scrollContent,
                isShowCloseButton: isShowCloseButton,
                isShowTopBar: isShowTopBar,
                scrollController: scrollController,
              );
            },
          ),
        );
      },
    );
  }

  /// 공통 바텀시트 내용 구성 함수
  static Widget _buildBottomSheetContent(
    BuildContext context, {
    Widget Function(BuildContext)? topContent,
    Widget Function(BuildContext)? scrollContent,
    bool isShowCloseButton = true,
    bool isShowTopBar = false,
    ScrollController? scrollController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isShowTopBar)
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: context.fitColors.grey600,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: isShowCloseButton ? 8 : 24),
            ],
          ),
        if (isShowCloseButton)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0, top: isShowTopBar ? 0 : 16),
              child: IconButton(
                icon: Assets.icons.icXcircleFill24.svg(width: 28, height: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        if (topContent != null) topContent(context),
        if (scrollContent != null)
          Flexible(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: scrollContent(context),
              ),
            ),
          ),
      ],
    );
  }
}
