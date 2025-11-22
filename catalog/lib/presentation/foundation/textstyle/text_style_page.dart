import 'dart:math';

import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
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

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "Typography",
        actions: [],
      ),
      body: Column(
        children: [
          _buildPreviewControls(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExplanationCard(context),
                  const SizedBox(height: 16),
                  _buildStyleSection(
                    context,
                    title: "Headline",
                    icon: Icons.title,
                    styles: [
                      _StyleItem("h1", (c) => c.h1(type: _selectedType)),
                      _StyleItem("h2", (c) => c.h2(type: _selectedType)),
                    ],
                  ),
                  _buildStyleSection(
                    context,
                    title: "Subtitle",
                    icon: Icons.subtitles,
                    styles: [
                      _StyleItem("subtitle1", (c) => c.subtitle1(type: _selectedType)),
                      _StyleItem("subtitle2", (c) => c.subtitle2(type: _selectedType)),
                      _StyleItem("subtitle3", (c) => c.subtitle3(type: _selectedType)),
                      _StyleItem("subtitle4", (c) => c.subtitle4(type: _selectedType)),
                      _StyleItem("subtitle5", (c) => c.subtitle5(type: _selectedType)),
                      _StyleItem("subtitle6", (c) => c.subtitle6(type: _selectedType)),
                    ],
                  ),
                  _buildStyleSection(
                    context,
                    title: "Body",
                    icon: Icons.notes,
                    styles: [
                      _StyleItem("body1", (c) => c.body1(type: _selectedType)),
                      _StyleItem("body2", (c) => c.body2(type: _selectedType)),
                      _StyleItem("body3", (c) => c.body3(type: _selectedType)),
                      _StyleItem("body4", (c) => c.body4(type: _selectedType)),
                    ],
                  ),
                  _buildStyleSection(
                    context,
                    title: "Caption",
                    icon: Icons.text_fields,
                    styles: [
                      _StyleItem("caption1", (c) => c.caption1(type: _selectedType)),
                    ],
                  ),
                  _buildStyleSection(
                    context,
                    title: "Custom Fonts",
                    icon: Icons.font_download,
                    styles: [
                      _StyleItem("neodgm", (c) => c.neodgm().copyWith(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 미리보기 컨트롤
  Widget _buildPreviewControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        border: Border(
          bottom: BorderSide(
            color: context.fitColors.dividerPrimary,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 텍스트 입력
          TextField(
            onChanged: (value) => setState(() => _previewText = value),
            style: context.body2().copyWith(color: context.fitColors.textPrimary),
            decoration: InputDecoration(
              hintText: "미리보기 텍스트를 입력하세요",
              hintStyle: context.body2().copyWith(color: context.fitColors.textTertiary),
              filled: true,
              fillColor: context.fitColors.backgroundBase,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: context.fitColors.dividerPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: context.fitColors.dividerPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: context.fitColors.main, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          // FitTextSp 타입 선택
          Row(
            children: [
              Text(
                "FitTextSp Type:",
                style: context.caption1().copyWith(
                      color: context.fitColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 12),
              ...FitTextSp.values.map((type) {
                final isSelected = _selectedType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      type.name,
                      style: context.caption1().copyWith(
                            color: isSelected ? Colors.white : context.fitColors.textSecondary,
                          ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedType = type);
                    },
                    selectedColor: context.fitColors.main,
                    backgroundColor: context.fitColors.backgroundBase,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(
                        color: isSelected ? context.fitColors.main : context.fitColors.dividerPrimary,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// 설명 카드
  Widget _buildExplanationCard(BuildContext context) {
    final double systemSpValue = 16.sp;
    final double systemSpMinValue = min(16.0, systemSpValue);
    final double systemSpMaxValue = max(16.0, systemSpValue);

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
          Text(
            "MIN: 기본 sp 값과 화면 크기 계산 값 중 작은 값\n"
            "MAX: 기본 sp 값과 화면 크기 계산 값 중 큰 값\n"
            "SP: 화면 크기에 따라 계산된 sp 값 그대로 사용",
            style: context.body4().copyWith(color: context.fitColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.fitColors.backgroundBase,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSystemValue("SP Value", "$systemSpValue"),
                _buildSystemValue("MIN Value", "$systemSpMinValue"),
                _buildSystemValue("MAX Value", "$systemSpMaxValue"),
              ],
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

  /// 스타일 섹션
  Widget _buildStyleSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<_StyleItem> styles,
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
            const SizedBox(height: 12),
            ...styles.map((item) => _buildStyleRow(context, item)),
          ],
        ),
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
