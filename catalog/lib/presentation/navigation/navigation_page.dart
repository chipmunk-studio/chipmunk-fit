import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:catalog/presentation/component/component_page.dart';
import 'package:catalog/presentation/core/core_page.dart';
import 'package:catalog/presentation/foundation/foundation_page.dart';
import 'package:catalog/presentation/module/module_page.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/theme.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:chip_module/skeletons/skeletons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

import 'bloc/navigation.dart';
import 'component/bottom_navigation_bar.dart';

/// 메인 네비게이션 페이지
class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [
          context.fitColors.grey700,
          context.fitColors.grey600,
          context.fitColors.grey600,
          context.fitColors.grey800,
          context.fitColors.grey600,
          context.fitColors.grey600,
          context.fitColors.grey700,
        ],
        stops: const [0.3, 0.5, 0.7, 0.9, 0.7, 0.5, 0.3],
      ),
      child: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc()..add(NavigationInit()),
        child: const _NavigationPage(),
      ),
    );
  }
}

class _NavigationPage extends StatefulWidget {
  const _NavigationPage();

  @override
  State<_NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<_NavigationPage> with WidgetsBindingObserver, RouteAware {
  late NavigationBloc _navigationBloc;

  /// 페이지 목록
  late final List<Widget> _pages = const [
    FoundationPage(),
    ComponentPage(),
    ModulePage(),
    CorePage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _navigationBloc = context.read<NavigationBloc>();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _navigationBloc.add(NavigationOnResumed());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _navigationBloc.close();
    super.dispose();
  }

  @override
  void didPopNext() {
    _navigationBloc.add(NavigationOnResumed());
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSideEffectListener<NavigationBloc, NavigationSideEffect>(
      listener: _handleSideEffect,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        buildWhen: (previous, current) => previous.currentTab != current.currentTab,
        builder: (context, state) {
          return FitScaffold(
            padding: EdgeInsets.zero,
            backgroundColor: context.fitColors.backgroundBase,
            appBar: FitEmptyAppBar.custom(
              statusBarColor: context.fitColors.backgroundBase,
              systemNavigationBarColor: context.fitColors.backgroundBase,
              backgroundColor: context.fitColors.backgroundBase,
            ),
            bottom: false,
            top: false,
            body: Stack(
              children: [
                Positioned.fill(
                  child: IndexedStack(
                    index: state.currentTab.index,
                    children: _pages,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomNav(state.currentTab.index),
                ),
                // 테마 스위치 버튼
                Positioned(
                  top: 50,
                  right: 16,
                  child: _buildThemeSwitcher(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 테마 스위처 버튼
  Widget _buildThemeSwitcher(BuildContext context) {
    return ThemeSwitcher(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return GestureDetector(
          onTap: () {
            final theme = isDark ? fitLightTheme(context) : fitDarkTheme(context);
            ThemeSwitcher.of(context).changeTheme(theme: theme);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.fitColors.fillStrong,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
              color: context.fitColors.textPrimary,
              size: 24,
            ),
          ),
        );
      },
    );
  }

  /// 사이드 이펙트 처리
  void _handleSideEffect(BuildContext context, NavigationSideEffect sideEffect) {
    if (sideEffect is NavigationError) {
      // 에러 처리
      debugPrint('Navigation error: ${sideEffect.toString()}');
    } else if (sideEffect is NavigationOnResumeEffect) {
      // 탭별 재개 처리
      _handleTabResume(sideEffect.tab);
    }
  }

  /// 탭 재개 처리
  void _handleTabResume(NavigationTab tab) {
    switch (tab) {
      case NavigationTab.foundation:
      case NavigationTab.component:
      case NavigationTab.module:
      case NavigationTab.core:
        // 필요시 각 탭별 초기화 로직 추가
        break;
    }
  }

  /// 하단 네비게이션 바
  Widget _buildBottomNav(int selectedIndex) {
    return FitBottomNavigationBar(
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        _navigationBloc.add(NavigationSelectTabEvent(index));
      },
    );
  }
}
