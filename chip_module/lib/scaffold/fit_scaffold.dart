import 'dart:io' show Platform;

import 'package:chip_component/fit_dot_loading.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'fit_app_bar.dart';

/// 앱 전체에서 사용되는 공통 Scaffold 위젯
///
/// 플랫폼별 AppBar 처리, 로딩 상태 관리, SafeArea 등을 제공
///
/// ## 사용 예시
/// ```dart
/// FitScaffold(
///   appBar: FitLeadingAppBar(title: "제목"),
///   body: YourContent(),
/// )
/// ```
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

  /// AppBar 완전 제거 여부
  ///
  /// - true: AppBar를 완전히 제거 (상태바 제어 없음)
  /// - false: appBar가 null이면 플랫폼별 기본 AppBar 사용
  ///   - Android: FitEmptyAppBar (상태바 색상 제어용)
  ///   - iOS/Web: AppBar 없음
  final bool removeAppBar;

  /// 로딩 상태 표시 여부
  final bool isLoading;

  /// 로딩 시 표시할 커스텀 위젯
  ///
  /// null일 경우, FitDotLoading이 포함된 기본 로딩 화면 표시
  final Widget? loadingWidget;

  /// 하단 시트 위젯
  final Widget? bottomSheet;

  /// 하단 네비게이션 바 위젯
  final Widget? bottomNavigationBar;

  /// 본문 패딩 (기본값: EdgeInsets.symmetric(horizontal: 20))
  final EdgeInsets? padding;

  /// 플로팅 액션 버튼
  final Widget? floatingActionButton;

  /// 플로팅 액션 버튼 위치
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Drawer (좌측 사이드 메뉴)
  final Widget? drawer;

  /// End Drawer (우측 사이드 메뉴)
  final Widget? endDrawer;

  /// 로딩 전환 애니메이션 지속 시간
  final Duration loadingTransitionDuration;

  const FitScaffold({
    super.key,
    required this.body,
    this.bottom = true,
    this.top = true,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
    this.removeAppBar = false,
    this.isLoading = false,
    this.loadingWidget,
    this.backgroundColor,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.loadingTransitionDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    // 배경색 계산은 한 번만
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.backgroundAlternative;

    return Scaffold(
      backgroundColor: effectiveBackgroundColor,
      appBar: _resolveAppBar(context, effectiveBackgroundColor),
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: _buildSafeBody(context),
    );
  }

  /// AppBar 결정 (최적화됨)
  ///
  /// 우선순위:
  /// 1. removeAppBar == true → null 반환
  /// 2. appBar != null → 제공된 AppBar 사용
  /// 3. 플랫폼별 기본 AppBar
  PreferredSizeWidget? _resolveAppBar(BuildContext context, Color backgroundColor) {
    if (removeAppBar) return null;
    if (appBar != null) return appBar;
    return _platformDefaultAppBar(backgroundColor);
  }

  /// 플랫폼별 기본 AppBar
  ///
  /// Android: FitEmptyAppBar (상태바 색상 제어)
  /// iOS/Web: null
  PreferredSizeWidget? _platformDefaultAppBar(Color backgroundColor) {
    if (kIsWeb || !Platform.isAndroid) return null;
    return FitEmptyAppBar(backgroundColor);
  }

  /// SafeArea + Padding이 적용된 본문
  Widget _buildSafeBody(BuildContext context) {
    return SafeArea(
      bottom: bottom,
      top: top,
      child: Padding(
        padding: _resolvePadding(context),
        child: _buildBodyWithLoading(context),
      ),
    );
  }

  /// 패딩 계산 (최적화됨)
  EdgeInsets _resolvePadding(BuildContext context) {
    if (padding != null) return padding!;

    // 기본 패딩: 좌우 20
    return const EdgeInsets.symmetric(horizontal: 20);
  }

  /// 로딩 상태에 따른 본문 (최적화됨)
  Widget _buildBodyWithLoading(BuildContext context) {
    return AnimatedSwitcher(
      duration: loadingTransitionDuration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: _fadeTransition,
      child: isLoading
          ? _buildLoading(context)
          : _BodyWidget(key: const ValueKey('body'), child: body),
    );
  }

  /// 페이드 전환 효과
  Widget _fadeTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Align(
        alignment: Alignment.topLeft,
        child: child,
      ),
    );
  }

  /// 로딩 위젯 빌드
  Widget _buildLoading(BuildContext context) {
    if (loadingWidget != null) {
      return _LoadingWidget(key: const ValueKey('loading'), child: loadingWidget!);
    }

    return _DefaultLoadingWidget(
      key: const ValueKey('loading'),
      color: context.fitColors.main,
    );
  }
}

/// 본문 위젯 (최적화를 위한 StatelessWidget)
class _BodyWidget extends StatelessWidget {
  final Widget child;

  const _BodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// 로딩 위젯 (최적화를 위한 StatelessWidget)
class _LoadingWidget extends StatelessWidget {
  final Widget child;

  const _LoadingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

/// 기본 로딩 위젯 (최적화를 위한 StatelessWidget)
class _DefaultLoadingWidget extends StatelessWidget {
  final Color color;

  const _DefaultLoadingWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: FitDotLoading(color: color)),
        const SizedBox(height: 56),
      ],
    );
  }
}
