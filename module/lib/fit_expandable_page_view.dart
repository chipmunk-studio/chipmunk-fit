import 'package:flutter/material.dart';

class FitExpandablePageView extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<int>? onPageChanged;
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

class _FitExpandablePageViewState extends State<FitExpandablePageView> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _heights = List<double>.filled(widget.children.length, 0.0);
    _currentPage = (widget.initialPage >= 0 && widget.initialPage < widget.children.length)
        ? widget.initialPage
        : 0;
    _pageController = PageController(initialPage: _currentPage)
      ..addListener(() {
        final newPage = _pageController.page?.round() ?? 0;
        if (_currentPage != newPage && newPage < _heights.length) {
          setState(() {
            _currentPage = newPage;
            widget.onPageChanged?.call(_currentPage);
          });
        }
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin을 사용하기 위해 호출 필요
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[_currentPage], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // 페이지가 바뀔 때마다 호출되는 콜백
          setState(() {
            _currentPage = index;
            widget.onPageChanged?.call(index);
          });
        },
        children: _sizeReportingChildren
            .asMap()
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap()
      .map(
        (index, child) => MapEntry(
      index,
      OverflowBox(
        // 필요함: 부모가 자식에게 제약을 부여하지 않도록 하여 측정 결과가 왜곡되지 않도록 함.
        minHeight: 0,
        maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: _SizeReportingWidget(
          onSizeChange: (size) => setState(() => _heights[index] = size.height),
          child: Align(child: child),
        ),
      ),
    ),
  )
      .values
      .toList();

  @override
  bool get wantKeepAlive => true; // 상태 유지를 위해 true 반환
}

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
