import 'package:chipfit/component/index.dart';
import 'package:chipfit/foundation/index.dart';
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
    'checked': true,
    'unchecked': false,
    'disabledChecked': true,
    'disabledUnchecked': false,
    'custom1': false,
    'custom2': true,
    'group1': false,
    'group2': true,
    'group3': false,
  };

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitCheckBox 테스트",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: "기본 체크박스",
              description: "기본 스타일의 체크박스를 테스트합니다.",
              examples: [
                _buildCheckBox("default", "기본 체크박스"),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "다양한 상태 테스트",
              description: "체크박스의 다양한 상태를 테스트합니다.",
              examples: [
                _buildCheckBox("checked", "체크된 상태"),
                _buildCheckBox("unchecked", "해제된 상태"),
                _buildDisabledCheckBox("disabledChecked", "비활성화 (체크됨)"),
                _buildDisabledCheckBox("disabledUnchecked", "비활성화 (체크 안됨)"),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "커스텀 스타일 테스트",
              description: "체크박스에 커스텀 스타일을 적용하여 테스트합니다.",
              examples: [
                _buildCheckBox("custom1", "커스텀 스타일 1", customColor: Colors.blue),
                _buildCheckBox("custom2", "커스텀 스타일 2", customColor: Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "그룹 체크박스 테스트",
              description: "체크박스를 그룹으로 묶어서 선택을 테스트합니다.",
              examples: _buildGroupedCheckBoxes(),
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
              style: context.body1Regular(color: context.fitColors.grey500),
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
        Icon(Icons.check_box, color: context.fitColors.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.headLine2(color: context.fitColors.grey100),
        ),
      ],
    );
  }

  /// 기본 체크박스 생성
  Widget _buildCheckBox(String key, String label, {Color? customColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.body1Regular(color: context.fitColors.grey400)),
        FitCheckBox(
          state: _checkBoxStates[key]!,
          onCheck: (value) {
            setState(() {
              _checkBoxStates[key] = value;
            });
          },
          color: customColor,
        ),
      ],
    );
  }

  /// 비활성화 체크박스 생성
  Widget _buildDisabledCheckBox(String key, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.body1Regular(color: context.fitColors.grey400)),
        FitCheckBox(
          state: _checkBoxStates[key]!,
          onCheck: null,
          color: context.fitColors.grey700,
        ),
      ],
    );
  }

  /// 그룹 체크박스 생성
  List<Widget> _buildGroupedCheckBoxes() {
    return [
      _buildCheckBox("group1", "그룹 항목 1"),
      const SizedBox(height: 8),
      _buildCheckBox("group2", "그룹 항목 2"),
      const SizedBox(height: 8),
      _buildCheckBox("group3", "그룹 항목 3"),
    ];
  }
}
