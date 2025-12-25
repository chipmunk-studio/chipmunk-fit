import 'package:chip_assets/gen/assets.gen.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom Sheet 설정 옵션
class FitBottomSheetConfig {
  /// 닫기 버튼 표시 여부
  final bool isShowCloseButton;

  /// 외부 터치로 닫기 가능 여부
  final bool isDismissible;

  /// 상단 드래그 바 표시 여부
  final bool isShowTopBar;

  /// 뒤로가기 버튼으로 닫기 가능 여부
  final bool dismissOnBackKeyPress;

  /// 화면 높이 비율 (0.0 ~ 1.0)
  final double heightFactor;

  /// 최소 높이 비율 (드래그 가능 시트 전용)
  final double minHeightFactor;

  /// 최대 높이 비율 (드래그 가능 시트 전용)
  final double maxHeightFactor;

  /// 배경색
  final Color? backgroundColor;

  const FitBottomSheetConfig({
    this.isShowCloseButton = false,
    this.isDismissible = true,
    this.isShowTopBar = true,
    this.dismissOnBackKeyPress = true,
    this.heightFactor = 0.97,
    this.minHeightFactor = 0.2,
    this.maxHeightFactor = 0.97,
    this.backgroundColor,
  });

  /// 설정 복사
  FitBottomSheetConfig copyWith({
    bool? isShowCloseButton,
    bool? isDismissible,
    bool? isShowTopBar,
    bool? dismissOnBackKeyPress,
    double? heightFactor,
    double? minHeightFactor,
    double? maxHeightFactor,
    Color? backgroundColor,
  }) {
    return FitBottomSheetConfig(
      isShowCloseButton: isShowCloseButton ?? this.isShowCloseButton,
      isDismissible: isDismissible ?? this.isDismissible,
      isShowTopBar: isShowTopBar ?? this.isShowTopBar,
      dismissOnBackKeyPress: dismissOnBackKeyPress ?? this.dismissOnBackKeyPress,
      heightFactor: heightFactor ?? this.heightFactor,
      minHeightFactor: minHeightFactor ?? this.minHeightFactor,
      maxHeightFactor: maxHeightFactor ?? this.maxHeightFactor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FitBottomSheetConfig &&
        other.isShowCloseButton == isShowCloseButton &&
        other.isDismissible == isDismissible &&
        other.isShowTopBar == isShowTopBar &&
        other.dismissOnBackKeyPress == dismissOnBackKeyPress &&
        other.heightFactor == heightFactor &&
        other.minHeightFactor == minHeightFactor &&
        other.maxHeightFactor == maxHeightFactor &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      isShowCloseButton,
      isDismissible,
      isShowTopBar,
      dismissOnBackKeyPress,
      heightFactor,
      minHeightFactor,
      maxHeightFactor,
      backgroundColor,
    );
  }

  @override
  String toString() {
    return 'FitBottomSheetConfig(isShowCloseButton: $isShowCloseButton, isDismissible: $isDismissible, '
        'isShowTopBar: $isShowTopBar, dismissOnBackKeyPress: $dismissOnBackKeyPress, '
        'heightFactor: $heightFactor, minHeightFactor: $minHeightFactor, maxHeightFactor: $maxHeightFactor, '
        'backgroundColor: $backgroundColor)';
  }
}

/// Bottom Sheet 유틸리티
class FitBottomSheet {
  FitBottomSheet._();

  /// 기본 Bottom Sheet 표시
  ///
  /// [content] - 표시할 내용
  /// [config] - 설정 옵션
  /// [onClosed] - 닫힐 때 콜백
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext bottomSheetContext) content,
    FitBottomSheetConfig config = const FitBottomSheetConfig(),
    VoidCallback? onClosed,
  }) async {
    final result = await _showBaseModalBottomSheet<T>(
      context: context,
      config: config,
      builder: (context) => _buildBottomSheetContent(
        context,
        content: content,
        config: config,
      ),
    );

    onClosed?.call();
    return result;
  }

  /// 전체 화면 Bottom Sheet 표시
  ///
  /// [scrollContent] - 스크롤 가능한 내용
  /// [topContent] - 상단 고정 위젯
  /// [config] - 설정 옵션
  /// [onClosed] - 닫힐 때 콜백
  static Future<T?> showFull<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    Widget Function(BuildContext)? topContent,
    FitBottomSheetConfig config = const FitBottomSheetConfig(
      isShowCloseButton: true,
      isShowTopBar: false,
      heightFactor: 0.97,
    ),
    VoidCallback? onClosed,
  }) async {
    final result = await _showBaseModalBottomSheet<T>(
      context: context,
      config: config,
      builder: (context) {
        final adjustedHeightFactor = _calculateHeightFactor(context, config.heightFactor);
        return _buildDraggableSheet(
          context,
          scrollContent: scrollContent,
          topContent: topContent,
          config: config.copyWith(
            heightFactor: adjustedHeightFactor,
            maxHeightFactor: adjustedHeightFactor,
          ),
          expand: false,
        );
      },
    );

    onClosed?.call();
    return result;
  }

  /// 드래그 가능한 Bottom Sheet 표시
  ///
  /// [scrollContent] - 스크롤 가능한 내용
  /// [topContent] - 상단 고정 위젯
  /// [config] - 설정 옵션
  /// [onClosed] - 닫힐 때 콜백
  /// [snapSizes] - 스냅 포인트 (비율 리스트)
  static Future<T?> showDraggable<T>(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    Widget Function(BuildContext)? topContent,
    FitBottomSheetConfig config = const FitBottomSheetConfig(
      isShowCloseButton: true,
      isShowTopBar: true,
      heightFactor: 0.5,
      minHeightFactor: 0.2,
      maxHeightFactor: 0.97,
    ),
    VoidCallback? onClosed,
    List<double>? snapSizes,
  }) async {
    final result = await _showBaseModalBottomSheet<T>(
      context: context,
      config: config,
      builder: (context) {
        final adjustedInitialFactor = _calculateHeightFactor(context, config.heightFactor);
        return _buildDraggableSheet(
          context,
          scrollContent: scrollContent,
          topContent: topContent,
          config: config.copyWith(heightFactor: adjustedInitialFactor),
          expand: false,
          snapSizes: snapSizes,
        );
      },
    );

    onClosed?.call();
    return result;
  }

  /// Modal Bottom Sheet 기본 설정
  static Future<T?> _showBaseModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required FitBottomSheetConfig config,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: config.isDismissible,
      enableDrag: config.isDismissible,
      builder: (context) => PopScope(
        canPop: config.dismissOnBackKeyPress,
        child: builder(context),
      ),
    );
  }

  /// 기본 Bottom Sheet 내용 생성
  static Widget _buildBottomSheetContent(
    BuildContext context, {
    required Widget Function(BuildContext) content,
    required FitBottomSheetConfig config,
  }) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: config.backgroundColor ?? context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (config.isShowTopBar) _buildTopBar(context),
          if (config.isShowCloseButton) _buildCloseButton(context),
          content(context),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }

  /// DraggableScrollableSheet 생성
  static Widget _buildDraggableSheet(
    BuildContext context, {
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext)? topContent,
    required FitBottomSheetConfig config,
    required bool expand,
    List<double>? snapSizes,
  }) {
    // min <= initial <= max 관계 보장
    final minSize = config.minHeightFactor.clamp(0.0, 1.0);
    final maxSize = config.maxHeightFactor.clamp(minSize, 1.0);
    final initialSize = config.heightFactor.clamp(minSize, maxSize);

    return DraggableScrollableSheet(
      expand: expand,
      initialChildSize: initialSize,
      maxChildSize: maxSize,
      minChildSize: minSize,
      snap: snapSizes != null,
      snapSizes: snapSizes,
      builder: (context, scrollController) => _buildFullSheetContent(
        context,
        scrollController: scrollController,
        scrollContent: scrollContent,
        topContent: topContent,
        config: config,
      ),
    );
  }

  /// 전체 화면 Sheet 내용 생성
  static Widget _buildFullSheetContent(
    BuildContext context, {
    required ScrollController scrollController,
    required Widget Function(BuildContext) scrollContent,
    required Widget Function(BuildContext)? topContent,
    required FitBottomSheetConfig config,
  }) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: config.backgroundColor ?? context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (config.isShowTopBar) _buildTopBar(context),
          if (config.isShowCloseButton) _buildCloseButton(context),
          if (topContent != null) topContent(context),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  scrollContent(context),
                  SizedBox(height: bottomPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 상단 드래그 바 생성
  static Widget _buildTopBar(BuildContext context) {
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
        const SizedBox(height: 36),
      ],
    );
  }

  /// 닫기 버튼 생성
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

  /// 화면 높이 비율 계산 (상태바 높이 보정)
  static double _calculateHeightFactor(BuildContext context, double heightFactor) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    return (heightFactor - (statusBarHeight / screenHeight)).clamp(0.1, 1.0);
  }
}
