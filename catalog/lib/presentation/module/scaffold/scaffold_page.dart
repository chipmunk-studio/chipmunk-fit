import 'package:chip_assets/gen/assets.gen.dart';
import 'package:chipfit/component/button/fit_switch_button.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_bottomsheet.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

/// ScaffoldPage - FitScaffold와 FitAppBar 테스트 페이지
///
/// 실제 전체 화면으로 Scaffold 기능을 테스트
class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  // Test scenarios
  int _currentScenario = 0;
  final List<String> _scenarios = [
    'Leading AppBar',
    'Basic AppBar',
    'Empty AppBar',
    'Extended AppBar',
    'Loading States',
    'Bottom Elements',
    'SafeArea Test',
  ];

  // ScrollController for scenario chips
  final ScrollController _scenarioScrollController = ScrollController();

  // FitLeadingAppBar options
  String _leadingTitle = 'Leading AppBar';
  bool _leadingCenterTitle = false;
  bool _leadingLeftAlign = true;
  bool _leadingHasActions = false;
  bool _leadingCustomIcon = false;

  // FitBasicAppBar options
  String _basicTitle = 'Main Screen';
  bool _basicCenterTitle = false;
  bool _basicHasActions = false;

  // FitEmptyAppBar options
  bool _emptyCustomColors = false;

  // FitExtendedAppBar options
  String _extendedTitle = 'Extended AppBar';
  bool _extendedCenterTitle = false;
  bool _extendedLeftAlign = true;
  bool _extendedHasActions = false;
  Color? _extendedBackgroundColor;

  // Loading options
  bool _isLoading = false;
  bool _customLoadingWidget = false;

  // Bottom elements
  bool _hasBottomSheet = false;
  bool _hasBottomNavBar = false;
  bool _hasFAB = false;
  int _fabLocationIndex = 0;

  // Bottom Sheet configuration
  int _bottomSheetTypeIndex = 0; // 0: Basic, 1: Full, 2: Draggable
  bool _bottomSheetShowTopBar = true;
  bool _bottomSheetShowCloseButton = false;
  bool _bottomSheetIsDismissible = true;

  // SafeArea
  bool _safeAreaTop = true;
  bool _safeAreaBottom = true;

  // Drawer
  bool _hasDrawer = false;
  bool _hasEndDrawer = false;

  @override
  void dispose() {
    _scenarioScrollController.dispose();
    super.dispose();
  }

  void _scrollToScenario(int index) {
    // 다음 프레임에서 스크롤 실행 (렌더링 후)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scenarioScrollController.hasClients) return;

      // 각 chip의 실제 너비를 계산 (텍스트 길이에 따라 다름)
      final chipWidths = _scenarios.map((scenario) {
        // 대략적인 너비 계산: 텍스트 길이 * 8 + padding 32
        return (scenario.length * 8.0) + 32.0 + 8.0; // 8px spacing
      }).toList();

      // 선택된 chip까지의 총 너비 계산
      double totalWidth = 0;
      for (int i = 0; i < index; i++) {
        totalWidth += chipWidths[i];
      }

      // 선택된 chip의 중앙 위치 계산
      final selectedChipWidth = chipWidths[index];
      final selectedChipCenter = totalWidth + (selectedChipWidth / 2);

      // 화면 중앙으로 스크롤
      final screenWidth = MediaQuery.of(context).size.width;
      final targetOffset = selectedChipCenter - (screenWidth / 2);

      _scenarioScrollController.animateTo(
        targetOffset.clamp(0.0, _scenarioScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentScenario,
      children: [
        _buildLeadingAppBarScenario(context),
        _buildBasicAppBarScenario(context),
        _buildEmptyAppBarScenario(context),
        _buildExtendedAppBarScenario(context),
        _buildLoadingScenario(context),
        _buildBottomElementsScenario(context),
        _buildSafeAreaScenario(context),
      ],
    );
  }

  /// Leading AppBar 시나리오
  Widget _buildLeadingAppBarScenario(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: _leadingTitle,
        centerTitle: _leadingCenterTitle,
        leftAlignTitle: _leadingLeftAlign,
        leadingIcon: _leadingCustomIcon
            ? Icon(Icons.close, color: context.fitColors.grey900)
            : null,
        onLeadingPressed: () => Navigator.of(context).pop(),
        actions: _leadingHasActions
            ? [
                IconButton(
                  icon: Icon(Icons.settings, color: context.fitColors.grey900),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: context.fitColors.grey900),
                  onPressed: () {},
                ),
              ]
            : null,
      ),
      body: _buildControlPanel(
        context,
        'Leading AppBar',
        [
          _buildTextField(
            context,
            'Title',
            _leadingTitle,
            (value) => setState(() => _leadingTitle = value),
          ),
          const SizedBox(height: 16),
          _buildSwitch(
            context,
            'Center Title',
            _leadingCenterTitle,
            (value) => setState(() => _leadingCenterTitle = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Left Align Title',
            _leadingLeftAlign,
            (value) => setState(() => _leadingLeftAlign = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Custom Icon (Close)',
            _leadingCustomIcon,
            (value) => setState(() => _leadingCustomIcon = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Show Actions',
            _leadingHasActions,
            (value) => setState(() => _leadingHasActions = value),
          ),
        ],
      ),
    );
  }

  /// Basic AppBar 시나리오
  Widget _buildBasicAppBarScenario(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitBasicAppBar(
        title: _basicTitle,
        centerTitle: _basicCenterTitle,
        actions: _basicHasActions
            ? [
                IconButton(
                  icon: Icon(Icons.search, color: context.fitColors.grey900),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none, color: context.fitColors.grey900),
                  onPressed: () {},
                ),
              ]
            : null,
      ),
      body: _buildControlPanel(
        context,
        'Basic AppBar',
        [
          Row(
            children: [
              Expanded(
                child: _buildBackButton(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            'Title',
            _basicTitle,
            (value) => setState(() => _basicTitle = value),
          ),
          const SizedBox(height: 16),
          _buildSwitch(
            context,
            'Center Title',
            _basicCenterTitle,
            (value) => setState(() => _basicCenterTitle = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Show Actions',
            _basicHasActions,
            (value) => setState(() => _basicHasActions = value),
          ),
          const SizedBox(height: 16),
          _buildInfoBox(
            context,
            'Basic AppBar는 자동 뒤로가기 버튼이 없습니다. 메인 화면에 적합합니다.',
          ),
        ],
      ),
    );
  }

  /// Empty AppBar 시나리오
  Widget _buildEmptyAppBarScenario(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: _emptyCustomColors
          ? FitEmptyAppBar.custom(
              statusBarColor: context.fitColors.main,
              systemNavigationBarColor: context.fitColors.red500,
              backgroundColor: context.fitColors.backgroundAlternative,
            )
          : FitEmptyAppBar(context.fitColors.backgroundAlternative),
      body: _buildControlPanel(
        context,
        'Empty AppBar',
        [
          Row(
            children: [
              Expanded(
                child: _buildBackButton(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoBox(
            context,
            'Empty AppBar는 높이 0으로 보이지 않지만, Android에서 상태바와 네비게이션바 색상을 제어합니다.',
          ),
          const SizedBox(height: 16),
          _buildSwitch(
            context,
            'Custom Colors',
            _emptyCustomColors,
            (value) => setState(() => _emptyCustomColors = value),
          ),
          if (_emptyCustomColors) ...[
            const SizedBox(height: 16),
            _buildColorInfo(context, 'Status Bar', context.fitColors.main),
            const SizedBox(height: 8),
            _buildColorInfo(context, 'Navigation Bar', context.fitColors.red500),
            const SizedBox(height: 8),
            _buildColorInfo(context, 'Background', context.fitColors.backgroundAlternative),
          ] else ...[
            const SizedBox(height: 16),
            _buildColorInfo(context, 'All Same Color', context.fitColors.backgroundAlternative),
          ],
        ],
      ),
    );
  }

  /// Extended AppBar 시나리오
  Widget _buildExtendedAppBarScenario(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // MediaQuery padding을 제거하여 상태바 영역부터 시작
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding: EdgeInsets.zero,
        viewPadding: EdgeInsets.zero,
      ),
      child: Material(
        color: _extendedBackgroundColor ?? context.fitColors.main,
        child: Column(
          children: [
            // Extended AppBar (상태바 영역 포함)
            Container(
              color: _extendedBackgroundColor ?? context.fitColors.main,
              child: Column(
                children: [
                  SizedBox(height: statusBarHeight),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        if (_extendedCenterTitle) const Spacer(),
                        if (_extendedTitle.isNotEmpty)
                          Expanded(
                            child: Text(
                              _extendedTitle,
                              style: context.subtitle2().copyWith(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: _extendedCenterTitle ? TextAlign.center : TextAlign.left,
                            ),
                          ),
                        if (_extendedCenterTitle) const Spacer(),
                        if (_extendedHasActions) ...[
                          IconButton(
                            icon: const Icon(Icons.settings, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: Container(
                color: context.fitColors.backgroundAlternative,
                child: _buildControlPanel(
                  context,
                  'Extended AppBar',
        [
          _buildInfoBox(
            context,
            'Extended AppBar는 iOS처럼 상태바 영역까지 배경색이 확장됩니다. 실제 컨텐츠(아이콘, 타이틀)는 SafeArea 안쪽에 배치됩니다.',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            'Title',
            _extendedTitle,
            (value) => setState(() => _extendedTitle = value),
          ),
          const SizedBox(height: 16),
          _buildSwitch(
            context,
            'Center Title',
            _extendedCenterTitle,
            (value) => setState(() => _extendedCenterTitle = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Left Align Title',
            _extendedLeftAlign,
            (value) => setState(() => _extendedLeftAlign = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Show Actions',
            _extendedHasActions,
            (value) => setState(() => _extendedHasActions = value),
          ),
          const SizedBox(height: 20),
          Text(
            'Background Colors',
            style: context.subtitle5().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColorChip(context, 'Main', context.fitColors.main, _extendedBackgroundColor == null || _extendedBackgroundColor == context.fitColors.main),
              _buildColorChip(context, 'Periwinkle', context.fitColors.periwinkle500, _extendedBackgroundColor == context.fitColors.periwinkle500),
              _buildColorChip(context, 'Red', context.fitColors.red500, _extendedBackgroundColor == context.fitColors.red500),
              _buildColorChip(context, 'Green', context.fitColors.green500, _extendedBackgroundColor == context.fitColors.green500),
              _buildColorChip(context, 'Grey', context.fitColors.grey700, _extendedBackgroundColor == context.fitColors.grey700),
            ],
          ),
        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Loading 시나리오
  Widget _buildLoadingScenario(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: 'Loading States',
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          // 컨트롤 패널 (항상 표시)
          _buildControlPanel(
            context,
            'Loading States',
            [
              _buildSwitch(
                context,
                'Show Loading',
                _isLoading,
                (value) => setState(() => _isLoading = value),
              ),
              const SizedBox(height: 12),
              _buildSwitch(
                context,
                'Custom Loading Widget',
                _customLoadingWidget,
                (value) => setState(() => _customLoadingWidget = value),
              ),
              const SizedBox(height: 16),
              _buildInfoBox(
                context,
                '로딩을 활성화하면 컨텐츠 영역 위에 로딩 오버레이가 표시됩니다. 컨트롤은 항상 접근 가능합니다.',
              ),
              const SizedBox(height: 24),
              // 로딩 프리뷰 영역
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: context.fitColors.grey100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.fitColors.grey300,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Content Area',
                        style: context.body2().copyWith(
                              color: context.fitColors.grey500,
                            ),
                      ),
                    ),
                    // 로딩 오버레이
                    if (_isLoading)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Center(
                          child: _customLoadingWidget
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: context.fitColors.red500,
                                      strokeWidth: 3,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Custom Loading...',
                                      style: context.subtitle5().copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                )
                              : CircularProgressIndicator(
                                  color: context.fitColors.main,
                                ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Bottom Elements 시나리오
  Widget _buildBottomElementsScenario(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: 'Bottom Elements',
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      drawer: _hasDrawer ? _buildDrawer(context, 'Drawer') : null,
      endDrawer: _hasEndDrawer ? _buildDrawer(context, 'End Drawer') : null,
      bottomNavigationBar: _hasBottomNavBar
          ? BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: context.fitColors.main,
              unselectedItemColor: context.fitColors.grey400,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            )
          : null,
      floatingActionButton: _hasFAB
          ? FloatingActionButton(
              backgroundColor: context.fitColors.main,
              onPressed: () {},
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: _getFABLocation(),
      body: _buildControlPanel(
        context,
        'Bottom Elements',
        [
          Text(
            'Drawers',
            style: context.subtitle5().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Drawer (Left)',
            _hasDrawer,
            (value) => setState(() => _hasDrawer = value),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'End Drawer (Right)',
            _hasEndDrawer,
            (value) => setState(() => _hasEndDrawer = value),
          ),
          const SizedBox(height: 20),
          Text(
            'FitBottomSheet',
            style: context.subtitle5().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 12),
          _buildInfoBox(
            context,
            'FitBottomSheet provides three types: Basic (simple content), Full (full-screen scrollable), and Draggable (resizable with snap points).',
          ),
          const SizedBox(height: 12),
          // Bottom Sheet Type Selection
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(context, 'Basic', _bottomSheetTypeIndex == 0, () => setState(() => _bottomSheetTypeIndex = 0)),
              _buildChip(context, 'Full', _bottomSheetTypeIndex == 1, () => setState(() => _bottomSheetTypeIndex = 1)),
              _buildChip(context, 'Draggable', _bottomSheetTypeIndex == 2, () => setState(() => _bottomSheetTypeIndex = 2)),
            ],
          ),
          const SizedBox(height: 12),
          // Bottom Sheet Options
          _buildSwitch(
            context,
            'Show Top Bar',
            _bottomSheetShowTopBar,
            (value) => setState(() => _bottomSheetShowTopBar = value),
          ),
          const SizedBox(height: 8),
          _buildSwitch(
            context,
            'Show Close Button',
            _bottomSheetShowCloseButton,
            (value) => setState(() => _bottomSheetShowCloseButton = value),
          ),
          const SizedBox(height: 8),
          _buildSwitch(
            context,
            'Is Dismissible',
            _bottomSheetIsDismissible,
            (value) => setState(() => _bottomSheetIsDismissible = value),
          ),
          const SizedBox(height: 12),
          // Show Bottom Sheet Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showFitBottomSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.fitColors.main,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Show ${['Basic', 'Full', 'Draggable'][_bottomSheetTypeIndex]} Bottom Sheet',
                style: context.body2().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Other Bottom Elements',
            style: context.subtitle5().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Bottom Navigation Bar',
            _hasBottomNavBar,
            (value) => setState(() => _hasBottomNavBar = value),
          ),
          const SizedBox(height: 20),
          Text(
            'Floating Action Button',
            style: context.subtitle5().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 12),
          _buildSwitch(
            context,
            'Show FAB',
            _hasFAB,
            (value) => setState(() => _hasFAB = value),
          ),
          if (_hasFAB) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip(context, 'End Docked', _fabLocationIndex == 0, () => setState(() => _fabLocationIndex = 0)),
                _buildChip(context, 'Center Docked', _fabLocationIndex == 1, () => setState(() => _fabLocationIndex = 1)),
                _buildChip(context, 'End Float', _fabLocationIndex == 2, () => setState(() => _fabLocationIndex = 2)),
                _buildChip(context, 'Center Float', _fabLocationIndex == 3, () => setState(() => _fabLocationIndex = 3)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// SafeArea 시나리오
  Widget _buildSafeAreaScenario(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return FitScaffold(
      padding: EdgeInsets.zero,
      removeAppBar: true, // AppBar 제거하여 SafeArea 효과 확인
      top: _safeAreaTop,
      bottom: _safeAreaBottom,
      body: Column(
        children: [
          // Top status bar indicator (상태바 영역 표시)
          Container(
            height: _safeAreaTop ? 0 : statusBarHeight,
            color: context.fitColors.red500.withOpacity(0.5),
            child: _safeAreaTop
                ? null
                : Center(
                    child: Text(
                      'Status Bar Area',
                      style: context.caption1().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
          ),

          // Custom AppBar (for navigation)
          Container(
            height: 56,
            color: context.fitColors.backgroundAlternative,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                IconButton(
                  icon: ChipAssets.icons.icArrowLeft.svg(
                    color: context.fitColors.grey900,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'SafeArea Test',
                  style: context.subtitle2().copyWith(
                        color: context.fitColors.grey900,
                      ),
                ),
              ],
            ),
          ),

          // Top content indicator
          Container(
            height: 80,
            color: context.fitColors.main.withOpacity(0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SafeArea Top: $_safeAreaTop',
                    style: context.body2().copyWith(
                          color: context.fitColors.grey900,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (!_safeAreaTop)
                    Text(
                      '위에 빨간 영역이 상태바 영역입니다',
                      style: context.caption1().copyWith(
                            color: context.fitColors.grey600,
                          ),
                    ),
                ],
              ),
            ),
          ),

          // Control panel
          Expanded(
            child: _buildControlPanel(
              context,
              'SafeArea Test',
              [
                _buildInfoBox(
                  context,
                  'AppBar를 제거하여 SafeArea 효과를 확인합니다. Top을 false로 설정하면 빨간색 상태바 영역이 표시됩니다.',
                ),
                const SizedBox(height: 16),
                _buildSwitch(
                  context,
                  'SafeArea Top',
                  _safeAreaTop,
                  (value) => setState(() => _safeAreaTop = value),
                ),
                const SizedBox(height: 12),
                _buildSwitch(
                  context,
                  'SafeArea Bottom',
                  _safeAreaBottom,
                  (value) => setState(() => _safeAreaBottom = value),
                ),
                const SizedBox(height: 16),
                _buildInfoBox(
                  context,
                  'SafeArea를 비활성화하면 콘텐츠가 노치, 상태바, 홈 인디케이터 영역까지 확장됩니다.',
                ),
              ],
            ),
          ),

          // Bottom indicator
          Container(
            height: 80,
            color: context.fitColors.main.withOpacity(0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SafeArea Bottom: $_safeAreaBottom',
                    style: context.body2().copyWith(
                          color: context.fitColors.grey900,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (!_safeAreaBottom)
                    Text(
                      '아래에 초록색 영역이 홈 인디케이터 영역입니다',
                      style: context.caption1().copyWith(
                            color: context.fitColors.grey600,
                          ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom home indicator area (홈 인디케이터 영역 표시)
          Container(
            height: _safeAreaBottom ? 0 : bottomPadding,
            color: context.fitColors.green500.withOpacity(0.5),
            child: _safeAreaBottom
                ? null
                : Center(
                    child: Text(
                      'Home Indicator Area',
                      style: context.caption1().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// 컨트롤 패널 (공통)
  Widget _buildControlPanel(BuildContext context, String title, List<Widget> controls) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Scenario selector
          Container(
            color: context.fitColors.backgroundAlternative,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test Scenario',
                  style: context.caption1().copyWith(
                        color: context.fitColors.grey600,
                      ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scenarioScrollController,
                  child: Row(
                    children: List.generate(
                      _scenarios.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildScenarioChip(context, index),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Controls
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.h2().copyWith(
                        color: context.fitColors.grey900,
                      ),
                ),
                const SizedBox(height: 24),
                ...controls,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 시나리오 칩
  Widget _buildScenarioChip(BuildContext context, int index) {
    final isSelected = _currentScenario == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentScenario = index);
        _scrollToScenario(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? context.fitColors.main : context.fitColors.grey200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _scenarios[index],
          style: context.body2().copyWith(
                color: isSelected ? Colors.white : context.fitColors.grey700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );
  }

  /// TextField
  Widget _buildTextField(BuildContext context, String label, String value, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.subtitle5().copyWith(
                color: context.fitColors.grey900,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          style: context.body2(),
          onChanged: onChanged,
          controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
        ),
      ],
    );
  }

  /// Switch
  Widget _buildSwitch(BuildContext context, String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.body2().copyWith(
                  color: context.fitColors.grey700,
                ),
          ),
        ),
        FitSwitchButton(
          isOn: value,
          onToggle: (_) => onChanged(!value),
          activeColor: context.fitColors.main,
          inactiveColor: context.fitColors.grey300,
          debounceDuration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  /// Info box
  Widget _buildInfoBox(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.fitColors.main.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.fitColors.main.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: context.fitColors.main,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: context.caption1().copyWith(
                    color: context.fitColors.grey700,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Color info
  Widget _buildColorInfo(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.fitColors.grey300,
              width: 1,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: context.body2().copyWith(
                color: context.fitColors.grey700,
              ),
        ),
      ],
    );
  }

  /// Chip
  Widget _buildChip(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? context.fitColors.main : context.fitColors.grey200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: context.caption1().copyWith(
                color: isSelected ? Colors.white : context.fitColors.grey700,
              ),
        ),
      ),
    );
  }

  /// Color chip
  Widget _buildColorChip(BuildContext context, String label, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _extendedBackgroundColor = color),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: context.caption1().copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );
  }

  /// Back button
  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
      label: const Text('Back'),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.fitColors.grey200,
        foregroundColor: context.fitColors.grey900,
      ),
    );
  }

  /// Drawer
  Widget _buildDrawer(BuildContext context, String title) {
    return Drawer(
      child: Container(
        color: context.fitColors.backgroundAlternative,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  title,
                  style: context.h2().copyWith(
                        color: context.fitColors.grey900,
                      ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: context.fitColors.grey700),
                title: Text('Home', style: context.body2()),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: context.fitColors.grey700),
                title: Text('Settings', style: context.body2()),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.help, color: context.fitColors.grey700),
                title: Text('Help', style: context.body2()),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// FAB Location
  FloatingActionButtonLocation _getFABLocation() {
    switch (_fabLocationIndex) {
      case 0:
        return FloatingActionButtonLocation.endDocked;
      case 1:
        return FloatingActionButtonLocation.centerDocked;
      case 2:
        return FloatingActionButtonLocation.endFloat;
      case 3:
        return FloatingActionButtonLocation.centerFloat;
      default:
        return FloatingActionButtonLocation.endDocked;
    }
  }

  /// Show FitBottomSheet
  void _showFitBottomSheet(BuildContext context) {
    final config = FitBottomSheetConfig(
      isShowTopBar: _bottomSheetShowTopBar,
      isShowCloseButton: _bottomSheetShowCloseButton,
      isDismissible: _bottomSheetIsDismissible,
      dismissOnBackKeyPress: _bottomSheetIsDismissible,
    );

    switch (_bottomSheetTypeIndex) {
      case 0: // Basic
        FitBottomSheet.show(
          context,
          config: config,
          content: (bottomSheetContext) => _buildBasicBottomSheetContent(bottomSheetContext),
        );
        break;

      case 1: // Full
        FitBottomSheet.showFull(
          context,
          config: config.copyWith(
            isShowCloseButton: true,
            isShowTopBar: _bottomSheetShowTopBar,
          ),
          topContent: (bottomSheetContext) => _buildFullBottomSheetTopContent(bottomSheetContext),
          scrollContent: (bottomSheetContext) => _buildFullBottomSheetScrollContent(bottomSheetContext),
        );
        break;

      case 2: // Draggable
        FitBottomSheet.showDraggable(
          context,
          config: config.copyWith(
            isShowCloseButton: true,
            isShowTopBar: true,
            heightFactor: 0.5,
            minHeightFactor: 0.2,
            maxHeightFactor: 0.97,
          ),
          topContent: (bottomSheetContext) => _buildDraggableBottomSheetTopContent(bottomSheetContext),
          scrollContent: (bottomSheetContext) => _buildDraggableBottomSheetScrollContent(bottomSheetContext),
          snapSizes: [0.2, 0.5, 0.97],
        );
        break;
    }
  }

  /// Basic Bottom Sheet Content
  Widget _buildBasicBottomSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Bottom Sheet',
            style: context.h2().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'This is a simple bottom sheet with basic content. It can be dismissed by dragging down or tapping outside.',
            style: context.body2().copyWith(
                  color: context.fitColors.grey700,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.fitColors.main,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Close',
                style: context.body2().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Full Bottom Sheet Top Content
  Widget _buildFullBottomSheetTopContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Screen Bottom Sheet',
            style: context.h2().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'This top content stays fixed while the content below scrolls.',
            style: context.body2().copyWith(
                  color: context.fitColors.grey700,
                ),
          ),
        ],
      ),
    );
  }

  /// Full Bottom Sheet Scroll Content
  Widget _buildFullBottomSheetScrollContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 1; i <= 20; i++) ...[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: context.fitColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.list, color: context.fitColors.main),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Scrollable Item $i',
                      style: context.body2().copyWith(
                            color: context.fitColors.grey900,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// Draggable Bottom Sheet Top Content
  Widget _buildDraggableBottomSheetTopContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Draggable Bottom Sheet',
            style: context.h2().copyWith(
                  color: context.fitColors.grey900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag the sheet up and down. It snaps to 20%, 50%, and 97% heights.',
            style: context.body2().copyWith(
                  color: context.fitColors.grey700,
                ),
          ),
        ],
      ),
    );
  }

  /// Draggable Bottom Sheet Scroll Content
  Widget _buildDraggableBottomSheetScrollContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 1; i <= 15; i++) ...[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: context.fitColors.grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.fitColors.grey300,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.fitColors.main.withOpacity(0.2),
                    child: Text(
                      '$i',
                      style: context.body2().copyWith(
                            color: context.fitColors.main,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Draggable Item $i',
                          style: context.body2().copyWith(
                                color: context.fitColors.grey900,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'This sheet can be resized by dragging',
                          style: context.caption1().copyWith(
                                color: context.fitColors.grey600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
