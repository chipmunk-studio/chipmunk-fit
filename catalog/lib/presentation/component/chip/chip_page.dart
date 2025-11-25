import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:chipfit/component/fit_chip.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FitChip 테스트 페이지
class ChipPage extends StatefulWidget {
  const ChipPage({super.key});

  @override
  State<ChipPage> createState() => _ChipPageState();
}

class _ChipPageState extends State<ChipPage> {
  // Choice chips 상태
  String? _selectedSize = 'M';

  // Filter chips 상태
  final Set<String> _selectedFilters = {'전체'};

  // Input chips 상태
  final List<String> _tags = ['디자인', 'Flutter', 'iOS'];

  // 섹션 확장 상태
  final Map<String, bool> _expandedSections = {
    'basic': true,
    'choice': true,
    'filter': true,
    'input': true,
    'action': true,
    'avatar': true,
    'states': true,
  };

  // 스크롤 컨트롤러
  final ScrollController _scrollController = ScrollController();

  // 가로 스크롤 컨트롤러들
  final ScrollController _choiceScrollController = ScrollController();
  final ScrollController _filterScrollController = ScrollController();

  // 각 섹션의 GlobalKey
  final Map<String, GlobalKey> _sectionKeys = {
    'basic': GlobalKey(),
    'choice': GlobalKey(),
    'filter': GlobalKey(),
    'input': GlobalKey(),
    'action': GlobalKey(),
    'avatar': GlobalKey(),
    'states': GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    _choiceScrollController.dispose();
    _filterScrollController.dispose();
    super.dispose();
  }

  /// Choice 칩 중앙 스크롤
  void _scrollToSelectedChoice(List<String> sizes) {
    if (_selectedSize == null) return;
    final index = sizes.indexOf(_selectedSize!);
    if (index == -1) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_choiceScrollController.hasClients) {
        // 각 칩의 실제 너비를 계산
        final chipWidth = 56.0 + 8.0; // 칩 최소너비 + padding
        final screenWidth = MediaQuery.of(context).size.width;

        // 선택된 칩을 정확히 화면 중앙에 배치
        final targetOffset = (index * chipWidth) - (screenWidth / 2) + (chipWidth / 2);
        final maxScroll = _choiceScrollController.position.maxScrollExtent;
        final clampedOffset = targetOffset.clamp(0.0, maxScroll);

        _choiceScrollController.animateTo(
          clampedOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Filter 칩 중앙 스크롤 (첫 번째 선택된 아이템으로)
  void _scrollToSelectedFilter(List<String> filters) {
    if (_selectedFilters.isEmpty) return;
    final firstSelected = _selectedFilters.first;
    final index = filters.indexOf(firstSelected);
    if (index == -1) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_filterScrollController.hasClients) {
        // 각 칩의 실제 너비를 계산 (텍스트 길이에 따라 다르므로 평균값)
        final chipWidth = 80.0 + 8.0; // 평균 칩 너비 + padding
        final screenWidth = MediaQuery.of(context).size.width;

        // 선택된 칩을 정확히 화면 중앙에 배치
        final targetOffset = (index * chipWidth) - (screenWidth / 2) + (chipWidth / 2);
        final maxScroll = _filterScrollController.position.maxScrollExtent;
        final clampedOffset = targetOffset.clamp(0.0, maxScroll);

        _filterScrollController.animateTo(
          clampedOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 섹션으로 스크롤
  void _scrollToSection(String sectionKey) {
    final key = _sectionKeys[sectionKey];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1, // 상단에서 10% 위치
      );
    }
  }

  /// 테마 스위처
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

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitChip",
        actions: [
          _buildThemeSwitcher(context),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildBasicSection(context),
            const SizedBox(height: 16),
            _buildChoiceSection(context),
            const SizedBox(height: 16),
            _buildFilterSection(context),
            const SizedBox(height: 16),
            _buildInputSection(context),
            const SizedBox(height: 16),
            _buildActionSection(context),
            const SizedBox(height: 16),
            _buildAvatarSection(context),
            const SizedBox(height: 16),
            _buildStatesSection(context),
            const SizedBox(height: 40), // Extra bottom padding
          ],
        ),
      ),
    );
  }

  /// 기본 Chip 섹션
  Widget _buildBasicSection(BuildContext context) {
    return _buildSection(
      context,
      sectionKey: 'basic',
      title: "Basic Chip",
      icon: Icons.label_outline,
      description: "기본적인 칩 (레이블만)",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FitChip(
            type: FitChipType.basic,
            label: "전체",
            onTap: () => debugPrint("전체 탭"),
          ),
          FitChip(
            type: FitChipType.basic,
            label: "진행중",
            backgroundColor: context.fitColors.periwinkle50,
            labelColor: context.fitColors.periwinkle500,
            onTap: () => debugPrint("진행중 탭"),
          ),
          FitChip(
            type: FitChipType.basic,
            label: "완료",
            backgroundColor: context.fitColors.green50,
            labelColor: context.fitColors.green500,
            onTap: () => debugPrint("완료 탭"),
          ),
          FitChip(
            type: FitChipType.basic,
            label: "대기",
            backgroundColor: context.fitColors.grey200,
            labelColor: context.fitColors.grey700,
            onTap: () => debugPrint("대기 탭"),
          ),
        ],
      ),
    );
  }

  /// Choice Chip 섹션
  Widget _buildChoiceSection(BuildContext context) {
    final sizes = [
      'XXS',
      'XS',
      'S',
      'M',
      'L',
      'XL',
      'XXL',
      '3XL',
      '4XL',
      '5XL',
      'Free',
      '90',
      '95',
      '100',
      '105',
      '110'
    ];

    return _buildSection(
      context,
      sectionKey: 'choice',
      title: "Choice Chip",
      icon: Icons.check_circle_outline,
      description: "선택 가능한 칩 (단일 선택)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "사이즈 선택",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sizes.map((size) {
              return FitChip(
                type: FitChipType.choice,
                label: size,
                isSelected: _selectedSize == size,
                onSelected: (selected) {
                  setState(() => _selectedSize = size);
                },
                selectedBackgroundColor: context.fitColors.main,
                selectedLabelColor: context.fitColors.staticBlack,
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text(
            "선택됨: $_selectedSize",
            style: context.caption1().copyWith(
                  color: context.fitColors.main,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      collapsedChild: SingleChildScrollView(
        controller: _choiceScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: sizes.map((size) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FitChip(
                type: FitChipType.choice,
                label: size,
                isSelected: _selectedSize == size,
                onSelected: (selected) {
                  setState(() => _selectedSize = size);
                },
                selectedBackgroundColor: context.fitColors.main,
                selectedLabelColor: context.fitColors.staticBlack,
              ),
            );
          }).toList(),
        ),
      ),
      onCollapse: () => _scrollToSelectedChoice(sizes),
    );
  }

  /// Filter Chip 섹션
  Widget _buildFilterSection(BuildContext context) {
    final filters = [
      '전체',
      '디자인',
      '개발',
      '마케팅',
      '기획',
      'UI/UX',
      '프론트엔드',
      '백엔드',
      'iOS',
      'Android',
      'Flutter',
      'React',
      'Vue',
      'Angular',
      'Node.js',
      'Python',
      'Java',
      'Kotlin',
      'Swift',
      'DevOps'
    ];

    return _buildSection(
      context,
      sectionKey: 'filter',
      title: "Filter Chip",
      icon: Icons.filter_list,
      description: "필터 칩 (다중 선택, 체크마크 포함)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "카테고리 필터",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((filter) {
              return FitChip(
                type: FitChipType.filter,
                label: filter,
                isSelected: _selectedFilters.contains(filter),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(filter);
                    } else {
                      _selectedFilters.remove(filter);
                    }
                  });
                },
                selectedBackgroundColor: context.fitColors.periwinkle50,
                selectedLabelColor: context.fitColors.periwinkle500,
                selectedBorderColor: context.fitColors.periwinkle500,
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text(
            "선택됨: ${_selectedFilters.join(', ')}",
            style: context.caption1().copyWith(
                  color: context.fitColors.periwinkle500,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      collapsedChild: SingleChildScrollView(
        controller: _filterScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FitChip(
                type: FitChipType.filter,
                label: filter,
                isSelected: _selectedFilters.contains(filter),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(filter);
                    } else {
                      _selectedFilters.remove(filter);
                    }
                  });
                },
                selectedBackgroundColor: context.fitColors.periwinkle50,
                selectedLabelColor: context.fitColors.periwinkle500,
                selectedBorderColor: context.fitColors.periwinkle500,
              ),
            );
          }).toList(),
        ),
      ),
      onCollapse: () => _scrollToSelectedFilter(filters),
    );
  }

  /// Input Chip 섹션
  Widget _buildInputSection(BuildContext context) {
    return _buildSection(
      context,
      sectionKey: 'input',
      title: "Input Chip",
      icon: Icons.cancel_outlined,
      description: "입력 칩 (삭제 버튼 포함)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "태그 관리",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              return FitChip(
                type: FitChipType.input,
                label: tag,
                backgroundColor: context.fitColors.backgroundElevated,
                labelColor: context.fitColors.textPrimary,
                borderColor: context.fitColors.dividerPrimary,
                onDeleted: () {
                  setState(() => _tags.remove(tag));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() => _tags.add('새 태그 ${_tags.length + 1}'));
            },
            icon: const Icon(CupertinoIcons.add, size: 16),
            label: const Text("태그 추가"),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.fitColors.main,
              foregroundColor: context.fitColors.staticBlack,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  /// Action Chip 섹션
  Widget _buildActionSection(BuildContext context) {
    return _buildSection(
      context,
      sectionKey: 'action',
      title: "Action Chip",
      icon: Icons.touch_app,
      description: "액션 칩 (아이콘 + 레이블)",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FitChip(
            type: FitChipType.action,
            label: "공유하기",
            leadingIcon: Icon(
              CupertinoIcons.share,
              size: 16,
              color: context.fitColors.periwinkle500,
            ),
            backgroundColor: context.fitColors.periwinkle50,
            labelColor: context.fitColors.periwinkle500,
            onTap: () => debugPrint("공유하기"),
          ),
          FitChip(
            type: FitChipType.action,
            label: "즐겨찾기",
            leadingIcon: Icon(
              CupertinoIcons.star_fill,
              size: 16,
              color: context.fitColors.yellowBase,
            ),
            backgroundColor: context.fitColors.yellowAlpha12,
            labelColor: context.fitColors.yellowBase,
            onTap: () => debugPrint("즐겨찾기"),
          ),
          FitChip(
            type: FitChipType.action,
            label: "다운로드",
            leadingIcon: Icon(
              CupertinoIcons.arrow_down_circle_fill,
              size: 16,
              color: context.fitColors.green500,
            ),
            backgroundColor: context.fitColors.green50,
            labelColor: context.fitColors.green500,
            onTap: () => debugPrint("다운로드"),
          ),
          FitChip(
            type: FitChipType.action,
            label: "삭제",
            leadingIcon: Icon(
              CupertinoIcons.trash_fill,
              size: 16,
              color: context.fitColors.red500,
            ),
            backgroundColor: context.fitColors.red50,
            labelColor: context.fitColors.red500,
            onTap: () => debugPrint("삭제"),
          ),
        ],
      ),
    );
  }

  /// Avatar Chip 섹션
  Widget _buildAvatarSection(BuildContext context) {
    return _buildSection(
      context,
      sectionKey: 'avatar',
      title: "Avatar Chip",
      icon: Icons.account_circle_outlined,
      description: "아바타가 있는 칩",
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FitChip(
            type: FitChipType.basic,
            label: "김철수",
            avatar: CircleAvatar(
              radius: 12,
              backgroundColor: context.fitColors.periwinkle500,
              child: Text(
                "김",
                style: context.caption1().copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
              ),
            ),
            backgroundColor: context.fitColors.periwinkle50,
            labelColor: context.fitColors.periwinkle500,
            onTap: () => debugPrint("김철수"),
          ),
          FitChip(
            type: FitChipType.basic,
            label: "이영희",
            avatar: CircleAvatar(
              radius: 12,
              backgroundColor: context.fitColors.periwinkle500,
              child: Text(
                "이",
                style: context.caption1().copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
              ),
            ),
            backgroundColor: context.fitColors.periwinkle50,
            labelColor: context.fitColors.periwinkle500,
            onTap: () => debugPrint("이영희"),
          ),
          FitChip(
            type: FitChipType.input,
            label: "박민수",
            avatar: CircleAvatar(
              radius: 12,
              backgroundColor: context.fitColors.green500,
              child: Text(
                "박",
                style: context.caption1().copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
              ),
            ),
            backgroundColor: context.fitColors.green50,
            labelColor: context.fitColors.green500,
            onDeleted: () => debugPrint("박민수 삭제"),
          ),
        ],
      ),
    );
  }

  /// 상태 섹션
  Widget _buildStatesSection(BuildContext context) {
    return _buildSection(
      context,
      sectionKey: 'states',
      title: "States",
      icon: Icons.toggle_on_outlined,
      description: "다양한 상태 (비활성화, elevation)",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "비활성화 상태",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FitChip(
                type: FitChipType.basic,
                label: "비활성화",
                isEnabled: false,
              ),
              FitChip(
                type: FitChipType.choice,
                label: "선택됨",
                isSelected: true,
                isEnabled: false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Elevation (그림자)",
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FitChip(
                type: FitChipType.basic,
                label: "Elevation 0",
                elevation: 0,
                onTap: () {},
              ),
              FitChip(
                type: FitChipType.basic,
                label: "Elevation 2",
                elevation: 2,
                backgroundColor: Colors.white,
                onTap: () {},
              ),
              FitChip(
                type: FitChipType.basic,
                label: "Elevation 4",
                elevation: 4,
                backgroundColor: Colors.white,
                onTap: () {},
              ),
              FitChip(
                type: FitChipType.basic,
                label: "Elevation 8",
                elevation: 8,
                backgroundColor: Colors.white,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 섹션 래퍼
  Widget _buildSection(
    BuildContext context, {
    required String sectionKey,
    required String title,
    required IconData icon,
    required String description,
    required Widget child,
    Widget? collapsedChild,
    VoidCallback? onCollapse,
  }) {
    final isExpanded = _expandedSections[sectionKey] ?? true;
    final globalKey = _sectionKeys[sectionKey];

    return Container(
      key: globalKey,
      decoration: BoxDecoration(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _expandedSections[sectionKey] = !isExpanded;
              });
              if (!isExpanded) {
                // 펼칠 때는 섹션으로 스크롤
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollToSection(sectionKey);
                });
              } else {
                // 접을 때는 선택된 칩으로 스크롤
                if (onCollapse != null) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    onCollapse();
                  });
                }
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Icon(icon, color: context.fitColors.main, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.subtitle4().copyWith(
                              color: context.fitColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: context.caption1().copyWith(
                              color: context.fitColors.textTertiary,
                            ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: isExpanded ? 0.5 : 0,
                  child: Icon(
                    CupertinoIcons.chevron_down,
                    color: context.fitColors.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      child,
                    ],
                  )
                : collapsedChild != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          collapsedChild,
                        ],
                      )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
