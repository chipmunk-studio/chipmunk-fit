import 'dart:math';

import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStylePage extends StatelessWidget {
  const TextStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "TextStyle 테스트",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExplanationCard(context),
            _buildSection(
              context: context,
              title: "HeadLine Styles",
              examples: [
                _TextStyleExample('HeadLine1 (FitTextSp.MIN)', context.headLine1(color: Colors.teal)),
                _TextStyleExample('HeadLine1 (FitTextSp.MAX)', context.headLine1(color: Colors.teal, type: FitTextSp.MAX)),
                _TextStyleExample('HeadLine1 (FitTextSp.SP)', context.headLine1(color: Colors.teal, type: FitTextSp.SP)),
                _TextStyleExample('HeadLine2 (FitTextSp.MIN)', context.headLine2(color: Colors.blueAccent)),
                _TextStyleExample('HeadLine2 (FitTextSp.MAX)', context.headLine2(color: Colors.blueAccent, type: FitTextSp.MAX)),
                _TextStyleExample('HeadLine2 (FitTextSp.SP)', context.headLine2(color: Colors.blueAccent, type: FitTextSp.SP)),
                _TextStyleExample('HeadLine3 (FitTextSp.MIN)', context.headLine3(color: Colors.indigo)),
                _TextStyleExample('HeadLine3 (FitTextSp.MAX)', context.headLine3(color: Colors.indigo, type: FitTextSp.MAX)),
                _TextStyleExample('HeadLine3 (FitTextSp.SP)', context.headLine3(color: Colors.indigo, type: FitTextSp.SP)),
              ],
            ),
            _buildSection(
              context: context,
              title: "Subtitle Styles",
              examples: [
                _TextStyleExample('SubTitle1 Bold (FitTextSp.MIN)', context.subTitle1Bold(color: Colors.orange)),
                _TextStyleExample('SubTitle1 Bold (FitTextSp.MAX)', context.subTitle1Bold(color: Colors.orange, type: FitTextSp.MAX)),
                _TextStyleExample('SubTitle1 Bold (FitTextSp.SP)', context.subTitle1Bold(color: Colors.orange, type: FitTextSp.SP)),
                _TextStyleExample('SubTitle2 SemiBold (FitTextSp.MIN)', context.subTitle2SemiBold(color: Colors.purple)),
                _TextStyleExample('SubTitle2 SemiBold (FitTextSp.MAX)', context.subTitle2SemiBold(color: Colors.purple, type: FitTextSp.MAX)),
                _TextStyleExample('SubTitle2 SemiBold (FitTextSp.SP)', context.subTitle2SemiBold(color: Colors.purple, type: FitTextSp.SP)),
              ],
            ),
            _buildSection(
              context: context,
              title: "Body Styles",
              examples: [
                _TextStyleExample('Body1 SemiBold (FitTextSp.MIN)', context.body1Semibold(color: Colors.green)),
                _TextStyleExample('Body1 SemiBold (FitTextSp.MAX)', context.body1Semibold(color: Colors.green, type: FitTextSp.MAX)),
                _TextStyleExample('Body1 Regular (FitTextSp.MIN)', context.body1Regular(color: Colors.lightGreen)),
                _TextStyleExample('Body1 Regular (FitTextSp.SP)', context.body1Regular(color: Colors.lightGreen, type: FitTextSp.SP)),
              ],
            ),
            _buildSection(
              context: context,
              title: "Caption Styles",
              examples: [
                _TextStyleExample('Caption1 SemiBold (FitTextSp.MIN)', context.caption1SemiBold(color: Colors.pink)),
                _TextStyleExample('Caption1 SemiBold (FitTextSp.SP)', context.caption1SemiBold(color: Colors.pink, type: FitTextSp.SP)),
              ],
            ),
            _buildSection(
              context: context,
              title: "Custom Font Style",
              examples: [
                _TextStyleExample('NeoDGM (FitTextSp.MIN)', context.neodgm(fontSize: 24, color: context.fitColors.grey100)),
                _TextStyleExample('NeoDGM (FitTextSp.SP)', context.neodgm(fontSize: 24, color: context.fitColors.grey100, type: FitTextSp.SP)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanationCard(BuildContext context) {
    final double systemSpValue = 16.sp;
    final double systemSpMinValue = min(16.0, systemSpValue);
    final double systemSpMaxValue = max(16.0, systemSpValue);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '''
FitTextSp.MIN: 기본 sp 값과 화면 크기에 따라 계산된 값을 비교하여 더 작은 값을 선택합니다.
FitTextSp.MAX: 기본 sp 값과 화면 크기에 따라 계산된 값을 비교하여 더 큰 값을 선택합니다.
FitTextSp.SP: 화면 크기에 따라 계산된 sp 값을 그대로 사용합니다.

현재 시스템 기준 값:
- 기본 SP 값: $systemSpValue
- MIN 값: $systemSpMinValue
- MAX 값: $systemSpMaxValue
''',
          style: TextStyle(
            fontSize: 16.sp,
            color: context.fitColors.grey100,
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<_TextStyleExample> examples,
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
            SizedBox(height: 16),
            _buildTextStyleExamples(context, examples: examples),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.text_fields, color: context.fitColors.primary, size: 24),
        SizedBox(width: 8),
        Text(
          title,
          style: context.headLine2(color: context.fitColors.grey100),
        ),
      ],
    );
  }

  Widget _buildTextStyleExamples(BuildContext context, {required List<_TextStyleExample> examples}) {
    return Column(
      children: examples
          .map(
            (example) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  example.label,
                  style: example.style,
                ),
              ),
              Icon(Icons.check_circle, color: Colors.teal),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}

class _TextStyleExample {
  final String label;
  final TextStyle style;

  _TextStyleExample(this.label, this.style);
}
