import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chip_core/fit_cache_helper.dart';
import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/component/fit_lottie_widget.dart';
import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Lottie 애니메이션 테스트 페이지
class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> with SingleTickerProviderStateMixin {
  // 설정 상태
  _SourceType _selectedSourceType = _SourceType.network;
  String _networkUrl =
      'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/G.json';
  String _assetPath = 'packages/chip_assets/lottie/loading.lottie';
  double _width = 200.0;
  double _height = 200.0;
  BoxFit _fit = BoxFit.contain;
  bool _repeat = true;
  bool _animate = true;
  bool _useCustomController = false;
  double _customSpeed = 1.0;

  // AnimationController
  late AnimationController _animationController;

  // 캐시 상태
  bool _isCached = false;
  String? _cachedPath;

  // 위젯 재생성 방지용 키 (URL/Asset 변경 시에만 갱신)
  Key _lottieKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _checkCache();
  }

  /// 캐시 상태 확인
  Future<void> _checkCache() async {
    if (_selectedSourceType != _SourceType.network) {
      setState(() {
        _isCached = false;
        _cachedPath = null;
      });
      return;
    }

    final isCached = await FitCacheHelper.isCached(_networkUrl);
    final path = await FitCacheHelper.getCachedFilePath(_networkUrl);

    if (mounted) {
      setState(() {
        _isCached = isCached;
        _cachedPath = path;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitLottieWidget",
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

  /// 미리보기 섹션 (가로 레이아웃)
  Widget _buildPreviewSection(BuildContext context, FitColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: colors.backgroundElevated,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 좌측: Lottie 애니메이션
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  '미리보기',
                  style: context.caption1().copyWith(color: colors.textTertiary),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: colors.fillStrong,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.dividerPrimary),
                  ),
                  child: Center(
                    child: _buildLottieWidget(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // 우측: 상태 정보 & 컨트롤
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상태 정보
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.fillAlternative,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCompactStatusRow(colors, 'Type', _selectedSourceType.name),
                      _buildCompactStatusRow(colors, 'Size', '${_width.toInt()}×${_height.toInt()}'),
                      if (_selectedSourceType == _SourceType.network)
                        _buildCompactStatusRow(
                          colors,
                          'Cache',
                          _isCached ? 'YES ✓' : 'NO',
                          valueColor: _isCached ? colors.main : colors.textTertiary,
                        ),
                    ],
                  ),
                ),

                // 커스텀 컨트롤러 버튼
                if (_useCustomController) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMiniButton(
                          context,
                          colors,
                          _animationController.isAnimating ? '정지' : '재생',
                          () {
                            if (_animationController.isAnimating) {
                              _animationController.stop();
                            } else {
                              _animationController.repeat();
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: _buildMiniButton(
                          context,
                          colors,
                          '리셋',
                          () {
                            _animationController.reset();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatusRow(
    FitColors colors,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.caption1().copyWith(color: colors.textSecondary),
          ),
          Text(
            value,
            style: context.caption1().copyWith(
                  color: valueColor ?? colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniButton(
    BuildContext context,
    FitColors colors,
    String text,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: colors.fillStrong,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: colors.dividerPrimary),
        ),
        child: Center(
          child: Text(
            text,
            style: context.caption1().copyWith(color: colors.textPrimary),
          ),
        ),
      ),
    );
  }

  Widget _buildLottieWidget() {
    final controller = _useCustomController ? _animationController : null;

    if (_useCustomController) {
      _animationController.duration = Duration(milliseconds: (2000 / _customSpeed).toInt());
    }

    // Key를 사용하여 URL/Asset 변경 시에만 위젯 재생성
    // 나머지 옵션 변경은 기존 위젯 유지
    switch (_selectedSourceType) {
      case _SourceType.network:
        return FitLottieWidget.network(
          key: ValueKey('network_$_networkUrl'), // URL 변경 시에만 재생성
          url: _networkUrl,
          width: _width,
          height: _height,
          fit: _fit,
          repeat: _repeat,
          animate: _animate,
          controller: controller,
          placeholder: const CircularProgressIndicator(),
          errorWidget: const Icon(Icons.error, size: 48, color: Colors.red),
        );
      case _SourceType.asset:
        return FitLottieWidget.asset(
          key: ValueKey('asset_$_assetPath'), // Asset 경로 변경 시에만 재생성
          assetPath: _assetPath,
          width: _width,
          height: _height,
          fit: _fit,
          repeat: _repeat,
          animate: _animate,
          controller: controller,
          errorWidget: const Icon(Icons.error, size: 48, color: Colors.red),
        );
      case _SourceType.file:
        return const Center(
          child: Text('파일 로더는 실제 파일 경로가 필요합니다'),
        );
    }
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
          _buildSectionHeader(context, colors, 'Source Type'),
          const SizedBox(height: 12),
          _buildSourceTypeSelector(context, colors),
          const SizedBox(height: 24),

          // Network 전용 섹션
          if (_selectedSourceType == _SourceType.network) ...[
            _buildSectionHeader(context, colors, '🌐 Network 설정'),
            const SizedBox(height: 12),
            _buildNetworkSection(context, colors),
            const SizedBox(height: 24),
          ],

          // Asset 전용 섹션
          if (_selectedSourceType == _SourceType.asset) ...[
            _buildSectionHeader(context, colors, '📦 Asset 설정'),
            const SizedBox(height: 12),
            _buildAssetSection(context, colors),
            const SizedBox(height: 24),
          ],

          // 공통 설정
          _buildSectionHeader(context, colors, '공통 설정'),
          const SizedBox(height: 12),
          _buildCommonSettings(context, colors),
          const SizedBox(height: 24),

          _buildSectionHeader(context, colors, '커스텀 컨트롤러'),
          const SizedBox(height: 12),
          _buildCustomControllerSettings(context, colors),
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

  Widget _buildSourceTypeSelector(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.fillAlternative,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: _SourceType.values.map((type) {
          final isSelected = _selectedSourceType == type;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedSourceType = type);
                _checkCache();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? colors.backgroundElevated : Colors.transparent,
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
                  type.displayName,
                  textAlign: TextAlign.center,
                  style: context.caption1().copyWith(
                        color: isSelected ? colors.textPrimary : colors.textTertiary,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUrlInput(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        children: [
          TextField(
            controller: TextEditingController(text: _networkUrl),
            maxLines: 3,
            style: context.body3().copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Lottie JSON URL 입력',
              hintStyle: context.body3().copyWith(color: colors.textTertiary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (value) {
              setState(() {
                _networkUrl = value;
              });
              _checkCache();
            },
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 16),
            color: colors.dividerPrimary,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '샘플 URL:',
                  style: context.caption1().copyWith(color: colors.textTertiary),
                ),
                const SizedBox(height: 4),
                _buildSampleUrlButton(
                  context,
                  colors,
                  'G Animation',
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/G.json',
                ),
                const SizedBox(height: 4),
                _buildSampleUrlButton(
                  context,
                  colors,
                  'A Animation',
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                ),
                const SizedBox(height: 4),
                _buildSampleUrlButton(
                  context,
                  colors,
                  'Loading',
                  'https://assets2.lottiefiles.com/packages/lf20_h9kds1my.json',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleUrlButton(
    BuildContext context,
    FitColors colors,
    String label,
    String url,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _networkUrl = url;
        });
        _checkCache();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.fillStrong,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.link, size: 16, color: colors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: context.caption1().copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetSelector(BuildContext context, FitColors colors) {
    final assetPaths = [
      'packages/chip_assets/lottie/loading.lottie',
      'packages/chip_assets/lottie/dot_loading.lottie',
      'packages/chip_assets/lottie/gift_box.lottie',
      'packages/chip_assets/lottie/coin_pig.lottie',
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        children: assetPaths.asMap().entries.map((entry) {
          final index = entry.key;
          final path = entry.value;
          final fileName = path.split('/').last;
          final isSelected = _assetPath == path;

          return Column(
            children: [
              if (index > 0)
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 16),
                  color: colors.dividerPrimary,
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _assetPath = path;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: isSelected ? colors.fillStrong : Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        size: 20,
                        color: isSelected ? colors.main : colors.textTertiary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fileName,
                              style: context.body3().copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              path,
                              style: context.caption1().copyWith(
                                    color: colors.textTertiary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSizeSettings(BuildContext context, FitColors colors) {
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
                'Width',
                style: context.body3().copyWith(color: colors.textPrimary),
              ),
              Text(
                '${_width.toInt()}',
                style: context.body3().copyWith(color: colors.main),
              ),
            ],
          ),
          Slider(
            value: _width,
            min: 50,
            max: 400,
            divisions: 70,
            activeColor: colors.main,
            inactiveColor: colors.fillStrong,
            onChanged: (value) {
              setState(() {
                _width = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Height',
                style: context.body3().copyWith(color: colors.textPrimary),
              ),
              Text(
                '${_height.toInt()}',
                style: context.body3().copyWith(color: colors.main),
              ),
            ],
          ),
          Slider(
            value: _height,
            min: 50,
            max: 400,
            divisions: 70,
            activeColor: colors.main,
            inactiveColor: colors.fillStrong,
            onChanged: (value) {
              setState(() {
                _height = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFitSettings(BuildContext context, FitColors colors) {
    final fits = [
      BoxFit.contain,
      BoxFit.cover,
      BoxFit.fill,
      BoxFit.fitWidth,
      BoxFit.fitHeight,
      BoxFit.none,
      BoxFit.scaleDown,
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: fits.map((fit) {
          final isSelected = _fit == fit;
          return GestureDetector(
            onTap: () {
              setState(() {
                _fit = fit;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? colors.main : colors.fillStrong,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                fit.name,
                style: context.body3().copyWith(
                      color: isSelected ? colors.grey0 : colors.textPrimary,
                    ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAnimationOptions(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        children: [
          _buildSwitchOption(
            context,
            colors,
            title: '반복 재생',
            subtitle: 'repeat',
            value: _repeat,
            onChanged: (value) => setState(() => _repeat = value),
          ),
          _buildDivider(colors),
          _buildSwitchOption(
            context,
            colors,
            title: '자동 애니메이션',
            subtitle: 'animate',
            value: _animate,
            onChanged: (value) => setState(() => _animate = value),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomControllerSettings(BuildContext context, FitColors colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.dividerPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 설명 헤더
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.fillStrong,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: colors.main),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '커스텀 컨트롤러로 애니메이션을 직접 제어할 수 있습니다',
                    style: context.caption1().copyWith(color: colors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildSwitchOption(
            context,
            colors,
            title: '커스텀 컨트롤러 사용',
            subtitle: 'AnimationController로 재생/정지/속도 제어',
            value: _useCustomController,
            onChanged: (value) {
              setState(() {
                _useCustomController = value;
                if (value && _animate) {
                  _animationController.repeat();
                } else {
                  _animationController.stop();
                }
              });
            },
          ),
          if (_useCustomController) ...[
            _buildDivider(colors),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '재생 속도',
                        style: context.body3().copyWith(color: colors.textPrimary),
                      ),
                      Text(
                        '${_customSpeed.toStringAsFixed(1)}x',
                        style: context.body3().copyWith(color: colors.main),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'duration을 조절하여 속도 변경',
                    style: context.caption1().copyWith(color: colors.textTertiary),
                  ),
                  Slider(
                    value: _customSpeed,
                    min: 0.1,
                    max: 3.0,
                    divisions: 29,
                    activeColor: colors.main,
                    inactiveColor: colors.fillStrong,
                    onChanged: (value) {
                      setState(() {
                        _customSpeed = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            _buildDivider(colors),
            // 사용 예제 코드
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.fillStrong,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.code, size: 14, color: colors.main),
                      const SizedBox(width: 6),
                      Text(
                        '사용 예제',
                        style: context.caption1().copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'final controller = AnimationController(vsync: this);\n'
                    '\n'
                    'FitLottieWidget.network(\n'
                    '  url: "...",\n'
                    '  controller: controller, // 전달\n'
                    ')\n'
                    '\n'
                    '// 제어\n'
                    'controller.repeat();  // 반복 재생\n'
                    'controller.forward(); // 한번 재생\n'
                    'controller.stop();    // 정지\n'
                    'controller.reverse(); // 역재생',
                    style: context.caption1().copyWith(
                          color: colors.textSecondary,
                          fontFamily: 'monospace',
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
          ],
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

  /// Network 전용 섹션
  Widget _buildNetworkSection(BuildContext context, FitColors colors) {
    return Column(
      children: [
        // URL 입력
        _buildUrlInput(context, colors),
        const SizedBox(height: 16),

        // 샘플 프리셋
        _buildSectionSubHeader(context, colors, '샘플 URL'),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          'G Animation',
          () {
            setState(() {
              _networkUrl = 'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/G.json';
              _width = 200;
              _height = 200;
              _fit = BoxFit.contain;
              _repeat = true;
              _animate = true;
              _useCustomController = false;
            });
            _checkCache();
          },
        ),
        const SizedBox(height: 6),
        _buildPresetButton(
          context,
          colors,
          'A Animation',
          () {
            setState(() {
              _networkUrl = 'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json';
              _width = 200;
              _height = 200;
              _fit = BoxFit.contain;
              _repeat = true;
              _animate = true;
              _useCustomController = false;
            });
            _checkCache();
          },
        ),
        const SizedBox(height: 16),

        // 캐시 테스트
        _buildSectionSubHeader(context, colors, '캐시 관리'),
        const SizedBox(height: 8),
        _buildCacheTestSection(context, colors),
      ],
    );
  }

  /// Asset 전용 섹션
  Widget _buildAssetSection(BuildContext context, FitColors colors) {
    return Column(
      children: [
        // Asset 선택
        _buildAssetSelector(context, colors),
        const SizedBox(height: 16),

        // 샘플 프리셋
        _buildSectionSubHeader(context, colors, '샘플 Assets'),
        const SizedBox(height: 8),
        _buildPresetButton(
          context,
          colors,
          '로딩 애니메이션',
          () {
            setState(() {
              _assetPath = 'packages/chip_assets/lottie/loading.lottie';
              _width = 200;
              _height = 200;
              _fit = BoxFit.contain;
              _repeat = true;
              _animate = true;
              _useCustomController = false;
            });
          },
        ),
        const SizedBox(height: 6),
        _buildPresetButton(
          context,
          colors,
          '선물 상자',
          () {
            setState(() {
              _assetPath = 'packages/chip_assets/lottie/gift_box.lottie';
              _width = 250;
              _height = 250;
              _fit = BoxFit.contain;
              _repeat = false;
              _animate = true;
              _useCustomController = false;
            });
          },
        ),
        const SizedBox(height: 6),
        _buildPresetButton(
          context,
          colors,
          '저금통',
          () {
            setState(() {
              _assetPath = 'packages/chip_assets/lottie/coin_pig.lottie';
              _width = 300;
              _height = 300;
              _fit = BoxFit.contain;
              _repeat = true;
              _animate = true;
              _useCustomController = false;
            });
          },
        ),
        const SizedBox(height: 6),
        _buildPresetButton(
          context,
          colors,
          '점 로딩',
          () {
            setState(() {
              _assetPath = 'packages/chip_assets/lottie/dot_loading.lottie';
              _width = 180;
              _height = 180;
              _fit = BoxFit.contain;
              _repeat = true;
              _animate = true;
              _useCustomController = false;
            });
          },
        ),
      ],
    );
  }

  /// 공통 설정
  Widget _buildCommonSettings(BuildContext context, FitColors colors) {
    return Column(
      children: [
        // 크기 설정
        _buildSizeSettings(context, colors),
        const SizedBox(height: 16),

        // BoxFit 설정
        _buildSectionSubHeader(context, colors, 'BoxFit'),
        const SizedBox(height: 8),
        _buildFitSettings(context, colors),
        const SizedBox(height: 16),

        // 애니메이션 옵션
        _buildSectionSubHeader(context, colors, '애니메이션'),
        const SizedBox(height: 8),
        _buildAnimationOptions(context, colors),
      ],
    );
  }

  Widget _buildSectionSubHeader(BuildContext context, FitColors colors, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: context.body3().copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
      ),
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

  Widget _buildCacheTestSection(BuildContext context, FitColors colors) {
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '캐시 상태',
                      style: context.body3().copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isCached ? '캐시됨 ✓' : '캐시 안됨',
                      style: context.caption1().copyWith(
                            color: _isCached ? colors.main : colors.textTertiary,
                          ),
                    ),
                  ],
                ),
              ),
              FitButton(
                onPressed: () async {
                  await _checkCache();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('캐시 상태: ${_isCached ? "있음" : "없음"}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
                type: FitButtonType.tertiary,
                child: Text(
                  '확인',
                  style: context.button1().copyWith(
                        color: FitButtonStyle.textColorOf(
                          context,
                          FitButtonType.tertiary,
                          isEnabled: true,
                        ),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FitButton(
                  onPressed: () async {
                    // 캐시 삭제만 하고 위젯은 리빌드 안함
                    await FitCacheHelper.removeFromCache(_networkUrl);

                    // 캐시 상태만 업데이트 (setState 안에서)
                    final isCached = await FitCacheHelper.isCached(_networkUrl);
                    final path = await FitCacheHelper.getCachedFilePath(_networkUrl);

                    if (mounted) {
                      setState(() {
                        _isCached = isCached;
                        _cachedPath = path;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('캐시 삭제 완료 (화면 유지)'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  type: FitButtonType.destructive,
                  isExpanded: true,
                  child: Text(
                    '캐시 삭제',
                    style: context.button1().copyWith(
                          color: FitButtonStyle.textColorOf(
                            context,
                            FitButtonType.destructive,
                            isEnabled: true,
                          ),
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FitButton(
                  onPressed: () async {
                    // 전체 캐시 삭제만 하고 위젯은 리빌드 안함
                    await FitCacheHelper.clearAllCaches();

                    // 캐시 상태만 업데이트 (setState 안에서)
                    final isCached = await FitCacheHelper.isCached(_networkUrl);
                    final path = await FitCacheHelper.getCachedFilePath(_networkUrl);

                    if (mounted) {
                      setState(() {
                        _isCached = isCached;
                        _cachedPath = path;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('전체 캐시 삭제 완료 (화면 유지)'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  type: FitButtonType.destructive,
                  isExpanded: true,
                  child: Text(
                    '전체 삭제',
                    style: context.button1().copyWith(
                          color: FitButtonStyle.textColorOf(
                            context,
                            FitButtonType.destructive,
                            isEnabled: true,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
          if (_cachedPath != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.fillStrong,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '캐시 파일 경로',
                    style: context.caption1().copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _cachedPath!,
                    style: context.caption1().copyWith(color: colors.textPrimary),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
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

enum _SourceType {
  network,
  asset,
  file;

  String get displayName {
    switch (this) {
      case _SourceType.network:
        return 'Network';
      case _SourceType.asset:
        return 'Asset';
      case _SourceType.file:
        return 'File';
    }
  }
}
