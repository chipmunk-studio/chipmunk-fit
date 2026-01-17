import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/fit_dialog.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  // 설정 상태
  String _title = '알림';
  String _subTitle = '다이얼로그 내용입니다.';
  bool _dismissOnTouchOutside = false;
  bool _dismissOnBackKeyPress = false;
  bool _showTopContent = false;
  bool _showBottomContent = false;
  bool _showCancelButton = false;
  FitButtonType _okButtonType = FitButtonType.primary;
  FitButtonType _cancelButtonType = FitButtonType.tertiary;

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "FitDialog",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
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
          FitButton(
            type: FitButtonType.primary,
            isExpanded: true,
            onPressed: () => _showTestDialog(context),
            child: Text(
              '현재 설정으로 열기',
              style: context.button1().copyWith(
                    color: FitButtonStyle.textColorOf(
                      context,
                      FitButtonType.primary,
                      isEnabled: true,
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.fillAlternative,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildStatusRow(colors, 'OK Button', _okButtonType.name),
                if (_showCancelButton)
                  _buildStatusRow(colors, 'Cancel Button', _cancelButtonType.name),
                _buildStatusRow(colors, 'Outside Touch', _dismissOnTouchOutside),
                _buildStatusRow(colors, 'Back Key', _dismissOnBackKeyPress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(FitColors colors, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.caption1().copyWith(color: colors.textSecondary),
          ),
          Text(
            value is bool ? (value ? 'ON' : 'OFF') : value.toString(),
            style: context.caption1().copyWith(
                  color: value is bool
                      ? (value ? colors.green500 : colors.grey500)
                      : colors.textPrimary,
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
          _buildSectionHeader(context, colors, '텍스트 입력'),
          const SizedBox(height: 12),
          _buildTextInputCard(context, colors, '제목', _title, (value) {
            setState(() => _title = value);
          }),
          const SizedBox(height: 8),
          _buildTextInputCard(context, colors, '부제목', _subTitle, (value) {
            setState(() => _subTitle = value);
          }),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '버튼 설정'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSwitchOption(
              context,
              colors,
              title: '취소 버튼 표시',
              subtitle: 'showCancelButton',
              value: _showCancelButton,
              onChanged: (value) => setState(() => _showCancelButton = value),
            ),
          ]),
          const SizedBox(height: 12),
          _buildButtonTypeSelector(context, colors, 'OK 버튼 타입', _okButtonType, (type) {
            setState(() => _okButtonType = type);
          }),
          if (_showCancelButton) ...[
            const SizedBox(height: 12),
            _buildButtonTypeSelector(context, colors, 'Cancel 버튼 타입', _cancelButtonType, (type) {
              setState(() => _cancelButtonType = type);
            }),
          ],
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '컨텐츠 옵션'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSwitchOption(
              context,
              colors,
              title: '상단 컨텐츠',
              subtitle: 'topContent (아이콘)',
              value: _showTopContent,
              onChanged: (value) => setState(() => _showTopContent = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '하단 컨텐츠',
              subtitle: 'bottomContent (경고문)',
              value: _showBottomContent,
              onChanged: (value) => setState(() => _showBottomContent = value),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '닫기 옵션'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSwitchOption(
              context,
              colors,
              title: '외부 터치로 닫기',
              subtitle: 'dismissOnTouchOutside',
              value: _dismissOnTouchOutside,
              onChanged: (value) => setState(() => _dismissOnTouchOutside = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '뒤로가기로 닫기',
              subtitle: 'dismissOnBackKeyPress',
              value: _dismissOnBackKeyPress,
              onChanged: (value) => setState(() => _dismissOnBackKeyPress = value),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '프리셋 테스트'),
          const SizedBox(height: 12),
          _buildPresetButtons(context, colors),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '타입별 비교'),
          const SizedBox(height: 12),
          _buildTypeComparisonCard(context, colors),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, FitColors colors, String title) {
    return Text(
      title,
      style: context.subtitle5().copyWith(color: colors.textSecondary),
    );
  }

  Widget _buildTextInputCard(
    BuildContext context,
    FitColors colors,
    String label,
    String value,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.caption1().copyWith(color: colors.textTertiary),
          ),
          TextField(
            controller: TextEditingController(text: value)
              ..selection = TextSelection.collapsed(offset: value.length),
            onChanged: onChanged,
            style: context.body3().copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, FitColors colors, List<Widget> children) {
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

  Widget _buildButtonTypeSelector(
    BuildContext context,
    FitColors colors,
    String label,
    FitButtonType selectedType,
    ValueChanged<FitButtonType> onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.body3().copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FitButtonType.primary,
              FitButtonType.secondary,
              FitButtonType.tertiary,
              FitButtonType.destructive,
            ].map((type) {
              final isSelected = type == selectedType;
              return GestureDetector(
                onTap: () => onChanged(type),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.main : colors.fillAlternative,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type.name,
                    style: context.caption1().copyWith(
                          color: isSelected ? colors.staticBlack : colors.textTertiary,
                        ),
                  ),
                ),
              );
            }).toList(),
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

  Widget _buildPresetButtons(BuildContext context, FitColors colors) {
    return Column(
      children: [
        _buildPresetButton(context, colors, '기본 알림', _showBasicDialog),
        const SizedBox(height: 8),
        _buildPresetButton(context, colors, '확인/취소', _showConfirmDialog),
        const SizedBox(height: 8),
        _buildPresetButton(context, colors, '에러 다이얼로그', _showErrorDialog),
        const SizedBox(height: 8),
        _buildPresetButton(context, colors, '성공 (아이콘)', _showSuccessDialog),
        const SizedBox(height: 8),
        _buildPresetButton(context, colors, '삭제 확인', _showDestructiveDialog),
        const SizedBox(height: 8),
        _buildPresetButton(context, colors, '긴 텍스트', _showLongTextDialog),
      ],
    );
  }

  Widget _buildPresetButton(
    BuildContext context,
    FitColors colors,
    String label,
    VoidCallback onPressed,
  ) {
    return FitButton(
      onPressed: onPressed,
      isExpanded: true,
      type: FitButtonType.secondary,
      child: Text(
        label,
        style: context.button1().copyWith(
              color: FitButtonStyle.textColorOf(
                context,
                FitButtonType.secondary,
                isEnabled: true,
              ),
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
        children: [
          FitButtonType.primary,
          FitButtonType.secondary,
          FitButtonType.tertiary,
          FitButtonType.destructive,
        ].map((type) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FitButton(
              onPressed: () => _showTypeComparisonDialog(context, type),
              isExpanded: true,
              type: FitButtonType.ghost,
              child: Text(
                '${type.name} 타입 보기',
                style: context.button1().copyWith(
                      color: FitButtonStyle.textColorOf(
                        context,
                        FitButtonType.ghost,
                        isEnabled: true,
                      ),
                    ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 현재 설정으로 다이얼로그 표시
  void _showTestDialog(BuildContext context) {
    FitDialog.showFitDialog(
      context: context,
      title: _title,
      subTitle: _subTitle,
      dismissOnTouchOutside: _dismissOnTouchOutside,
      dismissOnBackKeyPress: _dismissOnBackKeyPress,
      topContent: _showTopContent
          ? Container(
              padding: const EdgeInsets.only(top: 20, bottom: 12),
              child: Icon(
                Icons.info_outline,
                size: 60,
                color: context.fitColors.main,
              ),
            )
          : null,
      bottomContent: _showBottomContent
          ? Container(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                '* 이 작업은 되돌릴 수 없습니다.',
                style: context.caption1().copyWith(
                      color: context.fitColors.red500,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          : null,
      btnOkText: '확인',
      btnOkPressed: () => _showResultSnackBar(context, '확인 클릭'),
      btnCancelText: _showCancelButton ? '취소' : null,
      btnCancelPressed: _showCancelButton ? () => _showResultSnackBar(context, '취소 클릭') : null,
      okButtonType: _okButtonType,
      cancelButtonType: _cancelButtonType,
      onDismiss: () => _showResultSnackBar(context, '다이얼로그 닫힘'),
    );
  }

  // 프리셋 다이얼로그들
  void _showBasicDialog() {
    FitDialog.showFitDialog(
      context: context,
      title: '알림',
      subTitle: '이것은 기본 다이얼로그입니다.',
      btnOkText: '확인',
      btnOkPressed: () {},
    );
  }

  void _showConfirmDialog() {
    FitDialog.showFitDialog(
      context: context,
      title: '확인 필요',
      subTitle: '이 작업을 계속하시겠습니까?',
      btnOkText: '확인',
      btnOkPressed: () => _showResultSnackBar(context, '확인됨'),
      btnCancelText: '취소',
      btnCancelPressed: () => _showResultSnackBar(context, '취소됨'),
    );
  }

  void _showErrorDialog() {
    FitDialog.showErrorDialog(
      context: context,
      message: '에러 발생',
      description: '작업을 수행하는 중 오류가 발생했습니다.',
      onPress: () => _showResultSnackBar(context, '에러 확인'),
    );
  }

  void _showSuccessDialog() {
    FitDialog.showFitDialog(
      context: context,
      title: '성공',
      subTitle: '작업이 성공적으로 완료되었습니다.',
      topContent: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 12),
        child: Icon(
          Icons.check_circle,
          size: 60,
          color: context.fitColors.green500,
        ),
      ),
      btnOkText: '확인',
      btnOkPressed: () {},
    );
  }

  void _showDestructiveDialog() {
    FitDialog.showFitDialog(
      context: context,
      title: '삭제',
      subTitle: '정말 삭제하시겠습니까?',
      bottomContent: Container(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          '* 삭제된 데이터는 복구할 수 없습니다.',
          style: context.caption1().copyWith(
                color: context.fitColors.red500,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      okButtonType: FitButtonType.destructive,
      btnOkText: '삭제',
      btnOkPressed: () => _showResultSnackBar(context, '삭제됨'),
      btnCancelText: '취소',
      btnCancelPressed: () {},
    );
  }

  void _showLongTextDialog() {
    FitDialog.showFitDialog(
      context: context,
      title: '이용약관',
      subTitle: '본 약관은 회사가 제공하는 서비스의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다. '
          '이용자는 본 약관에 동의함으로써 서비스를 이용할 수 있습니다. '
          '약관의 내용은 회사의 사정에 따라 변경될 수 있으며, 변경 시 공지사항을 통해 안내됩니다.',
      btnOkText: '동의',
      btnOkPressed: () => _showResultSnackBar(context, '약관 동의'),
      btnCancelText: '취소',
      btnCancelPressed: () {},
    );
  }

  void _showTypeComparisonDialog(BuildContext context, FitButtonType type) {
    FitDialog.showFitDialog(
      context: context,
      title: '${type.name} 타입',
      subTitle: '이 다이얼로그는 ${type.name} 버튼을 사용합니다.',
      okButtonType: type,
      btnOkText: '확인',
      btnOkPressed: () {},
      btnCancelText: '취소',
      btnCancelPressed: () {},
    );
  }

  void _showResultSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return GestureDetector(
          onTap: () {
            final theme = isDark ? fitLightTheme(context) : fitDarkTheme(context);
            ThemeSwitcher.of(context).changeTheme(theme: theme);
          },
          child: Icon(
            isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
            color: context.fitColors.textPrimary,
            size: 24,
          ),
        );
      },
    );
  }
}
