import 'package:flutter/material.dart';
import 'fit_check_box_style.dart';
import 'fit_check_box_painter.dart';

/// 향상된 커스텀 체크박스 위젯
///
/// 기능:
/// - 다양한 스타일 (material, rounded, outlined)
/// - 부드러운 애니메이션
/// - 크기 조절 가능
/// - 에러 상태 지원
/// - 라벨 지원
class FitCheckBox extends StatefulWidget {
  /// 체크 상태
  final bool value;

  /// 상태 변경 콜백
  final void Function(bool)? onChanged;

  /// 스타일
  final FitCheckBoxStyle style;

  /// 크기
  final double size;

  /// 활성 색상
  final Color? activeColor;

  /// 체크 마크 색상
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

  /// 라벨 위치 (체크박스 기준)
  final bool labelOnLeft;

  /// 라벨과 체크박스 간격
  final double spacing;

  const FitCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.style = FitCheckBoxStyle.material,
    this.size = 20.0,
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
  State<FitCheckBox> createState() => _FitCheckBoxState();
}

class _FitCheckBoxState extends State<FitCheckBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _checkAnimation;

  bool _isPressed = false;
  bool get _isEnabled => widget.onChanged != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _checkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FitCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
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
        widget.onChanged?.call(!widget.value);
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
    final Color inactiveColor =
        widget.inactiveColor ?? theme.unselectedWidgetColor;
    final Color borderColor = widget.hasError
        ? (widget.errorColor ?? Colors.red)
        : (widget.borderColor ?? theme.dividerColor);

    Widget checkboxWidget = GestureDetector(
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
            child: _buildCheckboxByStyle(
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
                  checkboxWidget,
                ]
              : [
                  checkboxWidget,
                  SizedBox(width: widget.spacing),
                  labelWidget,
                ],
        ),
      );
    }

    return checkboxWidget;
  }

  /// 스타일에 따른 체크박스 빌드
  Widget _buildCheckboxByStyle(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    switch (widget.style) {
      case FitCheckBoxStyle.material:
        return _buildMaterialCheckbox(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
      case FitCheckBoxStyle.rounded:
        return _buildRoundedCheckbox(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
      case FitCheckBoxStyle.outlined:
        return _buildOutlinedCheckbox(
          activeColor,
          checkColor,
          inactiveColor,
          borderColor,
        );
    }
  }

  /// Material 스타일 체크박스
  Widget _buildMaterialCheckbox(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.value
            ? activeColor.withOpacity(_isEnabled ? 1.0 : 0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.value ? activeColor : borderColor,
          width: 2,
        ),
      ),
      child: widget.value
          ? CustomPaint(
              painter: CheckMarkPainter(
                progress: _checkAnimation.value,
                color: checkColor,
                strokeWidth: 2.5,
              ),
            )
          : null,
    );
  }

  /// 라운드 스타일 체크박스
  Widget _buildRoundedCheckbox(
    Color activeColor,
    Color checkColor,
    Color inactiveColor,
    Color borderColor,
  ) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.value
            ? activeColor.withOpacity(_isEnabled ? 1.0 : 0.5)
            : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.value ? activeColor : borderColor,
          width: 2,
        ),
      ),
      child: widget.value
          ? CustomPaint(
              painter: CheckMarkPainter(
                progress: _checkAnimation.value,
                color: checkColor,
                strokeWidth: 2.5,
              ),
            )
          : null,
    );
  }

  /// 아웃라인 스타일 체크박스
  Widget _buildOutlinedCheckbox(
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
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.value ? activeColor : borderColor,
          width: 2,
        ),
      ),
      child: widget.value
          ? CustomPaint(
              painter: CheckMarkPainter(
                progress: _checkAnimation.value,
                color: activeColor,
                strokeWidth: 2.5,
              ),
            )
          : null,
    );
  }
}
