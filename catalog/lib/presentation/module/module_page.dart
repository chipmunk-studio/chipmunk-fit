import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Module 메인 페이지
class ModulePage extends StatelessWidget {
  const ModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.fitColors.backgroundBase,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            _buildModuleList(context),
          ],
        ),
      ),
    );
  }

  /// 헤더
  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modules',
              style: context.h1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '고급 UI 모듈 라이브러리',
              style: context.body2().copyWith(
                    color: context.fitColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// 모듈 리스트
  Widget _buildModuleList(BuildContext context) {
    final modules = [
      _ModuleItem(
        icon: Icons.text_rotation_none,
        iconColor: const Color(0xFF9B51E0),
        title: 'AnimationText',
        subtitle: '애니메이션 텍스트',
        route: '/animation_text',
      ),
      _ModuleItem(
        icon: Icons.chat_bubble_outline,
        iconColor: const Color(0xFFE91E63),
        title: 'Dialog',
        subtitle: '다이얼로그',
        route: '/dialog',
      ),
      _ModuleItem(
        icon: Icons.view_agenda_outlined,
        iconColor: const Color(0xFF3182F6),
        title: 'BottomSheet',
        subtitle: '바텀시트',
        route: '/bottom_sheet',
      ),
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildModuleCard(context, modules[index]),
          childCount: modules.length,
        ),
      ),
    );
  }

  /// 모듈 카드
  Widget _buildModuleCard(BuildContext context, _ModuleItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: context.fitColors.backgroundElevated,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () => context.go(item.route),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: context.subtitle5().copyWith(
                              color: context.fitColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: context.caption1().copyWith(
                              color: context.fitColors.textTertiary,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: context.fitColors.grey400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModuleItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String route;

  const _ModuleItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
