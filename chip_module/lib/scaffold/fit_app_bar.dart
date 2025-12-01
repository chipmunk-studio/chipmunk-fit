import 'package:chip_assets/gen/assets.gen.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_foundation/theme/fit_theme.dart';
import 'package:flutter/material.dart';

/// AppBar 설정을 위한 공통 인터페이스
///
/// 모든 FitAppBar 변형들의 기본 설정 제공
abstract class FitAppBarConfig {
  /// AppBar 높이 (기본값: 56)
  static const double defaultToolbarHeight = 56.0;

  /// AppBar elevation (기본값: 0)
  static const double defaultElevation = 0.0;

  /// 아이콘 크기 (기본값: 24)
  static const double defaultIconSize = 24.0;

  /// 공통 Leading 버튼 빌드
  static Widget buildLeading(
    BuildContext context, {
    Widget? leadingIcon,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: leadingIcon ?? _buildDefaultLeadingIcon(context),
      onPressed: onPressed ?? () => Navigator.pop(context, true),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconSize: defaultIconSize,
      padding: EdgeInsets.zero,
    );
  }

  /// 기본 뒤로가기 아이콘
  static Widget _buildDefaultLeadingIcon(BuildContext context) {
    return ChipAssets.icons.icArrowLeft.svg(
      color: context.fitColors.grey900,
    );
  }

  /// 공통 제목 텍스트 빌드
  static Widget? buildTitle(
    BuildContext context,
    String title,
    Color titleColor,
  ) {
    if (title.isEmpty) return null;

    return Text(
      title,
      style: context.subtitle2().copyWith(color: titleColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// 빈 AppBar (상태바 색상 제어 전용)
///
/// Android에서 상태바와 네비게이션바 색상을 제어하기 위해 사용
/// 시각적으로는 높이 0인 투명한 AppBar
class FitEmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color statusBarColor;
  final Color systemNavigationBarColor;
  final Color backgroundColor;

  /// 단일 색상으로 모든 바 색상 설정
  const FitEmptyAppBar(
    Color color, {
    super.key,
  })  : statusBarColor = color,
        backgroundColor = color,
        systemNavigationBarColor = color;

  /// 각 바의 색상을 개별 설정
  const FitEmptyAppBar.custom({
    super.key,
    required this.statusBarColor,
    required this.systemNavigationBarColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      backgroundColor: backgroundColor,
      toolbarHeight: 0,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.zero;
}

/// Leading 버튼이 있는 기본 AppBar
///
/// 가장 많이 사용되는 뒤로가기 버튼이 있는 AppBar
class FitLeadingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingPressed;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool centerTitle;
  final bool leftAlignTitle;
  final double toolbarHeight;
  final double elevation;

  const FitLeadingAppBar({
    super.key,
    this.title = "",
    this.onLeadingPressed,
    this.leadingIcon,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.centerTitle = false,
    this.leftAlignTitle = true,
    this.toolbarHeight = FitAppBarConfig.defaultToolbarHeight,
    this.elevation = FitAppBarConfig.defaultElevation,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;
    final effectiveTitleColor = titleColor ?? context.fitColors.grey900;

    return AppBar(
      toolbarHeight: toolbarHeight,
      elevation: elevation,
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: effectiveBackgroundColor,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: effectiveBackgroundColor,
      ),
      backgroundColor: effectiveBackgroundColor,
      leading: FitAppBarConfig.buildLeading(
        context,
        leadingIcon: leadingIcon,
        onPressed: onLeadingPressed,
      ),
      title: FitAppBarConfig.buildTitle(context, title, effectiveTitleColor),
      centerTitle: centerTitle,
      titleSpacing: leftAlignTitle ? 0.0 : NavigationToolbar.kMiddleSpacing,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

/// 기본 AppBar (leading 버튼 없음)
///
/// 메인 화면 등 뒤로가기가 필요없는 화면에서 사용
class FitBasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool centerTitle;
  final double toolbarHeight;
  final double elevation;

  const FitBasicAppBar({
    super.key,
    this.title = "",
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.centerTitle = false,
    this.toolbarHeight = FitAppBarConfig.defaultToolbarHeight,
    this.elevation = FitAppBarConfig.defaultElevation,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;
    final effectiveTitleColor = titleColor ?? context.fitColors.grey900;

    return AppBar(
      toolbarHeight: toolbarHeight,
      elevation: elevation,
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: effectiveBackgroundColor,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: effectiveBackgroundColor,
      ),
      backgroundColor: effectiveBackgroundColor,
      automaticallyImplyLeading: false,
      title: FitAppBarConfig.buildTitle(context, title, effectiveTitleColor),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}

/// Extended AppBar (상태바 영역까지 배경색 확장)
///
/// iOS 스타일처럼 상태바 영역까지 배경색이 확장되면서,
/// 실제 컨텐츠(아이콘, 타이틀)는 SafeArea 패딩을 적용
///
/// ## 사용 예시
/// ```dart
/// FitExtendedAppBar(
///   title: "타이틀",
///   backgroundColor: Colors.blue,
/// )
/// ```
class FitExtendedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingPressed;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool centerTitle;
  final bool leftAlignTitle;
  final double toolbarHeight;
  final double elevation;

  const FitExtendedAppBar({
    super.key,
    this.title = "",
    this.onLeadingPressed,
    this.leadingIcon,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.centerTitle = false,
    this.leftAlignTitle = true,
    this.toolbarHeight = FitAppBarConfig.defaultToolbarHeight,
    this.elevation = FitAppBarConfig.defaultElevation,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;
    final effectiveTitleColor = titleColor ?? context.fitColors.grey900;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final titleWidget = FitAppBarConfig.buildTitle(context, title, effectiveTitleColor);

    return Container(
      color: effectiveBackgroundColor,
      child: Column(
        children: [
          // 상태바 영역 (배경색만)
          SizedBox(height: statusBarHeight),

          // 실제 AppBar 컨텐츠 (SafeArea 안쪽)
          SizedBox(
            height: toolbarHeight,
            child: Material(
              color: effectiveBackgroundColor,
              elevation: elevation,
              child: Row(
                children: [
                  // Leading 버튼
                  if (onLeadingPressed != null || leadingIcon != null)
                    FitAppBarConfig.buildLeading(
                      context,
                      leadingIcon: leadingIcon,
                      onPressed: onLeadingPressed,
                    ),

                  // Title 레이아웃
                  if (titleWidget != null) ..._buildTitleLayout(titleWidget),

                  // Actions
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 제목 레이아웃 빌드 (중복 제거)
  List<Widget> _buildTitleLayout(Widget titleWidget) {
    if (centerTitle) {
      return [
        const Spacer(),
        titleWidget,
        const Spacer(),
      ];
    }

    if (leftAlignTitle) {
      return [Expanded(child: titleWidget)];
    }

    return [
      const Spacer(),
      titleWidget,
    ];
  }

  @override
  Size get preferredSize {
    // MediaQuery가 없는 상황에서도 안전하게 처리
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final statusBarHeight = MediaQueryData.fromView(view).padding.top;
    return Size.fromHeight(toolbarHeight + statusBarHeight);
  }
}

