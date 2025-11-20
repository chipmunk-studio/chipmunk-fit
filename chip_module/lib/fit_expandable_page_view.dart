import 'package:flutter/material.dart';

/// 각 페이지의 높이에 따라 자동으로 확장되는 PageView
///
/// 각 페이지마다 다른 높이를 가질 수 있으며, 페이지 전환 시 부드럽게 애니메이션됨
class FitExpandablePageView extends StatefulWidget {
  /// 표시할 자식 위젯 목록
  final List<Widget> children;

  /// 페이지 변경 시 호출되는 콜백
  final ValueChanged<int>? onPageChanged;

  /// 초기 페이지 인덱스 (기본값: 0)
  final int initialPage;

  const FitExpandablePageView({
    super.key,
    required this.children,
    this.onPageChanged,
    this.initialPage = 0,
  });

  @override
  State<FitExpandablePageView> createState() => _FitExpandablePageViewState();
}

class _FitExpandablePageViewState extends State<FitExpandablePageView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  /// 현재 페이지의 높이
  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _initializeHeights();
    _initializePageController();
  }

  /// 높이 리스트 초기화
  void _initializeHeights() {
    _heights = List<double>.filled(widget.children.length, 0.0, growable: false);
  }

  /// PageController 초기화 및 리스너 설정
  void _initializePageController() {
    _currentPage = _getValidInitialPage();
    _pageController = PageController(initialPage: _currentPage);
    // PageController 리스너는 스크롤 중 매 프레임마다 호출될 수 있으므로
    // 실제 페이지가 변경될 때만 setState를 호출하도록 최적화
    _pageController.addListener(_handlePageScroll);
  }

  /// 유효한 초기 페이지 인덱스 반환
  int _getValidInitialPage() {
    if (widget.initialPage >= 0 && widget.initialPage < widget.children.length) {
      return widget.initialPage;
    }
    return 0;
  }

  /// 페이지 스크롤 처리 (최적화: 실제 페이지 변경 시에만 setState 호출)
  void _handlePageScroll() {
    final page = _pageController.page;
    if (page == null) return;

    final newPage = page.round();
    if (_shouldUpdatePage(newPage)) {
      setState(() {
        _currentPage = newPage;
      });
      // setState 밖에서 콜백 호출 (불필요한 리빌드 방지)
      widget.onPageChanged?.call(_currentPage);
    }
  }

  /// 페이지 업데이트 필요 여부 확인
  bool _shouldUpdatePage(int newPage) {
    return _currentPage != newPage && _isValidPageIndex(newPage);
  }

  /// 유효한 페이지 인덱스인지 확인
  bool _isValidPageIndex(int index) {
    return index >= 0 && index < _heights.length;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용을 위해 필요

    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[_currentPage], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: _buildPageView(),
    );
  }

  /// PageView 빌드 (onPageChanged 중복 제거)
  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      // PageController의 리스너에서 이미 처리하므로 여기서는 제거
      // 이렇게 하면 페이지 변경 시 setState가 한 번만 호출됨
      children: _sizeReportingChildren,
    );
  }

  /// 크기 측정 기능이 포함된 자식 위젯 목록
  List<Widget> get _sizeReportingChildren {
    // asMap().map().values.toList() 체이닝 최적화
    return List.generate(
      widget.children.length,
      (index) => _buildSizeReportingChild(index, widget.children[index]),
      growable: false,
    );
  }

  /// 크기 측정 기능이 포함된 자식 위젯 빌드
  Widget _buildSizeReportingChild(int index, Widget child) {
    return OverflowBox(
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: Alignment.topCenter,
      child: _SizeReportingWidget(
        onSizeChange: (size) => _updateHeight(index, size.height),
        child: Align(child: child),
      ),
    );
  }

  /// 특정 인덱스의 높이 업데이트 (최적화: 높이가 실제로 변경될 때만 setState)
  void _updateHeight(int index, double height) {
    if (_heights[index] != height) {
      setState(() {
        _heights[index] = height;
      });
    }
  }

  @override
  bool get wantKeepAlive => true; // 상태 유지
}

/// 위젯의 크기를 측정하고 변경 시 콜백을 호출하는 위젯
class _SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const _SizeReportingWidget({
    required this.child,
    required this.onSizeChange,
  });

  @override
  State<_SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<_SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    // PostFrameCallback을 사용하여 레이아웃 완료 후 크기 측정
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  /// 크기 변경 감지 및 콜백 호출 (최적화: 크기가 실제로 변경될 때만 호출)
  void _notifySize() {
    if (!mounted) return;

    final size = context.size;
    if (_hasSizeChanged(size)) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }

  /// 크기 변경 여부 확인 (성능 최적화)
  bool _hasSizeChanged(Size? size) {
    return size != null && _oldSize != size;
  }
}
