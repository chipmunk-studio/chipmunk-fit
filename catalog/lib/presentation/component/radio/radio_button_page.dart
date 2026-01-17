import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_component/radio/fit_radio_button.dart';
import 'package:chip_component/radio/fit_radio_button_style.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FitRadioButton 테스트 페이지
class RadioButtonPage extends StatefulWidget {
  const RadioButtonPage({super.key});

  @override
  State<RadioButtonPage> createState() => _RadioButtonPageState();
}

class _RadioButtonPageState extends State<RadioButtonPage> {
  // 기본 설정
  FitRadioButtonStyle _selectedStyle = FitRadioButtonStyle.cupertino;
  double _size = 22.0;
  int _animationSpeed = 200;

  // 테스트 상태
  String? _basicSelected = 'option1';
  String? _labelSelected = 'medium';
  String? _errorSelected;
  String? _disabledSelected = 'disabled1';

  // 선호도 설문 예제
  String? _preferenceSelected = 'coffee';

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "FitRadioButton",
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
                  _buildSurveySection(context),
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
            children: FitRadioButtonStyle.values.map((style) {
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
                      max: 40,
                      divisions: 12,
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
      icon: Icons.radio_button_checked,
      description: "기본적인 라디오 버튼 사용 예제",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitRadioButton<String>(
            value: 'option1',
            groupValue: _basicSelected,
            onChanged: (value) => setState(() => _basicSelected = value),
            style: _selectedStyle,
            size: _size,
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          FitRadioButton<String>(
            value: 'option2',
            groupValue: _basicSelected,
            onChanged: (value) => setState(() => _basicSelected = value),
            style: _selectedStyle,
            size: _size,
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          FitRadioButton<String>(
            value: 'option3',
            groupValue: _basicSelected,
            onChanged: (value) => setState(() => _basicSelected = value),
            style: _selectedStyle,
            size: _size,
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          Text(
            "Selected: ${_basicSelected ?? 'None'}",
            style: context.caption1().copyWith(
                  color: context.fitColors.main,
                  fontWeight: FontWeight.bold,
                ),
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
      description: "다양한 스타일 비교 (iOS 쿠퍼티노, Material, Outlined)",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStyleExample(context, FitRadioButtonStyle.cupertino, "Cupertino"),
          _buildStyleExample(context, FitRadioButtonStyle.material, "Material"),
          _buildStyleExample(context, FitRadioButtonStyle.outlined, "Outlined"),
        ],
      ),
    );
  }

  /// 스타일 예제
  Widget _buildStyleExample(BuildContext context, FitRadioButtonStyle style, String label) {
    return Column(
      children: [
        FitRadioButton<String>(
          value: 'selected',
          groupValue: 'selected',
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
          _buildSizeExample(context, 22, "Medium"),
          _buildSizeExample(context, 28, "Large"),
          _buildSizeExample(context, 36, "X-Large"),
        ],
      ),
    );
  }

  /// 크기 예제
  Widget _buildSizeExample(BuildContext context, double size, String label) {
    return Column(
      children: [
        FitRadioButton<String>(
          value: 'selected',
          groupValue: 'selected',
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
      description: "라벨이 있는 라디오 버튼",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FitRadioButton<String>(
            value: 'small',
            groupValue: _labelSelected,
            onChanged: (value) => setState(() => _labelSelected = value),
            style: _selectedStyle,
            size: _size,
            label: "Small Size",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textPrimary,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          FitRadioButton<String>(
            value: 'medium',
            groupValue: _labelSelected,
            onChanged: (value) => setState(() => _labelSelected = value),
            style: _selectedStyle,
            size: _size,
            label: "Medium Size",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textPrimary,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 12),
          FitRadioButton<String>(
            value: 'large',
            groupValue: _labelSelected,
            onChanged: (value) => setState(() => _labelSelected = value),
            style: _selectedStyle,
            size: _size,
            label: "Large Size",
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
          Text(
            "에러 상태",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          FitRadioButton<String>(
            value: 'error1',
            groupValue: _errorSelected,
            onChanged: (value) => setState(() => _errorSelected = value),
            style: _selectedStyle,
            size: _size,
            hasError: true,
            label: "에러 옵션 1",
            labelStyle: context.body3().copyWith(
                  color: Colors.red,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 8),
          FitRadioButton<String>(
            value: 'error2',
            groupValue: _errorSelected,
            onChanged: (value) => setState(() => _errorSelected = value),
            style: _selectedStyle,
            size: _size,
            hasError: true,
            label: "에러 옵션 2",
            labelStyle: context.body3().copyWith(
                  color: Colors.red,
                ),
            animationDuration: Duration(milliseconds: _animationSpeed),
          ),
          const SizedBox(height: 20),
          // 비활성화 상태
          Text(
            "비활성화 상태",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          FitRadioButton<String>(
            value: 'disabled1',
            groupValue: _disabledSelected,
            onChanged: null,
            style: _selectedStyle,
            size: _size,
            label: "비활성화 옵션 1 (선택됨)",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textDisabled,
                ),
          ),
          const SizedBox(height: 8),
          FitRadioButton<String>(
            value: 'disabled2',
            groupValue: _disabledSelected,
            onChanged: null,
            style: _selectedStyle,
            size: _size,
            label: "비활성화 옵션 2",
            labelStyle: context.body3().copyWith(
                  color: context.fitColors.textDisabled,
                ),
          ),
        ],
      ),
    );
  }

  /// 설문 조사 섹션
  Widget _buildSurveySection(BuildContext context) {
    return _buildSection(
      context,
      title: "Survey Example",
      icon: Icons.poll_outlined,
      description: "실제 사용 예제: 선호도 설문",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "당신이 선호하는 음료는?",
            style: context.subtitle5().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildSurveyOption(
            context,
            value: 'coffee',
            title: "☕ 커피",
            description: "진한 향과 쓴맛의 매력",
          ),
          const SizedBox(height: 12),
          _buildSurveyOption(
            context,
            value: 'tea',
            title: "🍵 차",
            description: "은은한 향과 부드러운 맛",
          ),
          const SizedBox(height: 12),
          _buildSurveyOption(
            context,
            value: 'juice',
            title: "🧃 주스",
            description: "상큼하고 달콤한 과일의 맛",
          ),
          const SizedBox(height: 12),
          _buildSurveyOption(
            context,
            value: 'water',
            title: "💧 물",
            description: "깔끔하고 건강한 선택",
          ),
          if (_preferenceSelected != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.fitColors.main.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: context.fitColors.main),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: context.fitColors.main, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "선택됨: ${_getSurveyLabel(_preferenceSelected!)}",
                    style: context.body3().copyWith(
                          color: context.fitColors.main,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 설문 옵션
  Widget _buildSurveyOption(
    BuildContext context, {
    required String value,
    required String title,
    required String description,
  }) {
    final isSelected = _preferenceSelected == value;
    return GestureDetector(
      onTap: () => setState(() => _preferenceSelected = value),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? context.fitColors.main.withOpacity(0.05)
              : context.fitColors.backgroundBase,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? context.fitColors.main : context.fitColors.dividerPrimary,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            FitRadioButton<String>(
              value: value,
              groupValue: _preferenceSelected,
              onChanged: (value) => setState(() => _preferenceSelected = value),
              style: _selectedStyle,
              size: _size,
              activeColor: context.fitColors.main,
              animationDuration: Duration(milliseconds: _animationSpeed),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.body3().copyWith(
                          color: context.fitColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: context.caption1().copyWith(
                          color: context.fitColors.textTertiary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSurveyLabel(String value) {
    switch (value) {
      case 'coffee':
        return '☕ 커피';
      case 'tea':
        return '🍵 차';
      case 'juice':
        return '🧃 주스';
      case 'water':
        return '💧 물';
      default:
        return value;
    }
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
              Expanded(
                child: Text(
                  title,
                  style: context.subtitle4().copyWith(
                        color: context.fitColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
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
