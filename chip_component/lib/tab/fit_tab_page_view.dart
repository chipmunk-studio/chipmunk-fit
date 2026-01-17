import 'package:chip_component/tab/fit_tab_bar.dart';
import 'package:flutter/material.dart';

/// Tab과 PageView를 동기화하는 컴포넌트
///
/// 탭 클릭 시 중간 페이지를 거치면서 발생하는 중복 콜백을 방지합니다.
///
/// ## 기본 사용법
/// ```dart
/// FitTabPageView<MenuType>(
///   items: MenuType.values,
///   selectedItem: selectedMenu,
///   onItemChanged: (menu) => bloc.add(ChangeMenu(menu)),
///   labelBuilder: (item) => item.displayName,
///   pageBuilder: (context, item, index) => MenuContent(menu: item),
/// )
/// ```
///
/// ## 커스텀 탭바 사용
/// ```dart
/// FitTabPageView<MenuType>(
///   items: MenuType.values,
///   selectedItem: selectedMenu,
///   onItemChanged: (menu) => bloc.add(ChangeMenu(menu)),
///   tabBarBuilder: (selected, onChanged) => CustomTabBar(
///     selected: selected,
///     onChanged: onChanged,
///   ),
///   pageBuilder: (context, item, index) => MenuContent(menu: item),
/// )
/// ```
///
/// ## 헤더 사용
/// ```dart
/// FitTabPageView<MenuType>(
///   items: MenuType.values,
///   selectedItem: selectedMenu,
///   onItemChanged: (menu) => bloc.add(ChangeMenu(menu)),
///   labelBuilder: (item) => item.displayName,
///   headerBuilder: (context, item) => SummaryHeader(menu: item),
///   pageBuilder: (context, item, index) => MenuContent(menu: item),
/// )
/// ```
class FitTabPageView<T> extends StatefulWidget {
  const FitTabPageView({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemChanged,
    required this.pageBuilder,
    this.labelBuilder,
    this.childBuilder,
    this.initialPage = 0,
    this.tabBarBuilder,
    this.headerBuilder,
  });

  /// 탭 아이템 목록
  final List<T> items;

  /// 현재 선택된 아이템
  final T selectedItem;

  /// 아이템 변경 콜백 (실제 탭 변경 시에만 호출됨)
  final ValueChanged<T> onItemChanged;

  /// 페이지 빌더
  final Widget Function(BuildContext context, T item, int index) pageBuilder;

  /// 탭 라벨 빌더 (간단한 텍스트만 필요할 때)
  final String Function(T item)? labelBuilder;

  /// 탭 자식 빌더 (커스텀 위젯이 필요할 때)
  final Widget Function(T item, bool isSelected)? childBuilder;

  /// 초기 페이지 인덱스
  final int initialPage;

  /// 커스텀 탭바 빌더 (FitTabBar 대신 커스텀 탭바를 사용할 때)
  final Widget Function(T selectedItem, ValueChanged<T> onTabChanged)? tabBarBuilder;

  /// 탭바와 페이지뷰 사이에 들어갈 헤더 빌더
  final Widget Function(BuildContext context, T selectedItem)? headerBuilder;

  @override
  State<FitTabPageView<T>> createState() => _FitTabPageViewState<T>();
}

class _FitTabPageViewState<T> extends State<FitTabPageView<T>> {
  late final PageController _pageController;
  bool _isAnimatingToPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FitTabPageView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 외부에서 selectedItem이 변경되면 페이지도 동기화
    if (oldWidget.selectedItem != widget.selectedItem && !_isAnimatingToPage) {
      final index = widget.items.indexOf(widget.selectedItem);
      if (index != -1 && _pageController.hasClients) {
        final currentPage = _pageController.page?.round() ?? 0;
        if (currentPage != index) {
          _animateToPage(index);
        }
      }
    }
  }

  void _animateToPage(int index) {
    _isAnimatingToPage = true;
    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        )
        .then((_) => _isAnimatingToPage = false);
  }

  void _onTabChanged(T item) {
    final index = widget.items.indexOf(item);
    _animateToPage(index);
    widget.onItemChanged(item);
  }

  void _onPageChanged(int index) {
    if (_isAnimatingToPage) return;
    final item = widget.items[index];
    widget.onItemChanged(item);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 탭바
        if (widget.tabBarBuilder != null)
          widget.tabBarBuilder!(widget.selectedItem, _onTabChanged)
        else
          FitTabBar<T>(
            items: widget.items,
            selectedItem: widget.selectedItem,
            labelBuilder: widget.labelBuilder,
            childBuilder: widget.childBuilder,
            onTabChanged: _onTabChanged,
          ),

        // 헤더 (옵션)
        if (widget.headerBuilder != null) widget.headerBuilder!(context, widget.selectedItem),

        // 페이지뷰
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return widget.pageBuilder(context, item, index);
            },
          ),
        ),
      ],
    );
  }
}
