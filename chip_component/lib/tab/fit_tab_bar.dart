import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:flutter/material.dart';

/// 가로 스크롤 탭 바 위젯
///
/// FitTabBar는 탭 아이템들을 가로로 나열하고
/// 선택된 탭 하단에 애니메이션 인디케이터를 표시합니다.
///
/// ## 기본 사용 (labelBuilder)
/// ```dart
/// FitTabBar<FaqType>(
///   items: FaqType.values,
///   selectedItem: selectedTab,
///   labelBuilder: (item) => item.displayName,
///   onTabChanged: (item) => setState(() => selectedTab = item),
/// )
/// ```
///
/// ## 커스텀 위젯 사용 (childBuilder)
/// ```dart
/// FitTabBar<Category>(
///   items: categories,
///   selectedItem: selectedCategory,
///   childBuilder: (item, isSelected) => Row(
///     children: [
///       Text(item.name),
///       SizedBox(width: 4),
///       Badge(count: item.count),
///     ],
///   ),
///   onTabChanged: onCategoryChanged,
/// )
/// ```
class FitTabBar<T> extends StatefulWidget {
  const FitTabBar({
    super.key,
    required this.items,
    required this.selectedItem,
    this.labelBuilder,
    this.childBuilder,
    required this.onTabChanged,
    this.height = 52.0,
    this.indicatorHeight = 2.0,
    this.indicatorHorizontalPadding = 4.0,
    this.indicatorColor,
    this.dividerHeight = 1.0,
    this.spacing = 24.0,
    this.horizontalPadding = 20.0,
    this.tabPadding,
    this.showDivider = true,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : assert(
          labelBuilder != null || childBuilder != null,
          'Either labelBuilder or childBuilder must be provided',
        );

  /// 탭 아이템 목록
  final List<T> items;

  /// 선택된 아이템
  final T selectedItem;

  /// 아이템에서 라벨 텍스트를 추출하는 함수 (childBuilder와 함께 사용 불가)
  final String Function(T item)? labelBuilder;

  /// 커스텀 위젯 빌더 (labelBuilder와 함께 사용 불가)
  final Widget Function(T item, bool isSelected)? childBuilder;

  /// 탭 변경 콜백
  final ValueChanged<T> onTabChanged;

  /// 탭 바 높이
  final double height;

  /// 언더라인 두께
  final double indicatorHeight;

  /// 인디케이터 좌우 패딩 (내용물보다 넓게)
  final double indicatorHorizontalPadding;

  /// 인디케이터 색상 (null이면 colors.main 사용)
  final Color? indicatorColor;

  /// 하단 구분선 두께
  final double dividerHeight;

  /// 탭 간격
  final double spacing;

  /// 시작/끝 여백
  final double horizontalPadding;

  /// 탭 패딩
  final EdgeInsets? tabPadding;

  /// 구분선 표시 여부
  final bool showDivider;

  /// 애니메이션 지속 시간
  final Duration animationDuration;

  @override
  State<FitTabBar<T>> createState() => _FitTabBarState<T>();
}

class _FitTabBarState<T> extends State<FitTabBar<T>> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _stackKey = GlobalKey();
  final Map<int, GlobalKey> _tabKeys = {};
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.items.length; i++) {
      _tabKeys[i] = GlobalKey();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicatorPosition());
  }

  @override
  void didUpdateWidget(FitTabBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicatorPosition());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateIndicatorPosition() {
    final selectedIndex = widget.items.indexOf(widget.selectedItem);
    if (selectedIndex < 0) return;

    final tabContext = _tabKeys[selectedIndex]?.currentContext;
    final stackContext = _stackKey.currentContext;
    if (tabContext == null || stackContext == null) return;

    final renderBox = tabContext.findRenderObject() as RenderBox?;
    final stackBox = stackContext.findRenderObject() as RenderBox?;
    if (renderBox == null || stackBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero, ancestor: stackBox);
    final textWidth = renderBox.size.width;
    final textCenterX = position.dx + textWidth / 2;

    setState(() {
      _indicatorWidth = textWidth + (widget.indicatorHorizontalPadding * 2);
      _indicatorLeft = textCenterX - _indicatorWidth / 2;
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;
    final indicatorColor = widget.indicatorColor ?? colors.main;
    final tabPadding = widget.tabPadding ?? const EdgeInsets.only(top: 16, bottom: 6);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 탭 목록 + 인디케이터
        SizedBox(
          height: widget.height,
          child: Stack(
            key: _stackKey,
            children: [
              // 탭 목록
              ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => SizedBox(width: widget.spacing),
                itemBuilder: (context, index) => _buildTabItem(context, index, colors, tabPadding),
              ),
              // 애니메이션 인디케이터
              if (_initialized)
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeOutCubic,
                  left: _indicatorLeft,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    curve: Curves.easeOutCubic,
                    width: _indicatorWidth,
                    height: widget.indicatorHeight,
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: BorderRadius.circular(widget.indicatorHeight / 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 하단 구분선
        if (widget.showDivider)
          ColoredBox(
            color: colors.dividerPrimary,
            child: SizedBox(height: widget.dividerHeight, width: double.infinity),
          ),
      ],
    );
  }

  Widget _buildTabItem(BuildContext context, int index, FitColors colors, EdgeInsets tabPadding) {
    final item = widget.items[index];
    final isSelected = item == widget.selectedItem;

    return GestureDetector(
      onTap: () => widget.onTabChanged(item),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: tabPadding,
        child: KeyedSubtree(
          key: _tabKeys[index],
          child: widget.childBuilder != null
              ? widget.childBuilder!(item, isSelected)
              : Text(
                  widget.labelBuilder!(item),
                  style: context.subtitle4().copyWith(
                        color: isSelected ? colors.textPrimary : colors.textTertiary,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
        ),
      ),
    );
  }
}
