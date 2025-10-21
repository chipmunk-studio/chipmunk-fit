import 'package:chipfit/component/fit_check_box.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({super.key});

  @override
  State<CheckBoxPage> createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  // 상태 관리
  final Map<String, bool> _checkBoxStates = {
    'default': false,
    'hover': false,
    'focus': false,
    'overlay': true,
    'customShape': false,
    'customSize': true,
    'customBorderColor': false,
    'complexCustom': true,
    'activeColor': false,
    'checkColor': true,
    'disabled': false,
  };

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitCheckBox",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: "기본 테스트",
              description: "기본값으로 동작하는 체크박스를 테스트합니다.",
              examples: [
                _buildCheckBox("default", "기본 체크박스"),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "호버 및 포커스 색상 테스트",
              description: "호버 및 포커스 색상이 적용된 체크박스를 테스트합니다.",
              examples: [
                _buildCheckBox(
                  "hover",
                  "호버 색상",
                  hoverColor: Colors.blue.withOpacity(0.5),
                ),
                _buildCheckBox(
                  "focus",
                  "포커스 색상",
                  focusColor: Colors.orange.withOpacity(0.5),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "오버레이 색상 테스트",
              description: "클릭 시 오버레이 색상이 적용된 체크박스를 테스트합니다.",
              examples: [
                _buildCheckBox(
                  "overlay",
                  "오버레이 색상",
                  overlayColor: Colors.green.withOpacity(0.3),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "활성화 및 체크 색상 테스트",
              description: "활성화 색상 및 체크박스 내부 체크 색상을 테스트합니다.",
              examples: [
                _buildCheckBox(
                  "activeColor",
                  "활성화 색상",
                  activeColor: Colors.purple,
                ),
                _buildCheckBox(
                  "checkColor",
                  "체크 색상",
                  checkColor: Colors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "모양 및 크기 테스트",
              description: "체크박스의 크기와 외곽 모양을 커스터마이징하여 테스트합니다.",
              examples: [
                _buildCheckBox(
                  "customShape",
                  "커스텀 모양",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                _buildCheckBox(
                  "customSize",
                  "커스텀 크기",
                  size: 36.0,
                ),
                _buildCheckBox(
                  "customBorderColor",
                  "커스텀 테두리",
                  side: BorderSide(color: Colors.red, width: 2.0),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "복합 커스터마이징 테스트",
              description: "모든 속성을 조합하여 테스트합니다.",
              examples: [
                _buildCheckBox(
                  "complexCustom",
                  "복합 커스터마이징",
                  activeColor: Colors.purple,
                  checkColor: Colors.yellow,
                  hoverColor: Colors.blue.withOpacity(0.5),
                  focusColor: Colors.orange.withOpacity(0.5),
                  overlayColor: Colors.green.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: BorderSide(color: Colors.red, width: 2.0),
                  size: 24.0,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "비활성화 상태 테스트",
              description: "체크박스가 비활성화 상태일 때 동작을 테스트합니다.",
              examples: [
                _buildDisabledCheckBox("disabled", "비활성화 체크박스"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 섹션 구성
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

  /// 섹션 제목 구성
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.check_box, color: context.fitColors.main, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey100),
        ),
      ],
    );
  }

  /// 체크박스 생성
  Widget _buildCheckBox(
    String key,
    String label, {
    Color? hoverColor,
    Color? focusColor,
    Color? overlayColor,
    Color? activeColor,
    Color? checkColor,
    OutlinedBorder? shape,
    BorderSide? side,
    double size = 16.0,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.body1().copyWith(color: context.fitColors.grey400)),
        FitCheckBox(
          state: _checkBoxStates[key]!,
          onCheck: (value) {
            setState(() {
              _checkBoxStates[key] = value;
            });
          },
          hoverColor: hoverColor,
          focusColor: focusColor,
          activeColor: activeColor,
          checkColor: checkColor,
          shape: shape,
          side: side,
          size: size,
        ),
      ],
    );
  }

  /// 비활성화 체크박스 생성
  Widget _buildDisabledCheckBox(String key, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.body1().copyWith(color: context.fitColors.grey400)),
        FitCheckBox(
          state: _checkBoxStates[key]!,
          onCheck: null, // 비활성화 상태
        ),
      ],
    );
  }
}
