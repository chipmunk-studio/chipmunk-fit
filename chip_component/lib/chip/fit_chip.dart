import 'package:flutter/material.dart';

/// iOS 쿠퍼티노 스타일의 Chip 컨테이너 위젯
///
/// FitChip은 칩 형태의 컨테이너만 제공합니다.
/// 내부 컨텐츠는 child로 자유롭게 커스터마이징할 수 있습니다.
///
/// 기능:
/// - 칩 모양의 컨테이너 (배경색, 테두리, 패딩, 그림자)
/// - 탭 제스처 및 애니메이션
/// - 선택 상태 관리
/// - 내부 컨텐츠는 child로 완전히 커스터마이징
class FitChip extends StatefulWidget {
  /// 칩 내부 컨텐츠
  final Widget child;

  /// 선택 상태
  final bool isSelected;

  /// 선택 상태 변경 콜백
  final ValueChanged<bool>? onSelected;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 배경색
  final Color? backgroundColor;

  /// 선택된 배경색
  final Color? selectedBackgroundColor;

  /// 테두리 색상
  final Color? borderColor;

  /// 선택된 테두리 색상
  final Color? selectedBorderColor;

  /// 테두리 두께
  final double borderWidth;

  /// 선택된 테두리 두께
  final double? selectedBorderWidth;

  /// 패딩
  final EdgeInsets padding;

  /// 모서리 반경
  final double borderRadius;

  /// 활성화 상태
  final bool isEnabled;

  /// 애니메이션 지속 시간
  final Duration animationDuration;

  /// 고도 (그림자)
  final double elevation;

  /// 탭 시 스케일 배율
  final double pressedScale;

  const FitChip({
    super.key,
    required this.child,
    this.isSelected = false,
    this.onSelected,
    this.onTap,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.borderColor,
    this.selectedBorderColor,
    this.borderWidth = 1.0,
    this.selectedBorderWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = 16.0,
    this.isEnabled = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.elevation = 0,
    this.pressedScale = 0.95,
  });

  @override
  State<FitChip> createState() => _FitChipState();
}

class _FitChipState extends State<FitChip> {
  bool _isPressed = false;
  bool get _isEnabled => widget.isEnabled && (widget.onTap != null || widget.onSelected != null);

  void _onTapDown(TapDownDetails details) {
    if (_isEnabled) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _handleTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  void _handleTap() {
    if (!_isEnabled) return;

    if (widget.onSelected != null) {
      widget.onSelected?.call(!widget.isSelected);
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 색상 결정 - 사용자 지정 색상 우선
    final Color backgroundColor = widget.isSelected
        ? (widget.selectedBackgroundColor ?? theme.primaryColor.withOpacity(0.1))
        : (widget.backgroundColor ?? theme.chipTheme.backgroundColor ?? Colors.grey.shade200);

    final Color borderColor = widget.isSelected
        ? (widget.selectedBorderColor ?? theme.primaryColor)
        : (widget.borderColor ?? Colors.transparent);

    final double borderWidth = widget.isSelected
        ? (widget.selectedBorderWidth ?? widget.borderWidth)
        : widget.borderWidth;

    // disabled 상태일 때만 opacity 적용 (사용자 지정 alpha 값 보존)
    final Color effectiveBackgroundColor = _isEnabled
        ? backgroundColor
        : backgroundColor.withOpacity(backgroundColor.opacity * 0.5);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: Curves.easeOut,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            boxShadow: widget.elevation > 0
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: widget.elevation,
                      offset: Offset(0, widget.elevation / 2),
                    ),
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
