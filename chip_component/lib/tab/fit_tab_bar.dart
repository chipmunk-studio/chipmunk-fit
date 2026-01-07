import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:flutter/material.dart';

/// 가로 스크롤 탭 바 위젯
///
/// FitTabBar는 탭 아이템들을 가로로 나열하고
/// 선택된 탭 하단에 애니메이션 인디케이터를 표시합니다.
///
/// 사용 예시:
/// ```dart
/// FitTabBar<FaqType>(
///   items: FaqType.values,
///   selectedItem: selectedTab,
///   labelBuilder: (item) => item.displayName,
///   onTabChanged: (item) => setState(() => selectedTab = item),
/// )
/// ```
class FitTabBar<T> extends StatefulWidget {
  /// 탭 아이템 목록
  final List<T> items;

  /// 선택된 아이템
  final T selectedItem;

  /// 아이템에서 라벨 텍스트를 추출하는 함수
  final String Function(T item) labelBuilder;

  /// 탭 변경 콜백
  final ValueChanged<T> onTabChanged;

  /// 언더라인 두께
  final double indicatorHeight;

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

  const FitTabBar({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.labelBuilder,
    required this.onTabChanged,
    this.indicatorHeight = 2.0,
    this.dividerHeight = 1.0,
    this.spacing = 12.0,
    this.horizontalPadding = 20.0,
    this.tabPadding,
    this.showDivider = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<FitTabBar<T>> createState() => _FitTabBarState<T>();
}

class _FitTabBarState<T> extends State<FitTabBar<T>> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _tabKeys = {};
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // 각 탭에 대한 GlobalKey 생성
    for (int i = 0; i < widget.items.length; i++) {
      _tabKeys[i] = GlobalKey();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition();
    });
  }

  @override
  void didUpdateWidget(FitTabBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateIndicatorPosition();
      });
    }
  }

  void _updateIndicatorPosition() {
    final selectedIndex = widget.items.indexOf(widget.selectedItem);
    if (selectedIndex < 0) return;

    final key = _tabKeys[selectedIndex];
    if (key?.currentContext == null) return;

    final RenderBox? renderBox =
        key!.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final RenderBox? parentBox = context.findRenderObject() as RenderBox?;
    if (parentBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero, ancestor: parentBox);

    setState(() {
      _indicatorLeft = position.dx;
      _indicatorWidth = renderBox.size.width;
      _initialized = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 탭 목록 + 인디케이터
        SizedBox(
          height: 50,
          child: Stack(
            children: [
              // 탭 목록
              ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
                itemCount: widget.items.length,
                separatorBuilder: (context, index) =>
                    SizedBox(width: widget.spacing),
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final isSelected = item == widget.selectedItem;

                  return _FitTabItem(
                    key: _tabKeys[index],
                    text: widget.labelBuilder(item),
                    isSelected: isSelected,
                    onTap: () => widget.onTabChanged(item),
                    padding: widget.tabPadding ??
                        const EdgeInsets.symmetric(vertical: 15),
                  );
                },
              ),
              // 애니메이션 인디케이터
              if (_initialized)
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  left: _indicatorLeft,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    curve: Curves.easeInOut,
                    width: _indicatorWidth,
                    height: widget.indicatorHeight,
                    decoration: BoxDecoration(
                      color: colors.textPrimary,
                      borderRadius:
                          BorderRadius.circular(widget.indicatorHeight / 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 하단 구분선
        if (widget.showDivider)
          Container(
            height: widget.dividerHeight,
            color: colors.dividerPrimary,
          ),
      ],
    );
  }
}

/// 개별 탭 아이템 위젯 (내부용)
class _FitTabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const _FitTabItem({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding,
        child: Text(
          text,
          style: context.subtitle5().copyWith(
                color: isSelected ? colors.textPrimary : colors.textSecondary,
              ),
        ),
      ),
    );
  }
}
