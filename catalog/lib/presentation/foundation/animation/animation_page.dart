import 'package:chipfit/component/animation/fit_animation.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 애니메이션 시스템 테스트 페이지
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
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
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "Animation",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildBounceSection(context),
            const SizedBox(height: 16),
            _buildScaleSection(context),
            const SizedBox(height: 16),
            _buildComparisonSection(context),
          ],
        ),
      ),
    );
  }

  /// Linear Bounce 애니메이션 섹션
  Widget _buildBounceSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Linear Bounce Animation",
      icon: Icons.vertical_align_center,
      description: "위아래로 움직이는 반복 애니메이션",
      child: Column(
        children: [
          // 컨트롤
          _buildControlCard(
            context,
            children: [
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
            ],
          ),
          const SizedBox(height: 16),
          // 미리보기
          Center(
            child: FitLinearBounceAnimation(
              duration: _bounceDuration,
              distance: _bounceDistance,
              child: _buildPreviewWidget(context, "Bounce"),
            ),
          ),
        ],
      ),
    );
  }

  /// Scale 애니메이션 섹션
  Widget _buildScaleSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Scale Animation",
      icon: Icons.zoom_out_map,
      description: "크기 변화를 반복하는 애니메이션",
      child: Column(
        children: [
          // 컨트롤
          _buildControlCard(
            context,
            children: [
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
          ),
          const SizedBox(height: 16),
          // 미리보기
          Center(
            child: FitScaleAnimation(
              duration: _scaleDuration,
              scaleBegin: _scaleBegin,
              scaleEnd: _scaleEnd,
              child: _buildPreviewWidget(context, "Scale"),
            ),
          ),
        ],
      ),
    );
  }

  /// 비교 섹션
  Widget _buildComparisonSection(BuildContext context) {
    return _buildSection(
      context,
      title: "Animation Comparison",
      icon: Icons.compare_arrows,
      description: "다양한 설정 비교",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Fast",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              FitLinearBounceAnimation(
                duration: 800,
                distance: 8,
                child: _buildComparisonWidget(context),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Normal",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              FitLinearBounceAnimation(
                duration: 1500,
                distance: 12,
                child: _buildComparisonWidget(context),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Slow",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              FitLinearBounceAnimation(
                duration: 3000,
                distance: 15,
                child: _buildComparisonWidget(context),
              ),
            ],
          ),
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

  /// 컨트롤 카드
  Widget _buildControlCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.fitColors.backgroundBase,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.fitColors.dividerPrimary),
      ),
      child: Column(children: children),
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
}
