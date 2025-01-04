import 'package:chipfit/component/animation/index.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

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
            _buildSection(
              context,
              title: "Linear Bounce Animation 테스트",
              description: "위아래로 움직이는 애니메이션",
              examples: [
                FitLinearBounceAnimation(
                  duration: 2000,
                  child: _buildTestWidget(context, "Bounce 2초"),
                ),
                FitLinearBounceAnimation(
                  duration: 1000,
                  child: _buildTestWidget(context, "Bounce 1초"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "Scale Animation 테스트",
              description: "크기 변화를 반복하는 애니메이션",
              examples: [
                FitScaleAnimation(
                  scaleBegin: 1.0,
                  scaleEnd: 1.5,
                  duration: 1500,
                  child: _buildTestWidget(context, "Scale 1.5배"),
                ),
                FitScaleAnimation(
                  scaleBegin: 0.8,
                  scaleEnd: 1.2,
                  duration: 2000,
                  child: _buildTestWidget(context, "Scale 0.8~1.2배"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String description,
    required List<Widget> examples,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title),
            const SizedBox(height: 8),
            Text(
              description,
              style: context.body1().copyWith(color: context.fitColors.grey500),
            ),
            const SizedBox(height: 16),
            Column(children: examples),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.animation, color: context.fitColors.primary, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: context.h2().copyWith(color: context.fitColors.grey100),
          ),
        ),
      ],
    );
  }

  Widget _buildTestWidget(BuildContext context, String label) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.fitColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: context.subtitle3().copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
