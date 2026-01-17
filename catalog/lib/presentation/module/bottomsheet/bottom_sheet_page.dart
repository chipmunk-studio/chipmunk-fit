import 'package:animated_theme_switcher/animated_theme_switcher.dart';
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

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  bool _isShowTopBar = true;
  bool _isShowCloseButton = false;
  bool _isDismissible = true;
  bool _dismissOnBackKeyPress = true;
  double _heightFactor = 0.97;
  double _minHeightFactor = 0.2;
  double _maxHeightFactor = 0.97;

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "FitBottomSheet",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _buildCompactPreview(context, colors),
          Container(height: 1, color: colors.dividerPrimary),
          Expanded(child: _buildControlPanel(context, colors)),
        ],
      ),
    );
  }

  Widget _buildCompactPreview(BuildContext context, FitColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: colors.backgroundElevated,
      child: Row(
        children: [
          Expanded(
            child: FitButton(
              type: FitButtonType.primary,
              isExpanded: true,
              onPressed: () => _showTestBottomSheet(context),
              child: Text(
                '미리보기',
                style: context.button1().copyWith(
                      color: FitButtonStyle.textColorOf(
                        context,
                        FitButtonType.primary,
                        isEnabled: true,
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.fillAlternative,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCompactBadge(colors, 'TopBar', _isShowTopBar),
                const SizedBox(width: 6),
                _buildCompactBadge(colors, 'Close', _isShowCloseButton),
                const SizedBox(width: 6),
                _buildCompactBadge(colors, 'Dismiss', _isDismissible),
                const SizedBox(width: 8),
                Text(
                  '${(_heightFactor * 100).toInt()}%',
                  style: context.caption1().copyWith(
                        color: colors.main,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactBadge(FitColors colors, String label, bool value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: value ? colors.main.withOpacity(0.15) : colors.fillStrong,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: context.caption2().copyWith(
              color: value ? colors.main : colors.textTertiary,
              fontSize: 10,
            ),
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, FitColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, colors, '기본 옵션'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSwitchOption(
              context,
              colors,
              title: '상단 드래그 바',
              subtitle: 'isShowTopBar',
              value: _isShowTopBar,
              onChanged: (value) => setState(() => _isShowTopBar = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '닫기 버튼',
              subtitle: 'isShowCloseButton',
              value: _isShowCloseButton,
              onChanged: (value) => setState(() => _isShowCloseButton = value),
            ),
            _buildDivider(colors),
            _buildSwitchOption(
              context,
              colors,
              title: '외부 터치로 닫기',
              subtitle: 'isDismissible',
              value: _isDismissible,
              onChanged: (value) => setState(() => _isDismissible = value),
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
          _buildSectionHeader(context, colors, '높이 설정'),
          const SizedBox(height: 12),
          _buildOptionCard(context, colors, [
            _buildSliderOption(
              context,
              colors,
              title: '초기 높이',
              subtitle: 'heightFactor',
              value: _heightFactor,
              onChanged: (value) {
                setState(() {
                  _heightFactor = value;
                  if (_minHeightFactor > _heightFactor) {
                    _minHeightFactor = _heightFactor;
                  }
                  if (_maxHeightFactor < _heightFactor) {
                    _maxHeightFactor = _heightFactor;
                  }
                });
              },
            ),
            _buildDivider(colors),
            _buildSliderOption(
              context,
              colors,
              title: '최소 높이',
              subtitle: 'minHeightFactor',
              value: _minHeightFactor,
              onChanged: (value) {
                setState(() {
                  _minHeightFactor = value;
                  if (_heightFactor < _minHeightFactor) {
                    _heightFactor = _minHeightFactor;
                  }
                  if (_maxHeightFactor < _minHeightFactor) {
                    _maxHeightFactor = _minHeightFactor;
                  }
                });
              },
            ),
            _buildDivider(colors),
            _buildSliderOption(
              context,
              colors,
              title: '최대 높이',
              subtitle: 'maxHeightFactor',
              value: _maxHeightFactor,
              onChanged: (value) {
                setState(() {
                  _maxHeightFactor = value;
                  if (_heightFactor > _maxHeightFactor) {
                    _heightFactor = _maxHeightFactor;
                  }
                  if (_minHeightFactor > _maxHeightFactor) {
                    _minHeightFactor = _maxHeightFactor;
                  }
                });
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '프리셋 테스트'),
          const SizedBox(height: 12),
          _buildPresetButtons(context, colors),
          const SizedBox(height: 24),
          _buildSectionHeader(context, colors, '고급 기능'),
          const SizedBox(height: 12),
          _buildAdvancedTests(context, colors),
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

  Widget _buildSliderOption(
    BuildContext context,
    FitColors colors, {
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.body3().copyWith(color: colors.textPrimary),
                  ),
                  Text(
                    subtitle,
                    style: context.caption1().copyWith(color: colors.textTertiary),
                  ),
                ],
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: context.body3().copyWith(color: colors.main),
              ),
            ],
          ),
          Slider(
            value: value,
            onChanged: onChanged,
            activeColor: colors.main,
            inactiveColor: colors.fillStrong,
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
        _buildPresetButton(
          context,
          colors,
          '기본 바텀시트',
          () => _showBasicBottomSheet(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '풀스크린 바텀시트',
          () => _showFullBottomSheet(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '드래그 가능 바텀시트',
          () => _showDraggableBottomSheet(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '50% 바텀시트',
          () => _showHalfBottomSheet(context),
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

  Widget _buildAdvancedTests(BuildContext context, FitColors colors) {
    return Column(
      children: [
        _buildPresetButton(
          context,
          colors,
          '스냅 포인트 테스트',
          () => _showSnapBottomSheet(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '중첩 바텀시트 테스트',
          () => _showNestedBottomSheet(context),
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '긴 콘텐츠 테스트',
          () => _showLongContentBottomSheet(context),
        ),
      ],
    );
  }

  void _showTestBottomSheet(BuildContext context) {
    final config = FitBottomSheetConfig(
      isShowTopBar: _isShowTopBar,
      isShowCloseButton: _isShowCloseButton,
      isDismissible: _isDismissible,
      dismissOnBackKeyPress: _dismissOnBackKeyPress,
      heightFactor: _heightFactor,
      minHeightFactor: _minHeightFactor,
      maxHeightFactor: _maxHeightFactor,
    );

    if (_heightFactor > 0.8) {
      FitBottomSheet.showFull(
        context,
        config: config,
        topContent: (ctx) => _buildSampleTopContent(ctx),
        scrollContent: (ctx) => _buildSampleScrollContent(ctx),
        onClosed: () => _showClosedSnackBar(context),
      );
    } else {
      FitBottomSheet.showDraggable(
        context,
        config: config,
        topContent: (ctx) => _buildSampleTopContent(ctx),
        scrollContent: (ctx) => _buildSampleScrollContent(ctx),
        onClosed: () => _showClosedSnackBar(context),
      );
    }
  }

  void _showBasicBottomSheet(BuildContext context) {
    FitBottomSheet.show(
      context,
      config: const FitBottomSheetConfig(
        isShowTopBar: true,
        isShowCloseButton: false,
      ),
      content: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('기본 바텀시트', style: context.h2()),
            const SizedBox(height: 8),
            Text(
              '간단한 콘텐츠를 표시하는 기본 바텀시트입니다.',
              style: context.body1().copyWith(color: context.fitColors.grey300),
            ),
            const SizedBox(height: 16),
            FitButton(
              onPressed: () => Navigator.pop(ctx),
              isExpanded: true,
              child: Text(
                '닫기',
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
      ),
    );
  }

  void _showFullBottomSheet(BuildContext context) {
    FitBottomSheet.showFull(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        heightFactor: 0.97,
      ),
      topContent: (ctx) => _buildSampleTopContent(ctx),
      scrollContent: (ctx) => _buildSampleScrollContent(ctx, itemCount: 30),
    );
  }

  void _showDraggableBottomSheet(BuildContext context) {
    FitBottomSheet.showDraggable(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        heightFactor: 0.5,
        minHeightFactor: 0.2,
        maxHeightFactor: 0.97,
      ),
      topContent: (ctx) => _buildSampleTopContent(ctx),
      scrollContent: (ctx) => _buildSampleScrollContent(ctx),
    );
  }

  void _showHalfBottomSheet(BuildContext context) {
    FitBottomSheet.showFull(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        isShowTopBar: true,
        heightFactor: 0.5,
      ),
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('50% 바텀시트', style: context.h2()),
      ),
      scrollContent: (ctx) => _buildSampleScrollContent(ctx, itemCount: 10),
    );
  }

  void _showSnapBottomSheet(BuildContext context) {
    FitBottomSheet.showDraggable(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        heightFactor: 0.4,
        minHeightFactor: 0.2,
        maxHeightFactor: 0.97,
      ),
      snapSizes: [0.2, 0.4, 0.7, 0.97],
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('스냅 포인트 테스트', style: context.h2()),
            const SizedBox(height: 8),
            Text(
              '20%, 40%, 70%, 97% 지점에 스냅됩니다',
              style: context.body1().copyWith(color: context.fitColors.grey400),
            ),
          ],
        ),
      ),
      scrollContent: (ctx) => _buildSampleScrollContent(ctx),
    );
  }

  void _showNestedBottomSheet(BuildContext context) {
    FitBottomSheet.show(
      context,
      content: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('첫 번째 바텀시트', style: context.h2()),
            const SizedBox(height: 16),
            FitButton(
              onPressed: () => _showSecondBottomSheet(ctx),
              isExpanded: true,
              child: Text(
                '두 번째 바텀시트 열기',
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
      ),
    );
  }

  void _showSecondBottomSheet(BuildContext context) {
    FitBottomSheet.show(
      context,
      content: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('두 번째 바텀시트', style: context.h2()),
            const SizedBox(height: 16),
            FitButton(
              onPressed: () => Navigator.pop(ctx),
              isExpanded: true,
              type: FitButtonType.secondary,
              child: Text(
                '닫기',
                style: context.button1().copyWith(
                      color: FitButtonStyle.textColorOf(
                        context,
                        FitButtonType.secondary,
                        isEnabled: true,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLongContentBottomSheet(BuildContext context) {
    FitBottomSheet.showFull(
      context,
      config: const FitBottomSheetConfig(
        isShowCloseButton: true,
        heightFactor: 0.97,
      ),
      topContent: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('긴 콘텐츠 테스트', style: context.h2()),
      ),
      scrollContent: (ctx) => _buildSampleScrollContent(ctx, itemCount: 50),
    );
  }

  Widget _buildSampleTopContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('샘플 바텀시트', style: context.h2()),
          const SizedBox(height: 8),
          Text(
            '현재 설정으로 표시된 바텀시트입니다.',
            style: context.body1().copyWith(color: context.fitColors.grey300),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleScrollContent(BuildContext context, {int itemCount = 20}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(Icons.list, color: context.fitColors.main),
                const SizedBox(width: 12),
                Text(
                  '항목 ${index + 1}',
                  style: context.body1().copyWith(color: context.fitColors.grey100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showClosedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('바텀시트가 닫혔습니다'),
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
