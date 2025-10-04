import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.freezed.dart';

@freezed
abstract class NavigationState with _$NavigationState {
  factory NavigationState({
    required bool isLoading,
    required NavigationTab currentTab,
    required Map<NavigationTab, bool> tabVisited,
  }) = _NavigationState;

  factory NavigationState.initial() => NavigationState(
        isLoading: true,
        currentTab: NavigationTab.main,
        tabVisited: {
          NavigationTab.feed: false,
          NavigationTab.benefit: false,
          NavigationTab.main: true,
          NavigationTab.friends: false,
          NavigationTab.my_page: false,
        },
      );
}

enum NavigationTab { feed, benefit, main, friends, my_page }

extension NavigationTabExtension on NavigationTab {
  int get index {
    switch (this) {
      case NavigationTab.feed:
        return 0;
      case NavigationTab.benefit:
        return 1;
      case NavigationTab.main:
        return 2;
      case NavigationTab.friends:
        return 3;
      case NavigationTab.my_page:
        return 4;
    }
  }

  static NavigationTab fromIndex(int index) {
    switch (index) {
      case 0:
        return NavigationTab.feed;
      case 1:
        return NavigationTab.benefit;
      case 2:
        return NavigationTab.main;
      case 3:
        return NavigationTab.friends;
      case 4:
        return NavigationTab.my_page;
      default:
        return NavigationTab.main;
    }
  }

  static NavigationTab fromString(String value) {
    switch (value) {
      case 'feed':
        return NavigationTab.feed;
      case 'benefit':
        return NavigationTab.benefit;
      case 'main':
        return NavigationTab.main;
      case 'friends':
        return NavigationTab.friends;
      case 'my_page':
        return NavigationTab.my_page;
      default:
        return NavigationTab.main;
    }
  }

  static int indexFromString(String value) {
    return fromString(value).index;
  }

  static bool isTab(String value) {
    return [
      NavigationTab.main.name,
      NavigationTab.friends.name,
      NavigationTab.benefit.name,
      NavigationTab.my_page.name,
      NavigationTab.feed.name,
    ].contains(value);
  }
}
