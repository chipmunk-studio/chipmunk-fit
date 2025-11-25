import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fit_chip_type.dart';

/// iOS 쿠퍼티노 스타일의 Chip 위젯
///
/// 기능:
/// - 다양한 타입 (basic, choice, filter, input, action)
/// - iOS 네이티브 디자인 스타일
/// - 부드러운 애니메이션
/// - 아이콘 지원 (leading, trailing)
/// - 삭제 버튼 지원
/// - 아바타 지원
class FitChip extends StatefulWidget {
  /// 칩 타입
  final FitChipType type;

  /// 레이블 텍스트
  final String label;

  /// 레이블 스타일
  final TextStyle? labelStyle;

  /// 선택 상태 (choice, filter 타입에서 사용)
  final bool isSelected;

  /// 선택 상태 변경 콜백
  final ValueChanged<bool>? onSelected;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 삭제 버튼 콜백 (input 타입에서 사용)
  final VoidCallback? onDeleted;

  /// Leading 아이콘
  final Widget? leadingIcon;

  /// 아바타 (이미지 또는 텍스트)
  final Widget? avatar;

  /// 배경색
  final Color? backgroundColor;

  /// 선택된 배경색
  final Color? selectedBackgroundColor;

  /// 레이블 색상
  final Color? labelColor;

  /// 선택된 레이블 색상
  final Color? selectedLabelColor;

  /// 테두리 색상
  final Color? borderColor;

  /// 선택된 테두리 색상
  final Color? selectedBorderColor;

  /// 삭제 아이콘 색상
  final Color? deleteIconColor;

  /// 패딩
  final EdgeInsets? padding;

  /// 활성화 상태
  final bool isEnabled;

  /// 애니메이션 지속 시간
  final Duration animationDuration;

  /// 고도 (그림자)
  final double elevation;

  const FitChip({
    super.key,
    this.type = FitChipType.basic,
    required this.label,
    this.labelStyle,
    this.isSelected = false,
    this.onSelected,
    this.onTap,
    this.onDeleted,
    this.leadingIcon,
    this.avatar,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.labelColor,
    this.selectedLabelColor,
    this.borderColor,
    this.selectedBorderColor,
    this.deleteIconColor,
    this.padding,
    this.isEnabled = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.elevation = 0,
  });

  @override
  State<FitChip> createState() => _FitChipState();
}

class _FitChipState extends State<FitChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _isPressed = false;
  bool get _isEnabled => widget.isEnabled && (widget.onTap != null || widget.onSelected != null);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FitChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
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
      _handleTap();
    }
  }

  void _onTapCancel() {
    if (mounted) setState(() => _isPressed = false);
  }

  void _handleTap() {
    if (!_isEnabled) return;

    if (widget.type == FitChipType.choice || widget.type == FitChipType.filter) {
      widget.onSelected?.call(!widget.isSelected);
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 색상 결정
    final Color backgroundColor = widget.isSelected
        ? (widget.selectedBackgroundColor ?? theme.primaryColor.withOpacity(0.1))
        : (widget.backgroundColor ?? theme.chipTheme.backgroundColor ?? Colors.grey.shade200);

    final Color labelColor = widget.isSelected
        ? (widget.selectedLabelColor ?? theme.primaryColor)
        : (widget.labelColor ?? theme.textTheme.bodyMedium?.color ?? Colors.black87);

    final Color borderColor = widget.isSelected
        ? (widget.selectedBorderColor ?? theme.primaryColor)
        : (widget.borderColor ?? Colors.transparent);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _isPressed ? _scaleAnimation.value : 1.0,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(_isEnabled ? 1.0 : 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                  width: widget.isSelected ? 1.5 : 1,
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar
                  if (widget.avatar != null) ...[
                    widget.avatar!,
                    const SizedBox(width: 6),
                  ],
                  // Leading icon
                  if (widget.leadingIcon != null) ...[
                    widget.leadingIcon!,
                    const SizedBox(width: 6),
                  ],
                  // Filter 타입의 체크마크
                  if (widget.type == FitChipType.filter && widget.isSelected) ...[
                    Icon(
                      CupertinoIcons.check_mark,
                      size: 16,
                      color: labelColor,
                    ),
                    const SizedBox(width: 6),
                  ],
                  // Label
                  Text(
                    widget.label,
                    style: widget.labelStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          color: labelColor,
                          fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                  ),
                  // Delete button (input 타입)
                  if (widget.type == FitChipType.input && widget.onDeleted != null) ...[
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: widget.onDeleted,
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        size: 16,
                        color: widget.deleteIconColor ?? Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
