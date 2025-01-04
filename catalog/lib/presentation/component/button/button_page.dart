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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildSection(
              context,
              title: "1. Primary 버튼 테스트",
              buttons: [
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
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              title: "2. Secondary 버튼 테스트",
              buttons: [
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
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              title: "3. Tertiary 버튼 테스트",
              buttons: [
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
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              title: "4. Line 버튼 테스트",
              buttons: [
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
              ],
            ),
            SizedBox(height: 16),
            _buildSection(
              context,
              title: "5. 커스텀 스타일 버튼 테스트",
              buttons: [
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> buttons}) {
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
            _buildButtonExample(context, buttons),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.touch_app, color: context.fitColors.grey100, size: 24),
        SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey100),
        ),
      ],
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
