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
        title: "TextStyle",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExplanationCard(context),
            _buildStylesSection(
              context: context,
              title: "HeadLine Styles",
              styles: {
                'HeadLine1 (FitTextSp.MIN)': context.h1().copyWith(color: Colors.teal),
                'HeadLine1 (FitTextSp.MAX)': context.h1(type: FitTextSp.MAX).copyWith(color: Colors.teal),
                'HeadLine1 (FitTextSp.SP)': context.h1(type: FitTextSp.SP).copyWith(color: Colors.teal),
                'HeadLine2 (FitTextSp.MIN)': context.h2().copyWith(color: Colors.blueAccent),
                'HeadLine2 (FitTextSp.MAX)': context.h2(type: FitTextSp.MAX).copyWith(color: Colors.blueAccent),
                'HeadLine2 (FitTextSp.SP)': context.h2(type: FitTextSp.SP).copyWith(color: Colors.blueAccent),
              },
            ),
            _buildStylesSection(
              context: context,
              title: "Subtitle Styles",
              styles: {
                'Subtitle1 (FitTextSp.MIN)': context.subtitle1().copyWith(color: Colors.orange),
                'Subtitle1 (FitTextSp.MAX)': context.subtitle1(type: FitTextSp.MAX).copyWith(color: Colors.orange),
                'Subtitle1 (FitTextSp.SP)': context.subtitle1(type: FitTextSp.SP).copyWith(color: Colors.orange),
                'Subtitle2 (FitTextSp.MIN)': context.subtitle2().copyWith(color: Colors.purple),
                'Subtitle2 (FitTextSp.MAX)': context.subtitle2(type: FitTextSp.MAX).copyWith(color: Colors.purple),
                'Subtitle2 (FitTextSp.SP)': context.subtitle2(type: FitTextSp.SP).copyWith(color: Colors.purple),
                'Subtitle3 (FitTextSp.MIN)': context.subtitle3().copyWith(color: Colors.green),
                'Subtitle3 (FitTextSp.MAX)': context.subtitle3(type: FitTextSp.MAX).copyWith(color: Colors.green),
                'Subtitle3 (FitTextSp.SP)': context.subtitle3(type: FitTextSp.SP).copyWith(color: Colors.green),
                'Subtitle4 (FitTextSp.MIN)': context.subtitle4().copyWith(color: Colors.lightGreen),
                'Subtitle4 (FitTextSp.MAX)': context.subtitle4(type: FitTextSp.MAX).copyWith(color: Colors.lightGreen),
                'Subtitle4 (FitTextSp.SP)': context.subtitle4(type: FitTextSp.SP).copyWith(color: Colors.lightGreen),
                'Subtitle5 (FitTextSp.MIN)': context.subtitle5().copyWith(color: Colors.red),
                'Subtitle5 (FitTextSp.MAX)': context.subtitle5(type: FitTextSp.MAX).copyWith(color: Colors.red),
                'Subtitle5 (FitTextSp.SP)': context.subtitle5(type: FitTextSp.SP).copyWith(color: Colors.red),
                'Subtitle6 (FitTextSp.MIN)': context.subtitle6().copyWith(color: Colors.purpleAccent),
                'Subtitle6 (FitTextSp.MAX)':
                    context.subtitle6(type: FitTextSp.MAX).copyWith(color: Colors.purpleAccent),
                'Subtitle6 (FitTextSp.SP)': context.subtitle6(type: FitTextSp.SP).copyWith(color: Colors.purpleAccent),
              },
            ),
            _buildStylesSection(
              context: context,
              title: "Body Styles",
              styles: {
                'Body1 (FitTextSp.MIN)': context.body1().copyWith(color: Colors.teal),
                'Body1 (FitTextSp.MAX)': context.body1(type: FitTextSp.MAX).copyWith(color: Colors.teal),
                'Body1 (FitTextSp.SP)': context.body1(type: FitTextSp.SP).copyWith(color: Colors.teal),
                'Body2 (FitTextSp.MIN)': context.body2().copyWith(color: Colors.lightBlue),
                'Body2 (FitTextSp.MAX)': context.body2(type: FitTextSp.MAX).copyWith(color: Colors.lightBlue),
                'Body2 (FitTextSp.SP)': context.body2(type: FitTextSp.SP).copyWith(color: Colors.lightBlue),
                'Body3 (FitTextSp.MIN)': context.body3().copyWith(color: Colors.lightGreen),
                'Body3 (FitTextSp.MAX)': context.body3(type: FitTextSp.MAX).copyWith(color: Colors.lightGreen),
                'Body3 (FitTextSp.SP)': context.body3(type: FitTextSp.SP).copyWith(color: Colors.lightGreen),
                'Body4 (FitTextSp.MIN)': context.body4().copyWith(color: Colors.greenAccent),
                'Body4 (FitTextSp.MAX)': context.body4(type: FitTextSp.MAX).copyWith(color: Colors.greenAccent),
                'Body4 (FitTextSp.SP)': context.body4(type: FitTextSp.SP).copyWith(color: Colors.greenAccent),
              },
            ),
            _buildStylesSection(
              context: context,
              title: "Caption Styles",
              styles: {
                'Caption1 (FitTextSp.MIN)': context.caption1().copyWith(color: Colors.pink),
                'Caption1 (FitTextSp.MAX)': context.caption1(type: FitTextSp.MAX).copyWith(color: Colors.pink),
                'Caption1 (FitTextSp.SP)': context.caption1(type: FitTextSp.SP).copyWith(color: Colors.pink),
              },
            ),
            _buildStylesSection(
              context: context,
              title: "Custom Font Style",
              styles: {
                'NeoDGM (FitTextSp.MIN)': context.neodgm(fontSize: 24, color: context.fitColors.grey100),
                'NeoDGM (FitTextSp.SP)':
                    context.neodgm(fontSize: 24, color: context.fitColors.grey100, type: FitTextSp.SP),
              },
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
          style: context.body1().copyWith(color: context.fitColors.grey100),
        ),
      ),
    );
  }

  Widget _buildStylesSection({
    required BuildContext context,
    required String title,
    required Map<String, TextStyle> styles,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.text_fields, color: context.fitColors.main, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: context.h2().copyWith(color: context.fitColors.grey100),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: styles.entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.key,
                              style: entry.value,
                            ),
                          ),
                          Icon(Icons.check_circle, color: Colors.teal),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
