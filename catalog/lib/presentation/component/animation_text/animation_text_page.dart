import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/component/fit_animated_text.dart';
import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 애니메이션 텍스트 테스트 페이지
class AnimationTextPage extends StatefulWidget {
  const AnimationTextPage({super.key});

  @override
  State<AnimationTextPage> createState() => _AnimationTextPageState();
}

class _AnimationTextPageState extends State<AnimationTextPage> {
  // 설정 상태
  String _sampleText = "안녕하세요! 애니메이션 텍스트입니다.";
  double _speed = 50.0; // 밀리초
  FitTextAnimationType _animationType = FitTextAnimationType.fade;
  Curve _curve = Curves.easeOutCubic;
  bool _autoStart = true;
  double _startDelay = 0.0; // 밀리초

  // 애니메이션 컨트롤을 위한 GlobalKey
  final GlobalKey<FitAnimatedTextState> _animationKey = GlobalKey();

  // 완료 카운터
  int _completionCount = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitAnimatedText",
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

  /// 미리보기 섹션
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

          // 애니메이션 텍스트 표시 영역
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.fillStrong,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.dividerPrimary),
            ),
            child: FitAnimatedText(
              key: _animationKey,
              text: _sampleText,
              textStyle: context.h2().copyWith(color: colors.textPrimary),
              duration: Duration(milliseconds: _speed.toInt()),
              animationType: _animationType,
              curve: _curve,
              autoStart: _autoStart,
              startDelay: Duration(milliseconds: _startDelay.toInt()),
              onAnimationComplete: () {
                setState(() {
                  _completionCount++;
                });
              },
            ),
          ),

          const SizedBox(height: 16),

          // 컨트롤 버튼
          Row(
            children: [
              Expanded(
                child: FitButton(
                  onPressed: () {
                    _animationKey.currentState?.restart();
                  },
                  type: FitButtonType.primary,
                  isExpanded: true,
                  child: Text(
                    '재시작',
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
              const SizedBox(width: 8),
              Expanded(
                child: FitButton(
                  onPressed: () {
                    _animationKey.currentState?.stop();
                  },
                  type: FitButtonType.secondary,
                  isExpanded: true,
                  child: Text(
                    '정지',
                    style: context.button1().copyWith(
                          color: FitButtonStyle.textColorOf(
                            context,
                            FitButtonType.secondary,
                            isEnabled: true,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 상태 정보
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.fillAlternative,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildStatusRow(colors, '완료 횟수', '$_completionCount회'),
                _buildStatusRow(colors, '속도', '${_speed.toInt()}ms'),
                _buildStatusRow(colors, '애니메이션', _getAnimationTypeName(_animationType)),
                _buildStatusRow(colors, '커브', _getCurveName(_curve)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(FitColors colors, String label, String value) {
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
            value,
            style: context.caption1().copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }

  /// 컨트롤 패널
  Widget _buildControlPanel(BuildContext context, FitColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, colors, '텍스트 입력'),
          const SizedBox(height: 12),
          _buildTextInput(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '애니메이션 설정'),
          const SizedBox(height: 12),
          _buildAnimationSettings(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '속도 설정'),
          const SizedBox(height: 12),
          _buildSpeedSettings(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '커브 설정'),
          const SizedBox(height: 12),
          _buildCurveSettings(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '고급 설정'),
          const SizedBox(height: 12),
          _buildAdvancedSettings(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '프리셋'),
          const SizedBox(height: 12),
          _buildPresets(context, colors),
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

  Widget _buildTextInput(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: TextField(
        controller: TextEditingController(text: _sampleText),
        maxLines: 3,
        style: context.body2().copyWith(color: colors.textPrimary),
        decoration: InputDecoration(
          hintText: '테스트할 텍스트를 입력하세요',
          hintStyle: context.body2().copyWith(color: colors.textTertiary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: (value) {
          setState(() {
            _sampleText = value;
          });
        },
      ),
    );
  }

  Widget _buildAnimationSettings(BuildContext context, FitColors colors) {
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
            '애니메이션 타입',
            style: context.body3().copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: FitTextAnimationType.values.map((type) {
              final isSelected = _animationType == type;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _animationType = type;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.main : colors.fillStrong,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getAnimationTypeName(type),
                    style: context.body3().copyWith(
                          color: isSelected ? colors.grey0 : colors.textPrimary,
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

  Widget _buildSpeedSettings(BuildContext context, FitColors colors) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '글자당 간격',
                style: context.body3().copyWith(color: colors.textPrimary),
              ),
              Text(
                '${_speed.toInt()}ms',
                style: context.body3().copyWith(color: colors.main),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: _speed,
            min: 10,
            max: 200,
            divisions: 38,
            activeColor: colors.main,
            inactiveColor: colors.fillStrong,
            onChanged: (value) {
              setState(() {
                _speed = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('빠름 (10ms)', style: context.caption1().copyWith(color: colors.textTertiary)),
              Text('느림 (200ms)', style: context.caption1().copyWith(color: colors.textTertiary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurveSettings(BuildContext context, FitColors colors) {
    final curves = {
      'easeOutCubic': Curves.easeOutCubic,
      'linear': Curves.linear,
      'easeIn': Curves.easeIn,
      'easeOut': Curves.easeOut,
      'easeInOut': Curves.easeInOut,
      'bounceOut': Curves.bounceOut,
      'elasticOut': Curves.elasticOut,
    };

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
            '애니메이션 커브',
            style: context.body3().copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: curves.entries.map((entry) {
              final isSelected = _curve == entry.value;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _curve = entry.value;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.main : colors.fillStrong,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    entry.key,
                    style: context.body3().copyWith(
                          color: isSelected ? colors.grey0 : colors.textPrimary,
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

  Widget _buildAdvancedSettings(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '자동 시작',
                        style: context.body3().copyWith(color: colors.textPrimary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'autoStart',
                        style: context.caption1().copyWith(color: colors.textTertiary),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _autoStart,
                  onChanged: (value) {
                    setState(() {
                      _autoStart = value;
                    });
                  },
                  activeColor: colors.main,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 16),
            color: colors.dividerPrimary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '시작 지연',
                      style: context.body3().copyWith(color: colors.textPrimary),
                    ),
                    Text(
                      '${_startDelay.toInt()}ms',
                      style: context.body3().copyWith(color: colors.main),
                    ),
                  ],
                ),
                Slider(
                  value: _startDelay,
                  min: 0,
                  max: 2000,
                  divisions: 40,
                  activeColor: colors.main,
                  inactiveColor: colors.fillStrong,
                  onChanged: (value) {
                    setState(() {
                      _startDelay = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresets(BuildContext context, FitColors colors) {
    return Column(
      children: [
        _buildPresetButton(
          context,
          colors,
          '기본 타이핑',
          () {
            setState(() {
              _sampleText = "안녕하세요! 기본 타이핑 효과입니다.";
              _speed = 50.0;
              _animationType = FitTextAnimationType.none;
              _curve = Curves.linear;
              _autoStart = true;
              _startDelay = 0.0;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '부드러운 페이드',
          () {
            setState(() {
              _sampleText = "부드럽게 나타나는 텍스트";
              _speed = 60.0;
              _animationType = FitTextAnimationType.fade;
              _curve = Curves.easeOutCubic;
              _autoStart = true;
              _startDelay = 0.0;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '슬라이드 업',
          () {
            setState(() {
              _sampleText = "아래에서 위로 올라오는 텍스트";
              _speed = 70.0;
              _animationType = FitTextAnimationType.slideUp;
              _curve = Curves.easeOut;
              _autoStart = true;
              _startDelay = 0.0;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '통통 튀는 효과',
          () {
            setState(() {
              _sampleText = "통통! 튀는 텍스트!";
              _speed = 80.0;
              _animationType = FitTextAnimationType.bounce;
              _curve = Curves.elasticOut;
              _autoStart = true;
              _startDelay = 0.0;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '느린 스케일',
          () {
            setState(() {
              _sampleText = "천천히 커지는 텍스트";
              _speed = 100.0;
              _animationType = FitTextAnimationType.scale;
              _curve = Curves.easeInOut;
              _autoStart = true;
              _startDelay = 500.0;
            });
          },
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

  String _getAnimationTypeName(FitTextAnimationType type) {
    switch (type) {
      case FitTextAnimationType.fade:
        return '페이드';
      case FitTextAnimationType.slideUp:
        return '슬라이드업';
      case FitTextAnimationType.scale:
        return '스케일';
      case FitTextAnimationType.bounce:
        return '바운스';
      case FitTextAnimationType.none:
        return '없음';
    }
  }

  String _getCurveName(Curve curve) {
    if (curve == Curves.easeOutCubic) return 'easeOutCubic';
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.easeIn) return 'easeIn';
    if (curve == Curves.easeOut) return 'easeOut';
    if (curve == Curves.easeInOut) return 'easeInOut';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.elasticOut) return 'elasticOut';
    return 'custom';
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
