import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/component/index.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitButton",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Primary 버튼 섹션
            _buildSectionTitle(context, "1. Primary 버튼 테스트"),
            _buildButtonExample(context, [
              FitButton(
                type: FitButtonType.primary,
                text: '기본 Primary 버튼',
                onPress: () => print('Primary 버튼 클릭됨'),
              ),
              FitButton(
                type: FitButtonType.primary,
                isEnabled: false,
                text: '비활성화 Primary 버튼',
                onDisablePress: () => context.showSnackBar('Primary 버튼 비활성 클릭'),
              ),
              FitButton(
                type: FitButtonType.primary,
                isExpand: true,
                text: '확장 Primary 버튼',
                onPress: () => print('확장 Primary 버튼 클릭됨'),
              ),
            ]),

            // 2. Secondary 버튼 섹션
            _buildSectionTitle(context, "2. Secondary 버튼 테스트"),
            _buildButtonExample(context, [
              FitButton(
                type: FitButtonType.secondary,
                text: '기본 Secondary 버튼',
                onPress: () => print('Secondary 버튼 클릭됨'),
              ),
              FitButton(
                type: FitButtonType.secondary,
                isEnabled: false,
                text: '비활성화 Secondary 버튼',
                onDisablePress: () => context.showSnackBar('Secondary 버튼 비활성 클릭'),
              ),
            ]),

            // 3. Tertiary 버튼 섹션
            _buildSectionTitle(context, "3. Tertiary 버튼 테스트"),
            _buildButtonExample(context, [
              FitButton(
                type: FitButtonType.tertiary,
                text: '기본 Tertiary 버튼',
                onPress: () => print('Tertiary 버튼 클릭됨'),
              ),
              FitButton(
                type: FitButtonType.tertiary,
                isEnabled: false,
                text: '비활성화 Tertiary 버튼',
                onDisablePress: () => context.showSnackBar('Tertiary 버튼 비활성 클릭'),
              ),
            ]),

            // 4. Line 버튼 섹션
            _buildSectionTitle(context, "4. Line 버튼 테스트"),
            _buildButtonExample(context, [
              FitButton(
                type: FitButtonType.line,
                text: '기본 Line 버튼',
                onPress: () => print('Line 버튼 클릭됨'),
              ),
              FitButton(
                type: FitButtonType.line,
                isEnabled: false,
                text: '비활성화 Line 버튼',
                onDisablePress: () => context.showSnackBar('Line 버튼 비활성 클릭'),
              ),
            ]),

            // 5. 커스텀 스타일 버튼 섹션
            _buildSectionTitle(context, "5. 커스텀 스타일 버튼 테스트"),
            _buildButtonExample(context, [
              FitButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                text: '커스텀 스타일',
                onPress: () => print('커스텀 스타일 버튼 클릭됨'),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: context.body1Regular(color: context.fitColors.white),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildButtonExample(BuildContext context, List<Widget> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var button in buttons) ...[
          button,
          const SizedBox(height: 12), // 버튼 간 간격 추가
        ]
      ],
    );
  }
}
