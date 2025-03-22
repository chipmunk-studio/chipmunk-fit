import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:chipfit/module/skeletons/components/theme.dart';
import 'package:chipmunk_fit_catalog/presentation/component/component_page.dart';
import 'package:chipmunk_fit_catalog/presentation/foundation/foundation_page.dart';
import 'package:chipmunk_fit_catalog/presentation/module/module_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

import 'bloc/navigation.dart';
import 'component/bottom_navigation_bar.dart';

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
        stops: [0.3, 0.5, 0.7, 0.9, 0.7, 0.5, 0.3],
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc()..add(NavigationInit()),
          ),
          // BlocProvider<BenefitBloc>(
          //   lazy: true,
          //   create: (context) => serviceLocator<BenefitBloc>(),
          // ),
          // BlocProvider<MainBloc>(
          //   lazy: true,
          //   create: (context) => serviceLocator<MainBloc>()..add(MainInit()),
          // ),
          // BlocProvider<FeedBloc>(
          //   lazy: true,
          //   create: (context) => serviceLocator<FeedBloc>(),
          // ),
          // BlocProvider<MyPageBloc>(
          //   lazy: true,
          //   create: (context) => serviceLocator<MyPageBloc>(),
          // ),
          // BlocProvider<FriendBloc>(
          //   lazy: true,
          //   create: (context) => serviceLocator<FriendBloc>(),
          // ),
        ],
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

  // late BenefitBloc _benefitBloc;
  // late MainBloc _mainBloc;
  // late FeedBloc _feedBloc;
  // late MyPageBloc _myPageBloc;
  // late FriendBloc _friendBloc;

  // late final List<Widget> _pages = [
  //   FeedPage(bloc: _feedBloc),
  //   BenefitPage(bloc: _benefitBloc),
  //   LarMainPage(
  //     bloc: _mainBloc,
  //     onProfileImageLoaded: (entity) {
  //       _navigationBloc.add(NavigationProfileInit(entity));
  //     },
  //   ),
  //   FriendPage(
  //     bloc: _friendBloc,
  //     parentBloc: _navigationBloc,
  //   ),
  //   MyPage(bloc: _myPageBloc),
  // ];

  late final List<Widget> _pages = [
    FoundationPage(),
    ComponentPage(),
    ModulePage(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    // _benefitBloc = BlocProvider.of<BenefitBloc>(context);
    // _mainBloc = BlocProvider.of<MainBloc>(context);
    // _feedBloc = BlocProvider.of<FeedBloc>(context);
    // _myPageBloc = BlocProvider.of<MyPageBloc>(context);
    // _friendBloc = BlocProvider.of<FriendBloc>(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _navigationBloc.add(NavigationOnResumed());
        break;
      case AppLifecycleState.inactive:
        // 앱이 비활성 상태일 때 (예: 전화가 왔을 때)
        break;
      case AppLifecycleState.paused:
        // 앱이 백그라운드로 전환될 때
        break;
      case AppLifecycleState.detached:
        // 앱이 완전히 종료되기 전에 호출됩니다.
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _navigationBloc.close();
    // _benefitBloc.close();
    // _mainBloc.close();
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
      listener: (context, sideEffect) async {
        if (sideEffect is NavigationError) {
        } else if (sideEffect is NavigationOnResumeEffect) {
          switch (sideEffect.tab) {
            case NavigationTab.feed:
              // _feedBloc.add(FeedInit());
              break;
            case NavigationTab.benefit:
              // _benefitBloc.add(BenefitInit());
              break;
            case NavigationTab.main:
              // _mainBloc.add(MainOnResume());
              break;
            case NavigationTab.friends:
              // _friendBloc.add(FriendInit());
              break;
            case NavigationTab.my_page:
              // _myPageBloc.add(MyPageInit());
              break;
          }
        }
      },
      child: BlocBuilder<NavigationBloc, NavigationState>(
        buildWhen: (previous, current) => previous.currentTab != current.currentTab,
        builder: (context, state) {
          return FitScaffold(
            padding: EdgeInsets.zero,
            backgroundColor: context.fitColors.grey800,
            appBar: FitEmptyAppBar.navigationBarColors(
              statusBarColor: context.fitColors.grey0,
              systemNavigationBarColor: context.fitColors.grey0,
              backgroundColor: context.fitColors.grey0,
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
                  child: FitBottomNavigationBar(
                    selectedIndex: state.currentTab.index,
                    onItemTapped: _onItemTapped,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    _navigationBloc.add(NavigationSelectTabEvent(index));
  }
}
