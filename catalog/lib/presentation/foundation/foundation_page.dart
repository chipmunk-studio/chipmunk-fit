import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Foundation 메인 페이지 (토스 스타일)
class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.fitColors.backgroundBase,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            _buildMenuList(context),
          ],
        ),
      ),
    );
  }

  /// 헤더 영역
  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foundation',
              style: context.h1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '디자인 시스템의 기본 요소',
              style: context.body2().copyWith(
                    color: context.fitColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// 메뉴 리스트
  Widget _buildMenuList(BuildContext context) {
    final menus = [
      _MenuItem(
        icon: Icons.palette_outlined,
        iconColor: const Color(0xFF3182F6),
        title: '컬러 시스템',
        description: '라이트/다크 모드 색상',
        route: '/color',
      ),
      _MenuItem(
        icon: Icons.text_fields_outlined,
        iconColor: const Color(0xFFF76B1C),
        title: '타이포그래피',
        description: '텍스트 스타일 가이드',
        route: '/textstyle',
      ),
      _MenuItem(
        icon: Icons.animation_outlined,
        iconColor: const Color(0xFF9B51E0),
        title: '애니메이션',
        description: '모션 디자인',
        route: '/animation',
      ),
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final menu = menus[index];
            return _buildMenuCard(context, menu);
          },
          childCount: menus.length,
        ),
      ),
    );
  }

  /// 메뉴 카드
  Widget _buildMenuCard(BuildContext context, _MenuItem menu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: () => context.go(menu.route),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: menu.iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    menu.icon,
                    color: menu.iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.title,
                        style: context.subtitle4().copyWith(
                              color: context.fitColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        menu.description,
                        style: context.body4().copyWith(
                              color: context.fitColors.textTertiary,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: context.fitColors.grey400,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 메뉴 아이템 모델
class _MenuItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String route;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.route,
  });
}
