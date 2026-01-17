import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_component/checkbox/fit_check_box.dart';
import 'package:chip_component/checkbox/fit_check_box_style.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FitCheckBox 테스트 페이지
class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  // 기본 설정
  FitCheckBoxStyle _selectedStyle = FitCheckBoxStyle.material;
  double _size = 24.0;
  int _animationSpeed = 200;

  // 테스트 상태
  bool _basicChecked = false;
  bool _labelChecked = true;
  bool _errorChecked = false;
  bool _disabledChecked = true;

  // 다중 선택 예제
  final Map<String, bool> _multipleChoices = {
    'option1': true,
    'option2': false,
    'option3': true,
    'option4': false,
  };

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "FitCheckBox",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildControls(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                children: [
                  _buildBasicSection(context),
                  const SizedBox(height: 16),
                  _buildStylesSection(context),
                  const SizedBox(height: 16),
                  _buildSizesSection(context),
                  const SizedBox(height: 16),
                  _buildLabelSection(context),
                  const SizedBox(height: 16),
                  _buildStatesSection(context),
                  const SizedBox(height: 16),
                  _buildMultipleChoiceSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 컨트롤 패널
  Widget _buildControls(BuildContext context) {
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
          Text(
            "글로벌 설정",
            style: context.subtitle5().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          // 스타일 선택
          Wrap(
            spacing: 8,
            children: FitCheckBoxStyle.values.map((style) {
              final isSelected = _selectedStyle == style;
              return ChoiceChip(
                label: Text(
                  style.name,
                  style: context.caption1().copyWith(
                        color: isSelected ? Colors.white : context.fitColors.textSecondary,
                      ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) setState(() => _selectedStyle = style);
                },
                selectedColor: context.fitColors.main,
                backgroundColor: context.fitColors.backgroundBase,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(
                    color: isSelected ? context.fitColors.main : context.fitColors.dividerPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          // 크기 슬라이더
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Size",
                          style: context.caption1().copyWith(
                                color: context.fitColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.fitColors.main.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "${_size.toStringAsFixed(0)}px",
                            style: context.caption1().copyWith(
                                  color: context.fitColors.main,
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _size,
                      min: 16,
                      max: 48,
                      divisions: 16,
                      activeColor: context.fitColors.main,
                      onChanged: (value) => setState(() => _size = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Animation Speed",
                          style: context.caption1().copyWith(
                                color: context.fitColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.fitColors.main.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "${_animationSpeed}ms",
                            style: context.caption1().copyWith(
                                  color: context.fitColors.main,
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _animationSpeed.toDouble(),
                      min: 100,
                      max: 1000,
                      divisions: 18,
                      activeColor: context.fitColors.main,
                      onChanged: (value) => setState(() => _animationSpeed = value.toInt()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 기본 사용 섹션
  Widget _buildBasicSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Basic Usage",
      icon: Icons.check_box_outlined,
      description: "기본적인 체크박스 사용 예제",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              FitCheckBox(
                value: _basicChecked,
                onChanged: (value) => setState(() => _basicChecked = value),
                style: _selectedStyle,
                size: _size,
                animationDuration: Duration(milliseconds: _animationSpeed),
              ),
              const SizedBox(height: 8),
              Text(
                _basicChecked ? "Checked" : "Unchecked",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 스타일 비교 섹션
  Widget _buildStylesSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Styles",
      icon: Icons.palette_outlined,
      description: "다양한 스타일 비교",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStyleExample(context, FitCheckBoxStyle.material, "Material"),
          _buildStyleExample(context, FitCheckBoxStyle.rounded, "Rounded"),
          _buildStyleExample(context, FitCheckBoxStyle.outlined, "Outlined"),
        ],
      ),
    );
  }

  /// 스타일 예제
  Widget _buildStyleExample(BuildContext context, FitCheckBoxStyle style, String label) {
    return Column(
      children: [
        FitCheckBox(
          value: true,
          onChanged: (_) {},
          style: style,
          size: 28,
          activeColor: context.fitColors.main,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: context.caption1().copyWith(
                color: context.fitColors.textTertiary,
              ),
        ),
      ],
    );
  }

  /// 크기 섹션
  Widget _buildSizesSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Sizes",
      icon: Icons.format_size,
      description: "다양한 크기 비교",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSizeExample(context, 16, "Small"),
          _buildSizeExample(context, 24, "Medium"),
          _buildSizeExample(context, 32, "Large"),
          _buildSizeExample(context, 40, "X-Large"),
        ],
      ),
    );
  }

  /// 크기 예제
  Widget _buildSizeExample(BuildContext context, double size, String label) {
    return Column(
      children: [
        FitCheckBox(
          value: true,
          onChanged: (_) {},
          style: _selectedStyle,
          size: size,
          activeColor: context.fitColors.main,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: context.caption1().copyWith(
                color: context.fitColors.textTertiary,
                fontSize: 10,
              ),
        ),
        Text(
          "${size.toInt()}px",
          style: context.caption1().copyWith(
                color: context.fitColors.textTertiary,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
        ),
      ],
    );
  }

  /// 라벨 섹션
  Widget _buildLabelSection(BuildContext context) {
    return _buildSection(
      context,
      title: "With Label",
      icon: Icons.label_outlined,
      description: "라벨이 있는 체크박스",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitCheckBox(
            value: _labelChecked,
            onChanged: (value) => setState(() => _labelChecked = value),
            style: _selectedStyle,
            size: _size,
            label: "약관에 동의합니다",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textPrimary,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          FitCheckBox(
            value: !_labelChecked,
            onChanged: (value) => setState(() => _labelChecked = !value),
            style: _selectedStyle,
            size: _size,
            label: "라벨이 왼쪽에 위치",
            labelOnLeft: true,
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textPrimary,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
        ],
      ),
    );
  }

  /// 상태 섹션
  Widget _buildStatesSection(BuildContext context) {
    return _buildSection(
      context,
      title: "States",
      icon: Icons.toggle_on_outlined,
      description: "다양한 상태 (에러, 비활성화)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 에러 상태
          FitCheckBox(
            value: _errorChecked,
            onChanged: (value) => setState(() => _errorChecked = value),
            style: _selectedStyle,
            size: _size,
            hasError: true,
            label: "에러 상태 체크박스",
            labelStyle: context.body3().copyWith(
                  color: Colors.red,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          // 비활성화 상태
          FitCheckBox(
            value: _disabledChecked,
            onChanged: null,
            style: _selectedStyle,
            size: _size,
            label: "비활성화 상태 체크박스",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textDisabled,
                ),
          ),
        ],
      ),
    );
  }

  /// 다중 선택 섹션
  Widget _buildMultipleChoiceSection(BuildContext context) {
    final allChecked = _multipleChoices.values.every((v) => v);
    final someChecked = _multipleChoices.values.any((v) => v) && !allChecked;

    return _buildSection(
      context,
      title: "Multiple Choice",
      icon: Icons.checklist,
      description: "다중 선택 예제 (전체 선택 포함)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 전체 선택
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.fitColors.backgroundBase,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.fitColors.dividerPrimary),
            ),
            child: FitCheckBox(
              value: allChecked,
              onChanged: (value) {
                setState(() {
                  _multipleChoices.updateAll((key, _) => value);
                });
              },
              style: _selectedStyle,
              size: _size,
              label: "전체 선택",
              labelStyle: context.subtitle5().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
              activeColor: someChecked ? context.fitColors.main.withOpacity(0.5) : null,
              animationDuration: Duration(milliseconds: _animationSpeed),
            ),
          ),
          const SizedBox(height: 12),
          // 개별 옵션
          ..._multipleChoices.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 16),
              child: FitCheckBox(
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    _multipleChoices[entry.key] = value;
                  });
                },
                style: _selectedStyle,
                size: _size - 4,
                label: "옵션 ${entry.key.replaceAll('option', '')}",
                labelStyle: context.body3().copyWith(
                      color: context.fitColors.textSecondary,
                    ),
                animationDuration: Duration(milliseconds: _animationSpeed),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 섹션 래퍼
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required Widget child,
  }) {
    return Container(
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
          const SizedBox(height: 4),
          Text(
            description,
            style: context.caption1().copyWith(
                  color: context.fitColors.textTertiary,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
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
