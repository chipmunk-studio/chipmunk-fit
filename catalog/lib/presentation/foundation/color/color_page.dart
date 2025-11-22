import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
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

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "Color System",
        actions: [
          // 다크모드 토글
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Switch(
              value: _showDarkMode,
              onChanged: (value) => setState(() => _showDarkMode = value),
              activeColor: context.fitColors.main,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModeIndicator(context),
            const SizedBox(height: 16),
            _buildSemanticColors(context),
            const SizedBox(height: 16),
            _buildColorSection(context, "Grey Scale", _getGreyColors()),
            _buildColorSection(context, "Green Colors", _getGreenColors()),
            _buildColorSection(context, "Blue Colors", _getBlueColors()),
            _buildColorSection(context, "Red Colors", _getRedColors()),
            _buildColorSection(context, "Yellow Colors", _getYellowColors()),
            _buildColorSection(context, "Brick Colors", _getBrickColors()),
          ],
        ),
      ),
    );
  }

  /// 모드 인디케이터
  Widget _buildModeIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _showDarkMode ? context.fitColors.grey700 : context.fitColors.grey300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _showDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: context.fitColors.main,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            _showDarkMode ? "Dark Mode" : "Light Mode",
            style: context.subtitle5().copyWith(
                  color: context.fitColors.textPrimary,
                ),
          ),
          const Spacer(),
          Text(
            "현재 표시 중",
            style: context.caption1().copyWith(
                  color: context.fitColors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }

  /// 시맨틱 컬러 (의미 기반)
  Widget _buildSemanticColors(BuildContext context) {
    final colors = _getCurrentColors();

    final semanticColors = [
      _ColorItem("Main", colors.main),
      _ColorItem("Background Base", colors.backgroundBase),
      _ColorItem("Background Elevated", colors.backgroundElevated),
      _ColorItem("Text Primary", colors.textPrimary),
      _ColorItem("Text Secondary", colors.textSecondary),
      _ColorItem("Text Tertiary", colors.textTertiary),
      _ColorItem("Divider Primary", colors.dividerPrimary),
      _ColorItem("Divider Secondary", colors.dividerSecondary),
    ];

    return _buildSection(
      context,
      title: "Semantic Colors",
      icon: Icons.palette,
      description: "의미 기반 컬러 시스템",
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: semanticColors.length,
        itemBuilder: (context, index) {
          final item = semanticColors[index];
          return _buildColorTile(context, item.name, item.color);
        },
      ),
    );
  }

  /// 컬러 섹션
  Widget _buildColorSection(BuildContext context, String title, List<_ColorItem> colors) {
    return _buildSection(
      context,
      title: title,
      icon: Icons.color_lens,
      child: Column(
        children: colors
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildColorTile(context, item.name, item.color),
                ))
            .toList(),
      ),
    );
  }

  /// 섹션 래퍼
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? description,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: context.fitColors.backgroundElevated,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: context.fitColors.main, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: context.subtitle4().copyWith(
                        color: context.fitColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            if (description != null) ...[
              const SizedBox(height: 4),
              Text(
                description,
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                    ),
              ),
            ],
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
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
}

/// 컬러 아이템 모델
class _ColorItem {
  final String name;
  final Color color;

  const _ColorItem(this.name, this.color);
}
