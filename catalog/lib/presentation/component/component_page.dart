import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Component 메인 페이지 (토스 스타일)
class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

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
              'Components',
              style: context.h1().copyWith(
                    color: context.fitColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'UI 컴포넌트 라이브러리',
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
            title: 'Inputs',
            items: [
              _ComponentItem(
                icon: Icons.smart_button_outlined,
                iconColor: const Color(0xFF3182F6),
                title: 'Button',
                subtitle: '버튼 컴포넌트',
                route: '/button',
              ),
              _ComponentItem(
                icon: Icons.check_box_outlined,
                iconColor: const Color(0xFF9B51E0),
                title: 'CheckBox',
                subtitle: '체크박스',
                route: '/check_box',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCategory(
            context,
            title: 'Display',
            items: [
              _ComponentItem(
                icon: Icons.image_outlined,
                iconColor: const Color(0xFFF76B1C),
                title: 'Image',
                subtitle: '이미지 컴포넌트',
                route: '/image',
              ),
              _ComponentItem(
                icon: Icons.text_fields,
                iconColor: const Color(0xFFE91E63),
                title: 'AnimatedText',
                subtitle: '타이핑 애니메이션 텍스트',
                route: '/animation_text',
              ),
            ],
          ),
        ]),
      ),
    );
  }

  /// 카테고리 섹션
  Widget _buildCategory(BuildContext context,
      {required String title, required List<_ComponentItem> items}) {
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
        ...items.map((item) => _buildComponentCard(context, item)),
      ],
    );
  }

  /// 컴포넌트 카드
  Widget _buildComponentCard(BuildContext context, _ComponentItem item) {
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

class _ComponentItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String route;

  const _ComponentItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
