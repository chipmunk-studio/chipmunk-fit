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
        currentTab: NavigationTab.foundation,
        tabVisited: {
          NavigationTab.foundation: true,
          NavigationTab.component: false,
          NavigationTab.module: false,
        },
      );
}

enum NavigationTab { foundation, component, module }

extension NavigationTabExtension on NavigationTab {
  int get index {
    switch (this) {
      case NavigationTab.foundation:
        return 0;
      case NavigationTab.component:
        return 1;
      case NavigationTab.module:
        return 2;
    }
  }

  static NavigationTab fromIndex(int index) {
    switch (index) {
      case 0:
        return NavigationTab.foundation;
      case 1:
        return NavigationTab.component;
      case 2:
        return NavigationTab.module;
      default:
        return NavigationTab.foundation;
    }
  }

  static NavigationTab fromString(String value) {
    switch (value) {
      case 'foundation':
        return NavigationTab.foundation;
      case 'component':
        return NavigationTab.component;
      case 'module':
        return NavigationTab.module;
      default:
        return NavigationTab.foundation;
    }
  }

  static int indexFromString(String value) {
    return fromString(value).index;
  }

  static bool isTab(String value) {
    return [
      NavigationTab.foundation.name,
      NavigationTab.component.name,
      NavigationTab.module.name,
    ].contains(value);
  }
}
