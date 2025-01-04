import 'package:chipfit/component/index.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';


class AnimationText extends StatelessWidget {
  const AnimationText({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "AnimationText 테스트",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildSection(
              context,
              title: "단일 텍스트 애니메이션",
              description: "단일 라인의 텍스트가 애니메이션으로 표시됩니다.",
              examples: [
                FitAnimatedText(
                  text: "안녕하세요! 단일 애니메이션 텍스트입니다.",
                  textStyle: context.h2().copyWith(color: context.fitColors.grey100),
                  duration: const Duration(milliseconds: 100),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "다중 라인 텍스트 애니메이션",
              description: "여러 줄의 텍스트를 애니메이션으로 표시합니다.",
              examples: [
                FitAnimatedText(
                  text: "안녕하세요!\n이 텍스트는 여러 줄로 구성되어 있습니다.",
                  textStyle: context.subtitle3().copyWith(color: context.fitColors.grey100),
                  duration: const Duration(milliseconds: 100),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "애니메이션 완료 콜백",
              description: "애니메이션 완료 시 콜백이 실행됩니다.",
              examples: [
                FitAnimatedText(
                  text: "이 텍스트는 완료 후 콜백을 호출합니다.",
                  textStyle: context.subtitle3().copyWith(color: context.fitColors.primary),
                  duration: const Duration(milliseconds: 100),
                  onAnimationComplete: () {
                    context.showSnackBar("애니메이션 완료!");
                  },
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
        Icon(Icons.text_fields, color: context.fitColors.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey100),
        ),
      ],
    );
  }
}
