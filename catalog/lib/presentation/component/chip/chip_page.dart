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
      description: "기본적인 정보 표시용 칩",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상태 표시
          Text(
            "프로젝트 상태",
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
                backgroundColor: context.fitColors.periwinkle50,
                child: Text(
                  "진행중",
                  style: context.caption1().copyWith(
                    color: context.fitColors.periwinkle500,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.yellowAlpha12,
                child: Text(
                  "검토중",
                  style: context.caption1().copyWith(
                    color: context.fitColors.yellowBase,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.green50,
                child: Text(
                  "완료",
                  style: context.caption1().copyWith(
                    color: context.fitColors.green500,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.grey200,
                child: Text(
                  "보류",
                  style: context.caption1().copyWith(
                    color: context.fitColors.grey700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 우선순위
          Text(
            "우선순위 레벨",
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
                backgroundColor: context.fitColors.red50,
                child: Text(
                  "긴급",
                  style: context.caption1().copyWith(
                    color: context.fitColors.red500,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.brick50,
                child: Text(
                  "높음",
                  style: context.caption1().copyWith(
                    color: context.fitColors.brick500,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.periwinkle50,
                child: Text(
                  "보통",
                  style: context.caption1().copyWith(
                    color: context.fitColors.periwinkle500,
                  ),
                ),
              ),
              FitChip(
                backgroundColor: context.fitColors.grey200,
                child: Text(
                  "낮음",
                  style: context.caption1().copyWith(
                    color: context.fitColors.grey600,
                  ),
                ),
              ),
            ],
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
              final isSelected = _selectedSize == size;
              return FitChip(
                isSelected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedSize = size);
                },
                selectedBackgroundColor: context.fitColors.main,
                child: Text(
                  size,
                  style: context.caption1().copyWith(
                    color: isSelected ? context.fitColors.staticBlack : context.fitColors.textPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: context.fitColors.main.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.fitColors.main.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  size: 16,
                  color: context.fitColors.main,
                ),
                const SizedBox(width: 6),
                Text(
                  "선택: $_selectedSize",
                  style: context.caption1().copyWith(
                        color: context.fitColors.main,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      collapsedChild: SingleChildScrollView(
        controller: _choiceScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: sizes.map((size) {
            final isSelected = _selectedSize == size;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FitChip(
                isSelected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedSize = size);
                },
                selectedBackgroundColor: context.fitColors.main,
                child: Text(
                  size,
                  style: context.caption1().copyWith(
                    color: isSelected ? context.fitColors.staticBlack : context.fitColors.textPrimary,
                  ),
                ),
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
              final isSelected = _selectedFilters.contains(filter);
              return FitChip(
                isSelected: isSelected,
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
                selectedBorderColor: context.fitColors.periwinkle500,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(
                        CupertinoIcons.checkmark,
                        size: 16,
                        color: context.fitColors.periwinkle500,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      filter,
                      style: context.caption1().copyWith(
                        color: isSelected
                            ? context.fitColors.periwinkle500
                            : context.fitColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.fitColors.periwinkle50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.fitColors.periwinkle500.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.slider_horizontal_3,
                      size: 16,
                      color: context.fitColors.periwinkle500,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "선택된 필터 (${_selectedFilters.length}개)",
                      style: context.caption1().copyWith(
                            color: context.fitColors.periwinkle500,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                if (_selectedFilters.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    _selectedFilters.join(', '),
                    style: context.caption2().copyWith(
                          color: context.fitColors.periwinkle500.withOpacity(0.8),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      collapsedChild: SingleChildScrollView(
        controller: _filterScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = _selectedFilters.contains(filter);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FitChip(
                isSelected: isSelected,
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
                selectedBorderColor: context.fitColors.periwinkle500,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(
                        CupertinoIcons.checkmark,
                        size: 16,
                        color: context.fitColors.periwinkle500,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      filter,
                      style: context.caption1().copyWith(
                        color: isSelected
                            ? context.fitColors.periwinkle500
                            : context.fitColors.textPrimary,
                      ),
                    ),
                  ],
                ),
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
    final predefinedTags = ['디자인', 'Flutter', 'iOS', 'Android', 'Backend', 'Frontend', 'UX/UI'];

    return _buildSection(
      context,
      sectionKey: 'input',
      title: "Input Chip",
      icon: Icons.label,
      description: "삭제 가능한 태그 칩",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "내 관심 태그",
                style: context.subtitle6().copyWith(
                      color: context.fitColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                "${_tags.length}개",
                style: context.caption1().copyWith(
                      color: context.fitColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.fitColors.backgroundAlternative,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.fitColors.dividerPrimary,
                width: 1,
              ),
            ),
            child: _tags.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "아래에서 태그를 추가해보세요",
                        style: context.caption1().copyWith(
                              color: context.fitColors.textTertiary,
                            ),
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      return FitChip(
                        backgroundColor: context.fitColors.backgroundElevated,
                        borderColor: context.fitColors.dividerPrimary,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tag,
                              style: context.caption1().copyWith(
                                color: context.fitColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() => _tags.remove(tag));
                              },
                              child: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                size: 16,
                                color: context.fitColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            "추천 태그",
            style: context.caption1().copyWith(
                  color: context.fitColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: predefinedTags.where((tag) => !_tags.contains(tag)).map((tag) {
              return GestureDetector(
                onTap: () {
                  setState(() => _tags.add(tag));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: context.fitColors.fillBase,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.fitColors.dividerPrimary,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.add_circled,
                        size: 14,
                        color: context.fitColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        tag,
                        style: context.caption2().copyWith(
                              color: context.fitColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
            backgroundColor: context.fitColors.periwinkle50,
            onTap: () => debugPrint("공유하기"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.share,
                  size: 16,
                  color: context.fitColors.periwinkle500,
                ),
                const SizedBox(width: 6),
                Text(
                  "공유하기",
                  style: context.caption1().copyWith(
                    color: context.fitColors.periwinkle500,
                  ),
                ),
              ],
            ),
          ),
          FitChip(
            backgroundColor: context.fitColors.yellowAlpha12,
            onTap: () => debugPrint("즐겨찾기"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  size: 16,
                  color: context.fitColors.yellowBase,
                ),
                const SizedBox(width: 6),
                Text(
                  "즐겨찾기",
                  style: context.caption1().copyWith(
                    color: context.fitColors.yellowBase,
                  ),
                ),
              ],
            ),
          ),
          FitChip(
            backgroundColor: context.fitColors.green50,
            onTap: () => debugPrint("다운로드"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.arrow_down_circle_fill,
                  size: 16,
                  color: context.fitColors.green500,
                ),
                const SizedBox(width: 6),
                Text(
                  "다운로드",
                  style: context.caption1().copyWith(
                    color: context.fitColors.green500,
                  ),
                ),
              ],
            ),
          ),
          FitChip(
            backgroundColor: context.fitColors.red50,
            onTap: () => debugPrint("삭제"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.trash_fill,
                  size: 16,
                  color: context.fitColors.red500,
                ),
                const SizedBox(width: 6),
                Text(
                  "삭제",
                  style: context.caption1().copyWith(
                    color: context.fitColors.red500,
                  ),
                ),
              ],
            ),
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
            backgroundColor: context.fitColors.periwinkle50,
            onTap: () => debugPrint("김철수"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
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
                const SizedBox(width: 6),
                Text(
                  "김철수",
                  style: context.caption1().copyWith(
                    color: context.fitColors.periwinkle500,
                  ),
                ),
              ],
            ),
          ),
          FitChip(
            backgroundColor: context.fitColors.periwinkle50,
            onTap: () => debugPrint("이영희"),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
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
                const SizedBox(width: 6),
                Text(
                  "이영희",
                  style: context.caption1().copyWith(
                    color: context.fitColors.periwinkle500,
                  ),
                ),
              ],
            ),
          ),
          FitChip(
            backgroundColor: context.fitColors.green50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
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
                const SizedBox(width: 6),
                Text(
                  "박민수",
                  style: context.caption1().copyWith(
                    color: context.fitColors.green500,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => debugPrint("박민수 삭제"),
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 16,
                    color: context.fitColors.green500,
                  ),
                ),
              ],
            ),
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
                isEnabled: false,
                child: Text(
                  "비활성화",
                  style: context.caption1(),
                ),
              ),
              FitChip(
                isSelected: true,
                isEnabled: false,
                child: Text(
                  "선택됨",
                  style: context.caption1(),
                ),
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
                elevation: 0,
                onTap: () {},
                child: Text(
                  "Elevation 0",
                  style: context.caption1(),
                ),
              ),
              FitChip(
                elevation: 2,
                backgroundColor: Colors.white,
                onTap: () {},
                child: Text(
                  "Elevation 2",
                  style: context.caption1(),
                ),
              ),
              FitChip(
                elevation: 4,
                backgroundColor: Colors.white,
                onTap: () {},
                child: Text(
                  "Elevation 4",
                  style: context.caption1(),
                ),
              ),
              FitChip(
                elevation: 8,
                backgroundColor: Colors.white,
                onTap: () {},
                child: Text(
                  "Elevation 8",
                  style: context.caption1(),
                ),
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
