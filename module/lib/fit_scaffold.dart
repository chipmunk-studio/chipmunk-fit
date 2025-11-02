import 'dart:io' show Platform;

import 'package:chip_assets/gen/assets.gen.dart';
import 'package:component/fit_dot_loading.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';
import 'package:foundation/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// 앱 전체에서 사용되는 공통 Scaffold 위젯
///
/// 플랫폼별 AppBar 처리, 로딩 상태 관리, SafeArea 등을 제공
class FitScaffold extends StatelessWidget {
  /// Scaffold의 본문 내용
  final Widget body;

  /// 하단 SafeArea 적용 여부 (기본값: true)
  final bool bottom;

  /// 상단 SafeArea 적용 여부 (기본값: true)
  final bool top;

  /// 배경색 (기본값: backgroundAlternative)
  final Color? backgroundColor;

  /// 상단 AppBar 위젯
  final PreferredSizeWidget? appBar;

  /// 키보드 표시 시 화면 크기 조정 여부
  final bool resizeToAvoidBottomInset;

  /// AppBar 완전 제거 여부 (true: AppBar 없음, false: 기본 동작)
  ///
  /// - true: AppBar를 완전히 제거 (상태바 제어 없음)
  /// - false: appBar가 null이면 플랫폼별 기본 AppBar 사용
  ///   - Android: FitEmptyAppBar (상태바 색상 제어용)
  ///   - iOS: AppBar 없음
  final bool isRemoveAppBar;

  /// 로딩 상태 표시 여부
  final bool isLoading;

  /// 로딩 시 표시할 위젯 (기본값: FitDotLoading)
  final Widget? loadingView;

  /// 하단 시트 위젯
  final Widget? bottomSheet;

  /// 하단 네비게이션 바 위젯
  final Widget? bottomNavigationBar;

  /// 본문 패딩 (기본값: 좌우 20)
  final EdgeInsets? padding;

  const FitScaffold({
    super.key,
    required this.body,
    this.bottom = true,
    this.top = true,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
    this.isRemoveAppBar = false,
    this.isLoading = false,
    this.loadingView,
    this.backgroundColor,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;

    return CupertinoScaffold(
      body: Scaffold(
        backgroundColor: effectiveBackgroundColor,
        appBar: _buildAppBar(context, effectiveBackgroundColor),
        bottomSheet: bottomSheet,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          bottom: bottom,
          top: top,
          child: Padding(
            padding: padding ?? _getDefaultPadding(context),
            child: _buildBodyWithLoadingState(context),
          ),
        ),
      ),
    );
  }

  /// AppBar 빌드 (플랫폼별 처리)
  ///
  /// 우선순위:
  /// 1. isRemoveAppBar == true → null 반환 (AppBar 완전 제거)
  /// 2. appBar != null → 제공된 AppBar 사용
  /// 3. Android → FitEmptyAppBar (상태바 색상 제어)
  /// 4. iOS → null (기본 동작)
  PreferredSizeWidget? _buildAppBar(BuildContext context, Color backgroundColor) {
    if (isRemoveAppBar) return null;
    if (appBar != null) return appBar;

    return _buildPlatformSpecificAppBar(backgroundColor, context);
  }

  /// 기본 패딩 계산
  EdgeInsets _getDefaultPadding(BuildContext context) {
    return EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: bottom ? MediaQuery.of(context).padding.bottom : 0.0,
    );
  }

  /// 로딩 상태에 따른 본문 빌드
  Widget _buildBodyWithLoadingState(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: _buildTransition,
      child: isLoading ? _buildLoadingWidget(context) : _buildBodyWidget(),
    );
  }

  /// 페이드 전환 효과
  Widget _buildTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Align(
        alignment: Alignment.topLeft,
        child: child,
      ),
    );
  }

  /// 로딩 위젯
  Widget _buildLoadingWidget(BuildContext context) {
    return Column(
      key: const ValueKey('loading'),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loadingView ??
            Center(
              child: FitDotLoading(color: context.fitColors.main),
            ),
        const SizedBox(height: 56),
      ],
    );
  }

  /// 본문 위젯
  Widget _buildBodyWidget() {
    return SizedBox(
      key: const ValueKey('body'),
      child: body,
    );
  }

  /// 플랫폼별 AppBar 생성
  ///
  /// Android: 상태바 색상 제어를 위해 FitEmptyAppBar 사용
  /// iOS/Web: AppBar 없음
  PreferredSizeWidget? _buildPlatformSpecificAppBar(
    Color backgroundColor,
    BuildContext context,
  ) {
    // 웹이거나 iOS면 null 반환
    if (kIsWeb || !Platform.isAndroid) return null;

    // Android만 FitEmptyAppBar 반환
    return FitEmptyAppBar(backgroundColor);
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
  const FitEmptyAppBar.navigationBarColors({
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

/// 공통 AppBar 스타일 생성 유틸리티
abstract class FitCustomAppBar {
  /// 뒤로가기 버튼이 있는 AppBar 생성
  ///
  /// [title] - AppBar 제목
  /// [onPressed] - 뒤로가기 버튼 콜백 (기본값: Navigator.pop)
  /// [leadingIcon] - 커스텀 leading 아이콘
  /// [actions] - 우측 액션 버튼들
  /// [backgroundColor] - 배경색
  /// [titleColor] - 제목 색상
  /// [centerTitle] - 제목 중앙 정렬 여부
  /// [leftAlignTitle] - 제목 좌측 정렬 여부
  static AppBar leadingAppBar(
    BuildContext context, {
    String title = "",
    Function0? onPressed,
    Widget? leadingIcon,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? titleColor,
    bool centerTitle = false,
    bool leftAlignTitle = true,
  }) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;

    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: effectiveBackgroundColor,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: effectiveBackgroundColor,
      ),
      backgroundColor: effectiveBackgroundColor,
      leading: _buildLeadingButton(context, leadingIcon, onPressed),
      title: _buildTitle(context, title, titleColor),
      centerTitle: centerTitle,
      titleSpacing: leftAlignTitle ? 0.0 : NavigationToolbar.kMiddleSpacing,
      actions: actions,
    );
  }

  /// leading 버튼 빌드
  static Widget _buildLeadingButton(
    BuildContext context,
    Widget? leadingIcon,
    Function0? onPressed,
  ) {
    return IconButton(
      icon: leadingIcon ?? ChipAssets.icons.icArrowLeft.svg(color: context.fitColors.grey900),
      onPressed: onPressed ?? () => Navigator.pop(context, true),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iconSize: 24,
      padding: EdgeInsets.zero,
    );
  }

  /// 제목 텍스트 빌드
  static Widget _buildTitle(BuildContext context, String title, Color? titleColor) {
    if (title.isEmpty) return const SizedBox.shrink();

    return Text(
      title,
      style: context.subtitle2().copyWith(
            color: titleColor ?? context.fitColors.grey900,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
