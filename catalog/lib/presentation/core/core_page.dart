import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Core 메인 페이지
class CorePage extends StatelessWidget {
  const CorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.fitColors.backgroundBase,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            _buildCategoryList(context),
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
              'Core',
              style: context.h1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '핵심 유틸리티 라이브러리',
              style: context.body2().copyWith(
                    color: context.fitColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// 카테고리 리스트
  Widget _buildCategoryList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildCategory(
            context,
            title: 'Utils',
            items: [
              _CoreItem(
                icon: Icons.cached,
                iconColor: const Color(0xFF00BCD4),
                title: 'Cache Helper',
                subtitle: '파일 다운로드 및 캐싱',
                route: '/cache_helper',
              ),
              _CoreItem(
                icon: Icons.text_snippet_outlined,
                iconColor: const Color(0xFF4CAF50),
                title: 'Delta Viewer',
                subtitle: 'Quill Delta JSON 뷰어',
                route: '/delta_viewer',
              ),
            ],
          ),
        ]),
      ),
    );
  }

  /// 카테고리 섹션
  Widget _buildCategory(BuildContext context,
      {required String title, required List<_CoreItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: context.subtitle6().copyWith(
                  color: context.fitColors.textSecondary,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        ...items.map((item) => _buildCoreCard(context, item)),
      ],
    );
  }

  /// Core 카드
  Widget _buildCoreCard(BuildContext context, _CoreItem item) {
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

class _CoreItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String route;

  const _CoreItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
