import 'dart:math' as math;

import 'package:chip_assets/gen/assets.gen.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom Sheet 유틸리티
///
/// 세 가지 타입의 바텀시트를 제공합니다:
/// - [show]: 기본 바텀시트 (고정 높이, 키보드 반응형)
/// - [showFull]: 전체 화면 바텀시트 (스크롤 가능)
/// - [showDraggable]: 드래그 가능한 바텀시트 (높이 조절 가능)
class FitBottomSheet {
  FitBottomSheet._();

  // 상수 정의
  static const _kBorderRadius = 32.0;
  static const _kTopBarHeight = 8.0;
  static const _kTopBarSpacing = 20.0;
  static const _kDragHandleWidth = 40.0;
  static const _kDragHandleHeight = 4.0;
  static const _kCloseButtonPadding = EdgeInsets.only(top: 25, right: 20);
  static const _kCloseButtonSize = 28.0;

  /// 기본 Bottom Sheet 표시
  ///
  /// 키보드가 올라오면 자동으로 위로 밀려납니다.
  /// SafeArea를 자동으로 처리합니다.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext bottomSheetContext) content,
    FitBottomSheetConfig config = const FitBottomSheetConfig(),
    VoidCallback? onClosed,
  }) async {
    final result = await _showBase<T>(
      context: context,
      config: config,
      builder: (ctx) => _BasicSheetContent(config: config, content: content),
    );
    onClosed?.call();
    return result;
  }

  /// 전체 화면 Bottom Sheet 표시
  ///
  /// 스크롤 가능한 콘텐츠와 상단 고정 위젯을 지원합니다.
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
    final result = await _showBase<T>(
      context: context,
      config: config,
      builder: (ctx) {
        final adjustedFactor = _calculateHeightFactor(ctx, config.heightFactor);
        return _DraggableSheetWrapper(
          config: config.copyWith(
            heightFactor: adjustedFactor,
            maxHeightFactor: adjustedFactor,
          ),
          scrollContent: scrollContent,
          topContent: topContent,
        );
      },
    );
    onClosed?.call();
    return result;
  }

  /// 드래그 가능한 Bottom Sheet 표시
  ///
  /// 사용자가 드래그하여 높이를 조절할 수 있습니다.
  /// [snapSizes]로 스냅 포인트를 설정할 수 있습니다.
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
    final result = await _showBase<T>(
      context: context,
      config: config,
      builder: (ctx) {
        final adjustedFactor = _calculateHeightFactor(ctx, config.heightFactor);
        return _DraggableSheetWrapper(
          config: config.copyWith(heightFactor: adjustedFactor),
          scrollContent: scrollContent,
          topContent: topContent,
          snapSizes: snapSizes,
        );
      },
    );
    onClosed?.call();
    return result;
  }

  /// 공통 모달 바텀시트 표시
  static Future<T?> _showBase<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required FitBottomSheetConfig config,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: config.isDismissible,
      enableDrag: config.isDismissible,
      builder: (ctx) => PopScope(
        canPop: config.dismissOnBackKeyPress,
        child: builder(ctx),
      ),
    );
  }

  /// 화면 높이 비율 계산 (상태바 높이 보정)
  static double _calculateHeightFactor(BuildContext context, double heightFactor) {
    final mediaQuery = MediaQuery.of(context);
    final statusBarRatio = mediaQuery.padding.top / mediaQuery.size.height;
    return (heightFactor - statusBarRatio).clamp(0.1, 1.0);
  }

  /// 바텀시트 데코레이션 생성
  static BoxDecoration buildDecoration(BuildContext context, Color? backgroundColor) {
    return BoxDecoration(
      color: backgroundColor ?? context.fitColors.backgroundElevated,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_kBorderRadius.r),
        topRight: Radius.circular(_kBorderRadius.r),
      ),
    );
  }

  /// 상단 드래그 바 위젯
  static Widget buildTopBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: _kTopBarHeight),
        Center(
          child: Container(
            width: _kDragHandleWidth,
            height: _kDragHandleHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: context.fitColors.fillEmphasize,
            ),
          ),
        ),
        SizedBox(height: _kTopBarSpacing),
      ],
    );
  }

  /// 닫기 버튼 위젯
  static Widget buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: _kCloseButtonPadding,
        child: Bounceable(
          onTap: () => Navigator.pop(context),
          child: ChipAssets.icons.icXcircleFill24.svg(
            width: _kCloseButtonSize,
            height: _kCloseButtonSize,
          ),
        ),
      ),
    );
  }
}

/// 기본 바텀시트 콘텐츠 (키보드 반응형)
class _BasicSheetContent extends StatelessWidget {
  const _BasicSheetContent({
    required this.config,
    required this.content,
  });

  final FitBottomSheetConfig config;
  final Widget Function(BuildContext) content;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // 키보드 높이와 SafeArea 중 큰 값 사용 (SafeArea 침범 방지)
    final bottomInset = math.max(
      mediaQuery.viewInsets.bottom,
      mediaQuery.padding.bottom,
    );

    return Container(
      decoration: FitBottomSheet.buildDecoration(context, config.backgroundColor),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (config.isShowTopBar) FitBottomSheet.buildTopBar(context),
          if (config.isShowCloseButton) FitBottomSheet.buildCloseButton(context),
          content(context),
        ],
      ),
    );
  }
}

/// 드래그 가능한 바텀시트 래퍼
class _DraggableSheetWrapper extends StatelessWidget {
  const _DraggableSheetWrapper({
    required this.config,
    required this.scrollContent,
    this.topContent,
    this.snapSizes,
  });

  final FitBottomSheetConfig config;
  final Widget Function(BuildContext) scrollContent;
  final Widget Function(BuildContext)? topContent;
  final List<double>? snapSizes;

  @override
  Widget build(BuildContext context) {
    // min <= initial <= max 관계 보장
    final minSize = config.minHeightFactor.clamp(0.0, 1.0);
    final maxSize = config.maxHeightFactor.clamp(minSize, 1.0);
    final initialSize = config.heightFactor.clamp(minSize, maxSize);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialSize,
      maxChildSize: maxSize,
      minChildSize: minSize,
      snap: snapSizes != null,
      snapSizes: snapSizes,
      builder: (context, scrollController) => _FullSheetContent(
        config: config,
        scrollController: scrollController,
        scrollContent: scrollContent,
        topContent: topContent,
      ),
    );
  }
}

/// 전체 화면 바텀시트 콘텐츠
class _FullSheetContent extends StatelessWidget {
  const _FullSheetContent({
    required this.config,
    required this.scrollController,
    required this.scrollContent,
    this.topContent,
  });

  final FitBottomSheetConfig config;
  final ScrollController scrollController;
  final Widget Function(BuildContext) scrollContent;
  final Widget Function(BuildContext)? topContent;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // 키보드 높이와 SafeArea 중 큰 값 사용 (SafeArea 침범 방지)
    final bottomInset = math.max(
      mediaQuery.viewInsets.bottom,
      mediaQuery.padding.bottom,
    );

    return Container(
      decoration: FitBottomSheet.buildDecoration(context, config.backgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (config.isShowTopBar) FitBottomSheet.buildTopBar(context),
          if (config.isShowCloseButton) FitBottomSheet.buildCloseButton(context),
          if (topContent != null) topContent!(context),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  scrollContent(context),
                  SizedBox(height: bottomInset),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom Sheet 설정 옵션
class FitBottomSheetConfig {
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
  int get hashCode => Object.hash(
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
