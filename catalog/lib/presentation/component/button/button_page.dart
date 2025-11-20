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
  FitButtonType _selectedType = FitButtonType.primary;
  bool _isEnabled = true;
  bool _isLoading = false;
  bool _isExpanded = false;
  bool _enableRipple = false;
  String _buttonText = '버튼';

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitButton",
        actions: [],
      ),
      body: Column(
        children: [
          _buildPreviewSection(context, colors),
          Container(height: 8, color: colors.backgroundAlternative),
          Expanded(child: _buildControlPanel(context, colors)),
        ],
      ),
    );
  }

  Widget _buildButtonText(
    BuildContext context,
    String text, {
    FitButtonType? type,
    bool? isEnabled,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: context.button1().copyWith(
            color: FitButtonStyle.textColorOf(
              context,
              type ?? _selectedType,
              isEnabled: isEnabled ?? _isEnabled,
            ),
          ),
    );
  }

  Widget _buildPreviewSection(BuildContext context, FitColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: colors.backgroundElevated,
      child: Column(
        children: [
          Text(
            '미리보기',
            style: context.caption1().copyWith(color: colors.textTertiary),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(minHeight: 80),
            alignment: Alignment.center,
            child: FitButton(
              type: _selectedType,
              isEnabled: _isEnabled,
              isLoading: _isLoading,
              isExpanded: _isExpanded,
              enableRipple: _enableRipple,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${_selectedType.name} 버튼 클릭됨'),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              onDisabledPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('비활성화된 버튼 클릭됨'),
                    backgroundColor: colors.red500,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: _buildButtonText(context, _buttonText),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.fillAlternative,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Type: ${_selectedType.name}',
              style: context.caption1().copyWith(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, FitColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, colors, '버튼 타입'),
          const SizedBox(height: 12),
          _buildTypeSelector(context, colors),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '옵션'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSwitchOption(
              context,
              colors,
              title: '활성화',
              subtitle: 'isEnabled',
              value: _isEnabled,
              onChanged: (value) => setState(() => _isEnabled = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '로딩',
              subtitle: 'isLoading',
              value: _isLoading,
              onChanged: (value) => setState(() => _isLoading = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '가로 확장',
              subtitle: 'isExpanded',
              value: _isExpanded,
              onChanged: (value) => setState(() => _isExpanded = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '리플 효과',
              subtitle: 'enableRipple',
              value: _enableRipple,
              onChanged: (value) => setState(() => _enableRipple = value),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '버튼 텍스트'),
          const SizedBox(height: 12),
          _buildTextInputCard(context, colors),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '타입별 비교'),
          const SizedBox(height: 12),
          _buildTypeComparisonCard(context, colors),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '상태별 비교'),
          const SizedBox(height: 12),
          _buildStateComparisonCard(context, colors),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, FitColors colors, String title) {
    return Text(
      title,
      style: context.subtitle5().copyWith(color: colors.textSecondary),
    );
  }

  Widget _buildTypeSelector(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.fillAlternative,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: FitButtonType.values.map((type) {
          final isSelected = _selectedType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedType = type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                decoration: BoxDecoration(
                  color:
                      isSelected ? colors.backgroundElevated : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colors.staticBlack.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  _getTypeShortName(type),
                  textAlign: TextAlign.center,
                  style: context.caption1().copyWith(
                        color: isSelected
                            ? colors.textPrimary
                            : colors.textTertiary,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getTypeShortName(FitButtonType type) {
    switch (type) {
      case FitButtonType.primary:
        return 'Pri';
      case FitButtonType.secondary:
        return 'Sec';
      case FitButtonType.tertiary:
        return 'Ter';
      case FitButtonType.ghost:
        return 'Gho';
      case FitButtonType.destructive:
        return 'Des';
    }
  }

  Widget _buildOptionCard(
      BuildContext context, FitColors colors, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchOption(
    BuildContext context,
    FitColors colors, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.body3().copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.caption1().copyWith(color: colors.textTertiary),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: colors.main,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(FitColors colors) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 16),
      color: colors.dividerPrimary,
    );
  }

  Widget _buildTextInputCard(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: TextEditingController(text: _buttonText),
        onChanged: (value) => setState(() => _buttonText = value),
        style: context.body3().copyWith(color: colors.textPrimary),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '버튼 텍스트 입력',
          hintStyle: context.body3().copyWith(color: colors.textTertiary),
        ),
      ),
    );
  }

  Widget _buildTypeComparisonCard(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: FitButtonType.values.map((type) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    type.name,
                    style: context.caption1().copyWith(
                          color: colors.textSecondary,
                        ),
                  ),
                ),
                Expanded(
                  child: FitButton(
                    type: type,
                    isExpanded: true,
                    onPressed: () {},
                    child: _buildButtonText(context, _buttonText, type: type),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStateComparisonCard(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildStateRow(
            context,
            colors,
            '기본',
            FitButton(
              type: _selectedType,
              isExpanded: true,
              onPressed: () {},
              child: _buildButtonText(context, _buttonText),
            ),
          ),
          const SizedBox(height: 12),
          _buildStateRow(
            context,
            colors,
            '비활성화',
            FitButton(
              type: _selectedType,
              isEnabled: false,
              isExpanded: true,
              onPressed: () {},
              child: _buildButtonText(context, _buttonText, isEnabled: false),
            ),
          ),
          const SizedBox(height: 12),
          _buildStateRow(
            context,
            colors,
            '로딩',
            FitButton(
              type: _selectedType,
              isLoading: true,
              isExpanded: true,
              onPressed: () {},
              child: _buildButtonText(context, _buttonText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateRow(
      BuildContext context, FitColors colors, String label, Widget button) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: context.caption1().copyWith(
                  color: colors.textSecondary,
                ),
          ),
        ),
        Expanded(child: button),
      ],
    );
  }
}
