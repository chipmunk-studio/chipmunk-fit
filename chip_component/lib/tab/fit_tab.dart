import 'package:flutter/material.dart';

/// 언더라인 스타일의 탭 아이템 위젯
///
/// FitTab은 하단 언더라인 인디케이터를 가진 탭 아이템입니다.
/// 선택 상태에 따라 언더라인과 텍스트 색상이 변경됩니다.
///
/// 사용 예시:
/// ```dart
/// FitTab(
///   text: '전체',
///   isSelected: selectedIndex == 0,
///   onTap: () => setState(() => selectedIndex = 0),
/// )
/// ```
class FitTab extends StatelessWidget {
  /// 탭 텍스트
  final String text;

  /// 선택 상태
  final bool isSelected;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 선택된 텍스트 색상
  final Color? selectedTextColor;

  /// 선택되지 않은 텍스트 색상
  final Color? unselectedTextColor;

  /// 언더라인 색상
  final Color? indicatorColor;

  /// 언더라인 두께
  final double indicatorHeight;

  /// 텍스트 스타일
  final TextStyle? textStyle;

  /// 선택된 텍스트 스타일
  final TextStyle? selectedTextStyle;

  /// 패딩
  final EdgeInsets padding;

  /// 활성화 상태
  final bool isEnabled;

  const FitTab({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.indicatorColor,
    this.indicatorHeight = 2.0,
    this.textStyle,
    this.selectedTextStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 색상 결정
    final Color textColor = isSelected
        ? (selectedTextColor ?? theme.primaryColor)
        : (unselectedTextColor ?? Colors.grey.shade600);

    final Color underlineColor =
        indicatorColor ?? selectedTextColor ?? theme.primaryColor;

    // 텍스트 스타일 결정
    final TextStyle resolvedStyle = isSelected
        ? (selectedTextStyle ??
            textStyle?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ))
        : (textStyle?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ));

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? underlineColor : Colors.transparent,
              width: indicatorHeight,
            ),
          ),
        ),
        child: Text(
          text,
          style: resolvedStyle.copyWith(
            color: isEnabled ? textColor : textColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
