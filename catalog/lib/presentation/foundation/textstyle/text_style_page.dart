import 'dart:math';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 타이포그래피 시스템 테스트 페이지
class TextStylePage extends StatefulWidget {
  const TextStylePage({super.key});

  @override
  State<TextStylePage> createState() => _TextStylePageState();
}

class _TextStylePageState extends State<TextStylePage> {
  String _previewText = "안녕하세요 Hello 123";
  FitTextSp _selectedType = FitTextSp.MIN;
  String _selectedCategory = "Headline"; // Headline, Subtitle, Body, Caption, Custom
  bool _showSimulation = false; // 시뮬레이션 모드

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "Typography",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 상단: 수평 레이아웃 (프리뷰 영역 3 : 컨트롤 영역 2)
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: context.fitColors.backgroundElevated,
              border: Border(
                bottom: BorderSide(
                  color: context.fitColors.dividerPrimary,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // 왼쪽: 미리보기 영역 (3)
                Expanded(
                  flex: 3,
                  child: _buildTextPreview(context),
                ),
                // 오른쪽: 컨트롤 (2)
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: context.fitColors.dividerPrimary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: _buildControlSection(context),
                  ),
                ),
              ],
            ),
          ),
          // 하단: 스크롤 영역
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExplanationCard(context),
                  const SizedBox(height: 16),
                  _buildCategorySelector(context),
                  const SizedBox(height: 16),
                  _buildStyleList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 텍스트 미리보기 영역
  Widget _buildTextPreview(BuildContext context) {
    final styles = _getStylesByCategory();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Text Preview",
            style: context.subtitle5().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 선택된 카테고리의 스타일들 미리보기
          Expanded(
            child: ListView.separated(
              itemCount: min(styles.length, 3), // 최대 3개만 표시
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = styles[index];
                final style = item.getStyle(context);
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.fitColors.backgroundBase,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    _previewText,
                    style: style.copyWith(color: context.fitColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 컨트롤 섹션
  Widget _buildControlSection(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: context.subtitle5().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 텍스트 입력 (컴팩트)
          TextField(
            onChanged: (value) => setState(() => _previewText = value),
            style: context.caption1().copyWith(color: context.fitColors.textPrimary),
            decoration: InputDecoration(
              hintText: "미리보기 텍스트",
              hintStyle: context.caption1().copyWith(color: context.fitColors.textTertiary),
              filled: true,
              fillColor: context.fitColors.backgroundBase,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: context.fitColors.dividerPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: context.fitColors.dividerPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: context.fitColors.main, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: context.fitColors.dividerPrimary),
          const SizedBox(height: 12),
          // FitTextSp 타입
          Text(
            "Type:",
            style: context.caption1().copyWith(
              color: context.fitColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          ...FitTextSp.values.map((type) {
            final isSelected = _selectedType == type;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: GestureDetector(
                onTap: () => setState(() => _selectedType = type),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? context.fitColors.main.withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: isSelected ? context.fitColors.main : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        size: 14,
                        color: isSelected ? context.fitColors.main : context.fitColors.textTertiary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        type.name,
                        style: context.caption1().copyWith(
                          color: isSelected ? context.fitColors.main : context.fitColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 카테고리 선택기
  Widget _buildCategorySelector(BuildContext context) {
    final categories = [
      _CategoryItem("Headline", Icons.title, const Color(0xFFEF4444)),
      _CategoryItem("Subtitle", Icons.subtitles, const Color(0xFF3B82F6)),
      _CategoryItem("Body", Icons.notes, const Color(0xFF10B981)),
      _CategoryItem("Caption", Icons.text_fields, const Color(0xFFF59E0B)),
      _CategoryItem("Custom", Icons.font_download, const Color(0xFF9B51E0)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📝 Text Styles",
          style: context.subtitle4().copyWith(
            color: context.fitColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            final isSelected = _selectedCategory == cat.name;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat.name),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? cat.color.withOpacity(0.15) : context.fitColors.backgroundElevated,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? cat.color : context.fitColors.dividerPrimary,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cat.icon,
                      size: 16,
                      color: isSelected ? cat.color : context.fitColors.textTertiary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat.name,
                      style: context.body4().copyWith(
                        color: isSelected ? cat.color : context.fitColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 스타일 리스트
  Widget _buildStyleList(BuildContext context) {
    final styles = _getStylesByCategory();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "✍️ $_selectedCategory Styles",
          style: context.subtitle4().copyWith(
            color: context.fitColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...styles.map((item) => _buildStyleRow(context, item)),
      ],
    );
  }

  /// 카테고리별 스타일 가져오기
  List<_StyleItem> _getStylesByCategory() {
    switch (_selectedCategory) {
      case "Headline":
        return [
          _StyleItem("h1", (c) => c.h1(type: _selectedType)),
          _StyleItem("h2", (c) => c.h2(type: _selectedType)),
        ];
      case "Subtitle":
        return [
          _StyleItem("subtitle1", (c) => c.subtitle1(type: _selectedType)),
          _StyleItem("subtitle2", (c) => c.subtitle2(type: _selectedType)),
          _StyleItem("subtitle3", (c) => c.subtitle3(type: _selectedType)),
          _StyleItem("subtitle4", (c) => c.subtitle4(type: _selectedType)),
          _StyleItem("subtitle5", (c) => c.subtitle5(type: _selectedType)),
          _StyleItem("subtitle6", (c) => c.subtitle6(type: _selectedType)),
        ];
      case "Body":
        return [
          _StyleItem("body1", (c) => c.body1(type: _selectedType)),
          _StyleItem("body2", (c) => c.body2(type: _selectedType)),
          _StyleItem("body3", (c) => c.body3(type: _selectedType)),
          _StyleItem("body4", (c) => c.body4(type: _selectedType)),
        ];
      case "Caption":
        return [
          _StyleItem("caption1", (c) => c.caption1(type: _selectedType)),
        ];
      case "Custom":
        return [
          _StyleItem("neodgm", (c) => c.neodgm().copyWith(fontSize: 20)),
        ];
      default:
        return [];
    }
  }

  /// 설명 카드
  Widget _buildExplanationCard(BuildContext context) {
    final double systemSpValue = 16.sp;
    final double systemSpMinValue = min(16.0, systemSpValue);
    final double systemSpMaxValue = max(16.0, systemSpValue);

    // 화면 크기 정보
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.fitColors.dividerPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: context.fitColors.main, size: 20),
              const SizedBox(width: 8),
              Text(
                "FitTextSp 타입 설명",
                style: context.subtitle5().copyWith(
                      color: context.fitColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 타입별 설명
          _buildTypeExplanation(context, "MIN", "기본값(16.0)과 화면 비례값 중 작은 값",
            "→ 작은 화면에서 텍스트가 너무 커지는 것을 방지"),
          const SizedBox(height: 8),
          _buildTypeExplanation(context, "MAX", "기본값(16.0)과 화면 비례값 중 큰 값",
            "→ 큰 화면에서 텍스트가 너무 작아지는 것을 방지"),
          const SizedBox(height: 8),
          _buildTypeExplanation(context, "SP", "화면 크기에 비례한 값 그대로 사용",
            "→ 모든 화면 크기에 완벽하게 비례"),
          const SizedBox(height: 12),
          Divider(color: context.fitColors.dividerPrimary),
          const SizedBox(height: 12),
          // 현재 시스템 값
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.fitColors.backgroundBase,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📱 현재 디바이스 정보",
                  style: context.caption1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSystemValue("화면 크기", "${screenWidth.toStringAsFixed(0)} × ${screenHeight.toStringAsFixed(0)}"),
                _buildSystemValue("화면 배율", "${devicePixelRatio}x"),
                const SizedBox(height: 4),
                Divider(color: context.fitColors.dividerPrimary),
                const SizedBox(height: 4),
                _buildSystemValue("16.sp (SP)", systemSpValue.toStringAsFixed(2)),
                _buildSystemValue("16.sp (MIN)", systemSpMinValue.toStringAsFixed(2)),
                _buildSystemValue("16.sp (MAX)", systemSpMaxValue.toStringAsFixed(2)),
                const SizedBox(height: 8),
                if (systemSpValue == systemSpMinValue && systemSpValue == systemSpMaxValue)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.fitColors.main.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, size: 14, color: context.fitColors.main),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "현재 화면에서는 MIN/MAX/SP 값이 동일합니다.\n아래 시뮬레이션으로 차이를 확인해보세요!",
                            style: context.caption1().copyWith(
                              color: context.fitColors.main,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 시뮬레이션 토글 버튼
          GestureDetector(
            onTap: () => setState(() => _showSimulation = !_showSimulation),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _showSimulation
                  ? context.fitColors.main
                  : context.fitColors.backgroundBase,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: _showSimulation
                    ? context.fitColors.main
                    : context.fitColors.dividerPrimary,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _showSimulation ? Icons.visibility : Icons.visibility_off,
                    size: 16,
                    color: _showSimulation ? Colors.white : context.fitColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _showSimulation ? "시뮬레이션 숨기기" : "다양한 화면 크기 시뮬레이션 보기",
                    style: context.body4().copyWith(
                      color: _showSimulation ? Colors.white : context.fitColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 시뮬레이션 영역
          if (_showSimulation) ...[
            const SizedBox(height: 12),
            _buildSimulationSection(context),
          ],
        ],
      ),
    );
  }

  /// 시뮬레이션 섹션
  Widget _buildSimulationSection(BuildContext context) {
    // 다양한 화면 크기 시뮬레이션
    final simulations = [
      _SimulationDevice("iPhone SE", 375, 667, 2.0),
      _SimulationDevice("iPhone 14", 390, 844, 3.0),
      _SimulationDevice("iPhone 14 Pro Max", 430, 932, 3.0),
      _SimulationDevice("iPad Air", 820, 1180, 2.0),
      _SimulationDevice("iPad Pro 12.9", 1024, 1366, 2.0),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundBase,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.fitColors.dividerPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.devices, size: 16, color: context.fitColors.main),
              const SizedBox(width: 6),
              Text(
                "다양한 기기에서의 16.sp 계산 값",
                style: context.caption1().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...simulations.map((device) => _buildSimulationRow(context, device)),
        ],
      ),
    );
  }

  /// 시뮬레이션 행
  Widget _buildSimulationRow(BuildContext context, _SimulationDevice device) {
    // ScreenUtil 로직 시뮬레이션
    final scaleWidth = device.width / 375.0;
    final scaleHeight = device.height / 812.0;
    final scale = min(scaleWidth, scaleHeight);

    final spValue = 16.0 * scale;
    final minValue = min(16.0, spValue);
    final maxValue = max(16.0, spValue);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                device.width < 400 ? Icons.phone_iphone : Icons.tablet_mac,
                size: 14,
                color: context.fitColors.textTertiary,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  device.name,
                  style: context.caption1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                "${device.width.toInt()}×${device.height.toInt()}",
                style: context.caption1().copyWith(
                  color: context.fitColors.textTertiary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildValueChip(context, "MIN", minValue, minValue != spValue),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildValueChip(context, "MAX", maxValue, maxValue != spValue),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildValueChip(context, "SP", spValue, true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 값 칩
  Widget _buildValueChip(BuildContext context, String label, double value, bool highlight) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: highlight
          ? context.fitColors.main.withOpacity(0.1)
          : context.fitColors.backgroundBase,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: highlight
            ? context.fitColors.main.withOpacity(0.3)
            : context.fitColors.dividerPrimary,
          width: highlight ? 1 : 0.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: context.caption1().copyWith(
              color: highlight ? context.fitColors.main : context.fitColors.textTertiary,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.toStringAsFixed(1),
            style: context.caption1().copyWith(
              color: highlight ? context.fitColors.main : context.fitColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 타입 설명
  Widget _buildTypeExplanation(BuildContext context, String type, String desc, String usage) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundBase.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: _selectedType.name == type
            ? context.fitColors.main
            : context.fitColors.dividerPrimary,
          width: _selectedType.name == type ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _selectedType.name == type
                    ? context.fitColors.main
                    : context.fitColors.grey400,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  type,
                  style: context.caption1().copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  desc,
                  style: context.caption1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            usage,
            style: context.caption1().copyWith(
              color: context.fitColors.textTertiary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: context.caption1().copyWith(
                  color: context.fitColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            value,
            style: context.caption1().copyWith(
                  color: context.fitColors.main,
                  fontFamily: 'monospace',
                ),
          ),
        ],
      ),
    );
  }


  /// 스타일 행
  Widget _buildStyleRow(BuildContext context, _StyleItem item) {
    final style = item.getStyle(context);
    final fontSize = style.fontSize ?? 14;
    final fontWeight = style.fontWeight ?? FontWeight.normal;
    final lineHeight = style.height ?? 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundBase,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.fitColors.dividerPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 스타일 이름과 속성
          Row(
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: context.caption1().copyWith(
                        color: context.fitColors.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                "${fontSize.toStringAsFixed(1)}sp · ${fontWeight.toString().split('.').last} · ${lineHeight.toStringAsFixed(2)}",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 미리보기 텍스트
          Text(
            _previewText,
            style: style.copyWith(color: context.fitColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

/// 스타일 아이템 모델
class _StyleItem {
  final String name;
  final TextStyle Function(BuildContext) getStyle;

  const _StyleItem(this.name, this.getStyle);
}

/// 카테고리 아이템 모델
class _CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  const _CategoryItem(this.name, this.icon, this.color);
}

/// 시뮬레이션 디바이스 모델
class _SimulationDevice {
  final String name;
  final double width;
  final double height;
  final double pixelRatio;

  const _SimulationDevice(this.name, this.width, this.height, this.pixelRatio);
}

extension on _TextStylePageState {
  Widget _buildThemeSwitcher(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return GestureDetector(
          onTap: () {
            final theme = isDark ? fitLightTheme(context) : fitDarkTheme(context);
            ThemeSwitcher.of(context).changeTheme(theme: theme);
          },
          child: Icon(
            isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
            color: context.fitColors.textPrimary,
            size: 24,
          ),
        );
      },
    );
  }
}
