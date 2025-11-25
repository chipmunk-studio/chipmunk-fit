import 'package:flutter/material.dart';

import 'fit_radio_button_style.dart';

/// iOS 쿠퍼티노 스타일의 라디오 버튼 위젯
///
/// 기능:
/// - iOS 네이티브 디자인 스타일
/// - 부드러운 애니메이션
/// - 크기 조절 가능
/// - 에러 상태 지원
/// - 라벨 지원
/// - 그룹 선택 관리
class FitRadioButton<T> extends StatefulWidget {
  /// 이 라디오 버튼의 값
  final T value;

  /// 현재 선택된 값
  final T? groupValue;

  /// 상태 변경 콜백
  final void Function(T?)? onChanged;

  /// 스타일
  final FitRadioButtonStyle style;

  /// 크기
  final double size;

  /// 활성 색상
  final Color? activeColor;

  /// 체크 마크 색상 (내부 원)
  final Color? checkColor;

  /// 비활성 색상
  final Color? inactiveColor;

  /// 테두리 색상
  final Color? borderColor;

  /// 에러 상태
  final bool hasError;

  /// 에러 색상
  final Color? errorColor;

  /// 애니메이션 지속 시간
  final Duration animationDuration;

  /// 라벨 텍스트
  final String? label;

  /// 라벨 스타일
  final TextStyle? labelStyle;

  /// 라벨 위치 (라디오 버튼 기준)
  final bool labelOnLeft;

  /// 라벨과 라디오 버튼 간격
  final double spacing;

  const FitRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.style = FitRadioButtonStyle.cupertino,
    this.size = 22.0,
    this.activeColor,
    this.checkColor,
    this.inactiveColor,
    this.borderColor,
    this.hasError = false,
    this.errorColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.label,
    this.labelStyle,
    this.labelOnLeft = false,
    this.spacing = 8.0,
  });

  @override
  State<FitRadioButton<T>> createState() => _FitRadioButtonState<T>();
}

class _FitRadioButtonState<T> extends State<FitRadioButton<T>> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isPressed = false;

  bool get _isEnabled => widget.onChanged != null;

  bool get _isSelected => widget.value == widget.groupValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (_isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FitRadioButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groupValue != widget.groupValue) {
      if (_isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled && mounted) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (mounted) {
      setState(() => _isPressed = false);
      if (_isEnabled) {
        widget.onChanged?.call(widget.value);
      }
    }
  }

  void _onTapCancel() {
    if (mounted) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 색상 결정
    final Color activeColor = widget.hasError
        ? (widget.errorColor ?? Colors.red)
        : (widget.activeColor ?? theme.primaryColor);
    final Color checkColor = widget.checkColor ?? Colors.white;
    final Color inactiveColor = widget.inactiveColor ?? theme.unselectedWidgetColor;
    final Color borderColor = widget.hasError
        ? (widget.errorColor ?? Colors.red)
        : (widget.borderColor ?? theme.dividerColor);

    Widget radioWidget = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(_isPressed ? 0.92 : 1.0),
            transformAlignment: Alignment.center,
            child: _buildRadioByStyle(
              activeColor,
              checkColor,
              inactiveColor,
              borderColor,
            ),
          );
        },
      ),
    );

    // 라벨이 있으면 Row로 감싸기
    if (widget.label != null) {
      final labelWidget = Text(
        widget.label!,
        style: widget.labelStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: _isEnabled ? null : theme.disabledColor,
            ),
      );

      return GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.labelOnLeft
              ? [
                  labelWidget,
                  SizedBox(width: widget.spacing),
                  radioWidget,
                ]
              : [
                  radioWidget,
                  SizedBox(width: widget.spacing),
                  labelWidget,
                ],
        ),
      );
    }

    return radioWidget;
  }

  /// 스타일에 따른 라디오 버튼 빌드
  Widget _buildRadioByStyle(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    switch (widget.style) {
      case FitRadioButtonStyle.cupertino:
        return _buildCupertinoRadio(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
      case FitRadioButtonStyle.material:
        return _buildMaterialRadio(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
      case FitRadioButtonStyle.outlined:
        return _buildOutlinedRadio(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
    }
  }

  /// iOS 쿠퍼티노 스타일 라디오 버튼
  Widget _buildCupertinoRadio(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: _isSelected ? activeColor.withOpacity(_isEnabled ? 1.0 : 0.5) : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: _isSelected ? activeColor : borderColor,
          width: 2,
        ),
      ),
      child: _isSelected
          ? Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: widget.size * 0.5,
                    height: widget.size * 0.5,
                    decoration: BoxDecoration(
                      color: checkColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  /// Material 스타일 라디오 버튼
  Widget _buildMaterialRadio(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: _isSelected ? activeColor : borderColor,
          width: 2,
        ),
      ),
      child: _isSelected
          ? Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: widget.size * 0.5,
                    height: widget.size * 0.5,
                    decoration: BoxDecoration(
                      color: activeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  /// 아웃라인 스타일 라디오 버튼
  Widget _buildOutlinedRadio(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: _isSelected ? activeColor : borderColor,
          width: _isSelected ? 6 : 2,
        ),
      ),
    );
  }
}
