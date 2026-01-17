import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_component/button/fit_switch_button.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 컬러 시스템 테스트 페이지
class ColorPage extends StatefulWidget {
  const ColorPage({super.key});

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  bool _showDarkMode = false;
  String _selectedCategory = "Semantic"; // Semantic, Grey, Green, Blue, Red, Yellow, Brick

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "Color System",
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
                  child: _buildColorPreview(context),
                ),
                // 오른쪽: 상태 및 컨트롤 (2)
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
          // 하단: 스크롤 영역 (카테고리별 컬러 리스트)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(context),
                  const SizedBox(height: 16),
                  _buildCategorySelector(context),
                  const SizedBox(height: 16),
                  _buildColorList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 컬러 미리보기 영역
  Widget _buildColorPreview(BuildContext context) {
    final colors = _getCurrentColors();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color Preview",
            style: context.subtitle5().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 주요 색상들을 그리드로 표시
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPreviewColorBox(colors.main, "Main"),
                _buildPreviewColorBox(colors.backgroundBase, "BG"),
                _buildPreviewColorBox(colors.textPrimary, "Text1"),
                _buildPreviewColorBox(colors.textSecondary, "Text2"),
                _buildPreviewColorBox(colors.grey500, "Grey"),
                _buildPreviewColorBox(colors.green500, "Green"),
                _buildPreviewColorBox(colors.red500, "Red"),
                _buildPreviewColorBox(colors.yellowBase, "Yellow"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 미리보기 컬러 박스
  Widget _buildPreviewColorBox(Color color, String label) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: _getContrastingColor(color).withOpacity(0.2),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: _getContrastingColor(color),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 컨트롤 섹션
  Widget _buildControlSection(BuildContext context) {
    return Padding(
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
          // 모드 전환
          Row(
            children: [
              Icon(
                _showDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: context.fitColors.main,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _showDarkMode ? "Dark Mode" : "Light Mode",
                  style: context.body4().copyWith(
                    color: context.fitColors.textPrimary,
                  ),
                ),
              ),
              FitSwitchButton(
                isOn: _showDarkMode,
                onToggle: (_) => setState(() => _showDarkMode = !_showDarkMode),
                activeColor: context.fitColors.main,
                inactiveColor: context.fitColors.grey300,
                debounceDuration: const Duration(milliseconds: 300),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: context.fitColors.dividerPrimary),
          const SizedBox(height: 12),
          // 상태 표시
          _buildStatusItem(
            context,
            "Category",
            _selectedCategory,
            Icons.category,
          ),
          const SizedBox(height: 8),
          _buildStatusItem(
            context,
            "Total Colors",
            "${_getColorsByCategory().length}",
            Icons.palette,
          ),
        ],
      ),
    );
  }

  /// 상태 아이템
  Widget _buildStatusItem(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: context.fitColors.textTertiary),
        const SizedBox(width: 6),
        Text(
          "$label:",
          style: context.caption1().copyWith(
            color: context.fitColors.textTertiary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: context.caption1().copyWith(
            color: context.fitColors.main,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// 정보 섹션
  Widget _buildInfoSection(BuildContext context) {
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
                "컬러 시스템 가이드",
                style: context.subtitle5().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "• Semantic Colors: 의미 기반 컬러 (배경, 텍스트, 구분선 등)\n"
            "• Grey Scale: 회색 계열 (0~900)\n"
            "• Brand Colors: 브랜드 컬러 (Green, Blue, Red, Yellow, Brick)\n"
            "• 각 컬러를 탭하면 Hex 코드가 복사됩니다",
            style: context.body4().copyWith(color: context.fitColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// 카테고리 선택기
  Widget _buildCategorySelector(BuildContext context) {
    final categories = [
      _CategoryItem("Semantic", Icons.palette, const Color(0xFF3182F6)),
      _CategoryItem("Grey", Icons.gradient, const Color(0xFF6B7280)),
      _CategoryItem("Green", Icons.eco, const Color(0xFF10B981)),
      _CategoryItem("Blue", Icons.water_drop, const Color(0xFF3B82F6)),
      _CategoryItem("Red", Icons.favorite, const Color(0xFFEF4444)),
      _CategoryItem("Yellow", Icons.wb_sunny, const Color(0xFFF59E0B)),
      _CategoryItem("Brick", Icons.square, const Color(0xFFDC2626)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "📁 Color Categories",
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

  /// 컬러 리스트
  Widget _buildColorList(BuildContext context) {
    final colors = _getColorsByCategory();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🎨 $_selectedCategory Colors",
          style: context.subtitle4().copyWith(
            color: context.fitColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...colors.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildColorTile(context, item.name, item.color),
        )),
      ],
    );
  }

  /// 카테고리별 컬러 가져오기
  List<_ColorItem> _getColorsByCategory() {
    switch (_selectedCategory) {
      case "Semantic":
        return _getSemanticColors();
      case "Grey":
        return _getGreyColors();
      case "Green":
        return _getGreenColors();
      case "Blue":
        return _getBlueColors();
      case "Red":
        return _getRedColors();
      case "Yellow":
        return _getYellowColors();
      case "Brick":
        return _getBrickColors();
      default:
        return [];
    }
  }

  /// Semantic 컬러 리스트
  List<_ColorItem> _getSemanticColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Main", colors.main),
      _ColorItem("Background Base", colors.backgroundBase),
      _ColorItem("Background Elevated", colors.backgroundElevated),
      _ColorItem("Text Primary", colors.textPrimary),
      _ColorItem("Text Secondary", colors.textSecondary),
      _ColorItem("Text Tertiary", colors.textTertiary),
      _ColorItem("Divider Primary", colors.dividerPrimary),
      _ColorItem("Divider Secondary", colors.dividerSecondary),
    ];
  }


  /// 컬러 타일
  Widget _buildColorTile(BuildContext context, String name, Color color) {
    final hexColor = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hexColor));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$hexColor 복사됨'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: context.fitColors.dividerPrimary,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.caption1().copyWith(
                          color: _getContrastingColor(color),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hexColor,
                    style: context.caption1().copyWith(
                          color: _getContrastingColor(color).withOpacity(0.7),
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.copy,
              color: _getContrastingColor(color).withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// 대비 컬러 계산
  Color _getContrastingColor(Color color) {
    final brightness = color.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }

  /// 현재 테마의 컬러 가져오기
  FitColors _getCurrentColors() {
    return _showDarkMode ? darkFitColors : lightFitColors;
  }

  /// Grey 컬러 리스트
  List<_ColorItem> _getGreyColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Grey 0", colors.grey0),
      _ColorItem("Grey 50", colors.grey50),
      _ColorItem("Grey 100", colors.grey100),
      _ColorItem("Grey 200", colors.grey200),
      _ColorItem("Grey 300", colors.grey300),
      _ColorItem("Grey 400", colors.grey400),
      _ColorItem("Grey 500", colors.grey500),
      _ColorItem("Grey 600", colors.grey600),
      _ColorItem("Grey 700", colors.grey700),
      _ColorItem("Grey 800", colors.grey800),
      _ColorItem("Grey 900", colors.grey900),
    ];
  }

  /// Green 컬러 리스트
  List<_ColorItem> _getGreenColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Green 50", colors.green50),
      _ColorItem("Green 200", colors.green200),
      _ColorItem("Green 500", colors.green500),
      _ColorItem("Green 600", colors.green600),
      _ColorItem("Green 700", colors.green700),
      _ColorItem("Green Base", colors.greenBase),
      _ColorItem("Green Alpha 72", colors.greenAlpha72),
      _ColorItem("Green Alpha 48", colors.greenAlpha48),
      _ColorItem("Green Alpha 24", colors.greenAlpha24),
      _ColorItem("Green Alpha 12", colors.greenAlpha12),
    ];
  }

  /// Blue 컬러 리스트
  List<_ColorItem> _getBlueColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Blue Alpha 72", colors.blueAlpha72),
      _ColorItem("Blue Alpha 48", colors.blueAlpha48),
      _ColorItem("Blue Alpha 24", colors.blueAlpha24),
      _ColorItem("Blue Alpha 12", colors.blueAlpha12),
    ];
  }

  /// Red 컬러 리스트
  List<_ColorItem> _getRedColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Red 50", colors.red50),
      _ColorItem("Red 200", colors.red200),
      _ColorItem("Red 500", colors.red500),
      _ColorItem("Red 600", colors.red600),
      _ColorItem("Red 700", colors.red700),
      _ColorItem("Red Base", colors.redBase),
      _ColorItem("Red Alpha 72", colors.redAlpha72),
      _ColorItem("Red Alpha 48", colors.redAlpha48),
      _ColorItem("Red Alpha 24", colors.redAlpha24),
      _ColorItem("Red Alpha 12", colors.redAlpha12),
    ];
  }

  /// Yellow 컬러 리스트
  List<_ColorItem> _getYellowColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Yellow Base", colors.yellowBase),
      _ColorItem("Yellow Alpha 72", colors.yellowAlpha72),
      _ColorItem("Yellow Alpha 48", colors.yellowAlpha48),
      _ColorItem("Yellow Alpha 24", colors.yellowAlpha24),
      _ColorItem("Yellow Alpha 12", colors.yellowAlpha12),
    ];
  }

  /// Brick 컬러 리스트
  List<_ColorItem> _getBrickColors() {
    final colors = _getCurrentColors();
    return [
      _ColorItem("Brick 50", colors.brick50),
      _ColorItem("Brick 200", colors.brick200),
      _ColorItem("Brick 500", colors.brick500),
      _ColorItem("Brick 600", colors.brick600),
      _ColorItem("Brick 700", colors.brick700),
    ];
  }

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

/// 컬러 아이템 모델
class _ColorItem {
  final String name;
  final Color color;

  const _ColorItem(this.name, this.color);
}

/// 카테고리 아이템 모델
class _CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  const _CategoryItem(this.name, this.icon, this.color);
}
