import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_component/button/fit_animated_bottom_button.dart';
import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/bottomsheet/fit_bottom_sheet.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FitAnimatedBottomButton 테스트 페이지
///
/// 키보드 반응형 버튼과 바텀시트 내 TextField 동작을 테스트합니다.
class AnimatedBottomButtonPage extends StatefulWidget {
  const AnimatedBottomButtonPage({super.key});

  @override
  State<AnimatedBottomButtonPage> createState() => _AnimatedBottomButtonPageState();
}

class _AnimatedBottomButtonPageState extends State<AnimatedBottomButtonPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isEnabled = true;
  bool _isLoading = false;
  bool _useSafeArea = true;
  FitButtonType _buttonType = FitButtonType.primary;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      resizeToAvoidBottomInset: true,
      appBar: FitLeadingAppBar(
        title: "FitAnimatedBottomButton",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, colors),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, colors, '기본 옵션'),
                  const SizedBox(height: 12),
                  _buildOptionCard(context, colors),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, colors, '버튼 타입'),
                  const SizedBox(height: 12),
                  _buildTypeSelector(context, colors),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, colors, '키보드 테스트'),
                  const SizedBox(height: 12),
                  _buildKeyboardTestSection(context, colors),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, colors, '바텀시트 테스트'),
                  const SizedBox(height: 12),
                  _buildBottomSheetTestSection(context, colors),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          FitAnimatedBottomButton(
            type: _buttonType,
            isEnabled: _isEnabled,
            isLoading: _isLoading,
            useSafeArea: _useSafeArea,
            onPressed: () => _showSnackBar(context, '버튼 클릭됨!'),
            child: Text(
              '확인',
              style: context.button1().copyWith(
                    color: FitButtonStyle.textColorOf(
                      context,
                      _buttonType,
                      isEnabled: _isEnabled,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, FitColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.main.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.main.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: colors.main, size: 20),
              const SizedBox(width: 8),
              Text(
                '키보드 반응형 버튼',
                style: context.subtitle5().copyWith(color: colors.main),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '키보드가 나타나면 버튼의 radius와 padding이 자동으로 애니메이션됩니다. '
            'WidgetsBindingObserver를 사용하여 외부 패키지 없이 키보드 상태를 감지합니다.',
            style: context.body3().copyWith(color: colors.textSecondary),
          ),
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

  Widget _buildOptionCard(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        children: [
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
            title: '로딩 상태',
            subtitle: 'isLoading',
            value: _isLoading,
            onChanged: (value) => setState(() => _isLoading = value),
          ),
          _buildDivider(colors),
          _buildSwitchOption(
            context,
            colors,
            title: 'SafeArea 사용',
            subtitle: 'useSafeArea',
            value: _useSafeArea,
            onChanged: (value) => setState(() => _useSafeArea = value),
          ),
        ],
      ),
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
            activeTrackColor: colors.main,
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

  Widget _buildTypeSelector(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: FitButtonType.values.map((type) {
          final isSelected = type == _buttonType;
          return GestureDetector(
            onTap: () => setState(() => _buttonType = type),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? colors.main : colors.fillAlternative,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                type.name,
                style: context.caption1().copyWith(
                      color: isSelected ? Colors.white : colors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKeyboardTestSection(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '아래 텍스트 필드를 탭하여 키보드를 열어보세요',
            style: context.body3().copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: '텍스트를 입력하세요...',
              hintStyle: context.body2().copyWith(color: colors.textTertiary),
              filled: true,
              fillColor: colors.fillAlternative,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: context.body2().copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 12),
          Text(
            '키보드가 올라오면 하단 버튼의 radius가 0으로, padding이 최소화됩니다.',
            style: context.caption1().copyWith(color: colors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetTestSection(BuildContext context, FitColors colors) {
    return Column(
      children: [
        _buildPresetButton(
          context,
          colors,
          '기본 바텀시트 + TextField',
          () => _showBottomSheetWithTextField(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '풀스크린 바텀시트 + TextField',
          () => _showFullBottomSheetWithTextField(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '드래그 바텀시트 + TextField',
          () => _showDraggableBottomSheetWithTextField(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '다중 TextField 바텀시트',
          () => _showMultipleTextFieldBottomSheet(context),
        ),
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

  void _showBottomSheetWithTextField(BuildContext context) {
    final controller = TextEditingController();

    FitBottomSheet.show(
      context,
      config: const FitBottomSheetConfig(
        isShowTopBar: true,
        isShowCloseButton: false,
      ),
      content: (ctx) => _BottomSheetContent(
        title: '기본 바텀시트',
        description: '텍스트 필드에 포커스하면 바텀시트가 키보드 위로 올라옵니다.',
        controller: controller,
        onSubmit: () {
          Navigator.pop(ctx);
          _showSnackBar(context, '입력값: ${controller.text}');
        },
      ),
    );
  }

  void _showFullBottomSheetWithTextField(BuildContext context) {
    final controller = TextEditingController();

    FitBottomSheet.showFull(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        isShowTopBar: false,
        heightFactor: 0.97,
      ),
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 60, 0),
        child: Text('풀스크린 바텀시트', style: context.h2()),
      ),
      scrollContent: (ctx) => _FullBottomSheetContent(
        controller: controller,
        onSubmit: () {
          Navigator.pop(ctx);
          _showSnackBar(context, '입력값: ${controller.text}');
        },
      ),
    );
  }

  void _showDraggableBottomSheetWithTextField(BuildContext context) {
    final controller = TextEditingController();

    FitBottomSheet.showDraggable(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        heightFactor: 0.5,
        minHeightFactor: 0.3,
        maxHeightFactor: 0.97,
      ),
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 60, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('드래그 바텀시트', style: context.h2()),
            const SizedBox(height: 4),
            Text(
              '드래그하여 높이를 조절할 수 있습니다',
              style: context.body3().copyWith(color: context.fitColors.textSecondary),
            ),
          ],
        ),
      ),
      scrollContent: (ctx) => _FullBottomSheetContent(
        controller: controller,
        onSubmit: () {
          Navigator.pop(ctx);
          _showSnackBar(context, '입력값: ${controller.text}');
        },
      ),
    );
  }

  void _showMultipleTextFieldBottomSheet(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    FitBottomSheet.showFull(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        isShowTopBar: false,
        heightFactor: 0.97,
      ),
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 60, 0),
        child: Text('다중 TextField 테스트', style: context.h2()),
      ),
      scrollContent: (ctx) => _MultipleTextFieldContent(
        nameController: nameController,
        emailController: emailController,
        messageController: messageController,
        onSubmit: () {
          Navigator.pop(ctx);
          _showSnackBar(
            context,
            '이름: ${nameController.text}, 이메일: ${emailController.text}',
          );
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
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

/// 기본 바텀시트 내용
class _BottomSheetContent extends StatelessWidget {
  final String title;
  final String description;
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const _BottomSheetContent({
    required this.title,
    required this.description,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.h2()),
              const SizedBox(height: 8),
              Text(
                description,
                style: context.body3().copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: '입력하세요...',
                  hintStyle: context.body2().copyWith(color: colors.textTertiary),
                  filled: true,
                  fillColor: colors.fillAlternative,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                style: context.body2().copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FitAnimatedBottomButton(
          useSafeArea: false,
          onPressed: onSubmit,
          backgroundColor: context.fitColors.backgroundBase,
          child: Text(
            '확인',
            style: context.button1().copyWith(
                  color: FitButtonStyle.textColorOf(
                    context,
                    FitButtonType.primary,
                    isEnabled: true,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

/// 풀스크린 바텀시트 내용
class _FullBottomSheetContent extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const _FullBottomSheetContent({
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '키보드가 나타나면 바텀시트가 자동으로 위로 올라갑니다.',
            style: context.body3().copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            autofocus: false,
            decoration: InputDecoration(
              hintText: '텍스트를 입력하세요...',
              hintStyle: context.body2().copyWith(color: colors.textTertiary),
              filled: true,
              fillColor: colors.fillAlternative,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: context.body2().copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.main.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: colors.main, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'isScrollControlled: true로 설정되어 키보드에 반응합니다',
                    style: context.caption1().copyWith(color: colors.main),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FitButton(
            isExpanded: true,
            onPressed: onSubmit,
            child: Text(
              '확인',
              style: context.button1().copyWith(
                    color: FitButtonStyle.textColorOf(
                      context,
                      FitButtonType.primary,
                      isEnabled: true,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 다중 TextField 바텀시트 내용
class _MultipleTextFieldContent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final VoidCallback onSubmit;

  const _MultipleTextFieldContent({
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '여러 개의 텍스트 필드 간 이동 시 키보드 반응을 테스트합니다.',
            style: context.body3().copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            context,
            controller: nameController,
            label: '이름',
            hint: '이름을 입력하세요',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            controller: emailController,
            label: '이메일',
            hint: '이메일을 입력하세요',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            controller: messageController,
            label: '메시지',
            hint: '메시지를 입력하세요',
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          FitButton(
            isExpanded: true,
            onPressed: onSubmit,
            child: Text(
              '제출',
              style: context.button1().copyWith(
                    color: FitButtonStyle.textColorOf(
                      context,
                      FitButtonType.primary,
                      isEnabled: true,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final colors = context.fitColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.subtitle6().copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.body2().copyWith(color: colors.textTertiary),
            filled: true,
            fillColor: colors.fillAlternative,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          style: context.body2().copyWith(color: colors.textPrimary),
        ),
      ],
    );
  }
}
