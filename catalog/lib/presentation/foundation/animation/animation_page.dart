import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chipfit/component/fit_animation.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 애니메이션 시스템 테스트 페이지
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  String _selectedType = "Bounce"; // Bounce, Scale

  // Linear Bounce 파라미터
  int _bounceDuration = 2000;
  double _bounceDistance = 10.0;

  // Scale 파라미터
  int _scaleDuration = 1500;
  double _scaleBegin = 1.0;
  double _scaleEnd = 1.3;

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "Animation",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 상단: 수평 레이아웃 (프리뷰 영역 3 : 컨트롤 영역 2)
          Container(
            height: 220,
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
                  child: _buildAnimationPreview(context),
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
                children: [
                  _buildInfoSection(context),
                  const SizedBox(height: 16),
                  _buildTypeSelector(context),
                  const SizedBox(height: 16),
                  _buildParameterSection(context),
                  const SizedBox(height: 16),
                  _buildPresetsSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 애니메이션 미리보기 영역
  Widget _buildAnimationPreview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Animation Preview",
            style: context.subtitle5().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Center(
              child: _selectedType == "Bounce"
                  ? FitLinearBounceAnimation(
                      key: ValueKey('bounce_${_bounceDuration}_$_bounceDistance'),
                      duration: _bounceDuration,
                      distance: _bounceDistance,
                      child: _buildPreviewWidget(context, "Bounce"),
                    )
                  : FitScaleAnimation(
                      key: ValueKey('scale_${_scaleDuration}_${_scaleBegin}_$_scaleEnd'),
                      duration: _scaleDuration,
                      scaleBegin: _scaleBegin,
                      scaleEnd: _scaleEnd,
                      child: _buildPreviewWidget(context, "Scale"),
                    ),
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
          // 타입 선택
          Text(
            "Type:",
            style: context.caption1().copyWith(
              color: context.fitColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          ...[
            _AnimationType("Bounce", Icons.vertical_align_center),
            _AnimationType("Scale", Icons.zoom_out_map),
          ].map((type) {
            final isSelected = _selectedType == type.name;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: GestureDetector(
                onTap: () => setState(() => _selectedType = type.name),
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
                        type.icon,
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
          const SizedBox(height: 12),
          Divider(color: context.fitColors.dividerPrimary),
          const SizedBox(height: 12),
          // 파라미터 표시
          if (_selectedType == "Bounce") ...[
            _buildParamDisplay("Duration", "${_bounceDuration}ms"),
            const SizedBox(height: 4),
            _buildParamDisplay("Distance", "${_bounceDistance.toStringAsFixed(1)}px"),
          ] else ...[
            _buildParamDisplay("Duration", "${_scaleDuration}ms"),
            const SizedBox(height: 4),
            _buildParamDisplay("Begin", "${_scaleBegin.toStringAsFixed(2)}x"),
            const SizedBox(height: 4),
            _buildParamDisplay("End", "${_scaleEnd.toStringAsFixed(2)}x"),
          ],
        ],
      ),
    );
  }

  /// 파라미터 표시
  Widget _buildParamDisplay(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: context.caption1().copyWith(
            color: context.fitColors.textTertiary,
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: context.caption1().copyWith(
            color: context.fitColors.main,
            fontWeight: FontWeight.w600,
            fontSize: 11,
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
                "애니메이션 시스템 가이드",
                style: context.subtitle5().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "• Bounce: 위아래 또는 좌우로 움직이는 반복 애니메이션\n"
            "• Scale: 크기 변화를 반복하는 애니메이션\n"
            "• Duration: 애니메이션 주기 (ms)\n"
            "• Distance: 이동 거리 (px) / Begin/End: 크기 배율",
            style: context.body4().copyWith(color: context.fitColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// 타입 선택기
  Widget _buildTypeSelector(BuildContext context) {
    final types = [
      _AnimationType("Bounce", Icons.vertical_align_center),
      _AnimationType("Scale", Icons.zoom_out_map),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🎬 Animation Types",
          style: context.subtitle4().copyWith(
            color: context.fitColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: types.map((type) {
            final isSelected = _selectedType == type.name;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: type == types.first ? 8 : 0),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedType = type.name),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.fitColors.main.withOpacity(0.15)
                          : context.fitColors.backgroundElevated,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected ? context.fitColors.main : context.fitColors.dividerPrimary,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          type.icon,
                          color: isSelected ? context.fitColors.main : context.fitColors.textTertiary,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type.name,
                          style: context.body3().copyWith(
                            color: isSelected ? context.fitColors.main : context.fitColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 파라미터 섹션
  Widget _buildParameterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "⚙️ Parameters",
            style: context.subtitle4().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (_selectedType == "Bounce") ...[
            _buildSlider(
              context,
              label: "Duration (ms)",
              value: _bounceDuration.toDouble(),
              min: 500,
              max: 5000,
              divisions: 45,
              onChanged: (value) => setState(() => _bounceDuration = value.toInt()),
              valueLabel: "${_bounceDuration}ms",
            ),
            _buildSlider(
              context,
              label: "Distance (px)",
              value: _bounceDistance,
              min: 5,
              max: 50,
              divisions: 45,
              onChanged: (value) => setState(() => _bounceDistance = value),
              valueLabel: "${_bounceDistance.toStringAsFixed(1)}px",
            ),
          ] else ...[
            _buildSlider(
              context,
              label: "Duration (ms)",
              value: _scaleDuration.toDouble(),
              min: 500,
              max: 5000,
              divisions: 45,
              onChanged: (value) => setState(() => _scaleDuration = value.toInt()),
              valueLabel: "${_scaleDuration}ms",
            ),
            _buildSlider(
              context,
              label: "Scale Begin",
              value: _scaleBegin,
              min: 0.5,
              max: 1.5,
              divisions: 20,
              onChanged: (value) => setState(() => _scaleBegin = value),
              valueLabel: "${_scaleBegin.toStringAsFixed(2)}x",
            ),
            _buildSlider(
              context,
              label: "Scale End",
              value: _scaleEnd,
              min: 0.5,
              max: 2.0,
              divisions: 30,
              onChanged: (value) => setState(() => _scaleEnd = value),
              valueLabel: "${_scaleEnd.toStringAsFixed(2)}x",
            ),
          ],
        ],
      ),
    );
  }

  /// 프리셋 섹션
  Widget _buildPresetsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🎯 Presets",
            style: context.subtitle4().copyWith(
              color: context.fitColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPresetBox(context, "Fast", 800, 8.0, 0.9, 1.2),
              _buildPresetBox(context, "Normal", 1500, 12.0, 1.0, 1.3),
              _buildPresetBox(context, "Slow", 3000, 15.0, 1.0, 1.5),
            ],
          ),
        ],
      ),
    );
  }

  /// 프리셋 박스
  Widget _buildPresetBox(
    BuildContext context,
    String label,
    int duration,
    double distance,
    double scaleBegin,
    double scaleEnd,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedType == "Bounce") {
                _bounceDuration = duration;
                _bounceDistance = distance;
              } else {
                _scaleDuration = duration;
                _scaleBegin = scaleBegin;
                _scaleEnd = scaleEnd;
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.fitColors.backgroundBase,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: context.fitColors.dividerPrimary),
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: context.caption1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _selectedType == "Bounce"
                    ? FitLinearBounceAnimation(
                        duration: duration,
                        distance: distance,
                        child: _buildComparisonWidget(context),
                      )
                    : FitScaleAnimation(
                        duration: duration,
                        scaleBegin: scaleBegin,
                        scaleEnd: scaleEnd,
                        child: _buildComparisonWidget(context),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 슬라이더
  Widget _buildSlider(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    int? divisions,
    required ValueChanged<double> onChanged,
    required String valueLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
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
                valueLabel,
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
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: context.fitColors.main,
          inactiveColor: context.fitColors.dividerPrimary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// 미리보기 위젯
  Widget _buildPreviewWidget(BuildContext context, String label) {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.fitColors.main,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.fitColors.main.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            label == "Bounce" ? Icons.vertical_align_center : Icons.zoom_out_map,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: context.subtitle5().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  /// 비교 위젯
  Widget _buildComparisonWidget(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: context.fitColors.main,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.animation,
        color: Colors.white,
        size: 32,
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

/// 애니메이션 타입 모델
class _AnimationType {
  final String name;
  final IconData icon;

  const _AnimationType(this.name, this.icon);
}
