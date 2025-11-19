import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  bool _isLoading4 = false;
  bool _isLoading5 = false;

  void _toggleLoading(int index) {
    setState(() {
      switch (index) {
        case 1:
          _isLoading1 = !_isLoading1;
          break;
        case 2:
          _isLoading2 = !_isLoading2;
          break;
        case 3:
          _isLoading3 = !_isLoading3;
          break;
        case 4:
          _isLoading4 = !_isLoading4;
          break;
        case 5:
          _isLoading5 = !_isLoading5;
          break;
      }
    });
  }

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
                  onPressed: () => print('Primary 버튼 클릭됨'),
                ),
                FitButton(
                  type: FitButtonType.primary,
                  isEnabled: false,
                  text: '비활성화 Primary 버튼',
                  onDisabledPressed: () {},
                ),
                FitButton(
                  type: FitButtonType.primary,
                  isExpanded: true,
                  text: '확장 Primary 버튼',
                  onPressed: () => print('확장 Primary 버튼 클릭됨'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "2. Secondary 버튼 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.secondary,
                  text: '기본 Secondary 버튼',
                  onPressed: () => print('Secondary 버튼 클릭됨'),
                ),
                FitButton(
                  type: FitButtonType.secondary,
                  isEnabled: false,
                  text: '비활성화 Secondary 버튼',
                  onDisabledPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "3. Tertiary 버튼 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.tertiary,
                  text: '기본 Tertiary 버튼',
                  onPressed: () => print('Tertiary 버튼 클릭됨'),
                ),
                FitButton(
                  type: FitButtonType.tertiary,
                  isEnabled: false,
                  text: '비활성화 Tertiary 버튼',
                  onDisabledPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "4. Ghost 버튼 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.ghost,
                  text: '기본 Ghost 버튼',
                  onPressed: () => print('Ghost 버튼 클릭됨'),
                ),
                FitButton(
                  type: FitButtonType.ghost,
                  isEnabled: false,
                  text: '비활성화 Ghost 버튼',
                  onDisabledPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "5. Destructive 버튼 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.destructive,
                  text: '기본 Destructive 버튼',
                  onPressed: () => print('Destructive 버튼 클릭됨'),
                ),
                FitButton(
                  type: FitButtonType.destructive,
                  isEnabled: false,
                  text: '비활성화 Destructive 버튼',
                  onDisabledPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "6. 커스텀 스타일 버튼 테스트",
              buttons: [
                FitButton(
                  style: FitButtonStyle.styleFrom(
                    backgroundColor: Colors.orange,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  text: '커스텀 스타일',
                  onPressed: () => print('커스텀 스타일 버튼 클릭됨'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "7. 로딩 상태 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.primary,
                  text: 'Primary 로딩',
                  isLoading: _isLoading1,
                  onPressed: () => _toggleLoading(1),
                  isExpanded: true,
                ),
                FitButton(
                  type: FitButtonType.secondary,
                  text: 'Secondary 로딩',
                  isLoading: _isLoading2,
                  onPressed: () => _toggleLoading(2),
                  isExpanded: true,
                ),
                FitButton(
                  type: FitButtonType.tertiary,
                  text: 'Tertiary 로딩',
                  isLoading: _isLoading3,
                  onPressed: () => _toggleLoading(3),
                  isExpanded: true,
                ),
                FitButton(
                  type: FitButtonType.ghost,
                  text: 'Ghost 로딩',
                  isLoading: _isLoading4,
                  onPressed: () => _toggleLoading(4),
                  isExpanded: true,
                ),
                FitButton(
                  type: FitButtonType.destructive,
                  text: 'Destructive 로딩',
                  isLoading: _isLoading5,
                  onPressed: () => _toggleLoading(5),
                  isExpanded: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "8. 커스텀 로딩 색상 테스트",
              buttons: [
                FitButton(
                  type: FitButtonType.primary,
                  text: '빨간 로딩',
                  isLoading: true,
                  loadingColor: Colors.red,
                  isExpanded: true,
                  onPressed: () {},
                ),
                FitButton(
                  type: FitButtonType.secondary,
                  text: '녹색 로딩',
                  isLoading: true,
                  loadingColor: Colors.green,
                  isExpanded: true,
                  onPressed: () {},
                ),
                FitButton(
                  type: FitButtonType.ghost,
                  text: '파란 로딩',
                  isLoading: true,
                  loadingColor: Colors.blue,
                  isExpanded: true,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> buttons}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title),
            const SizedBox(height: 16),
            _buildButtonExample(context, buttons),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.touch_app, color: context.fitColors.grey900, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey900),
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
          const SizedBox(height: 12),
        ]
      ],
    );
  }
}
