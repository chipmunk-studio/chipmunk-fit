import 'dart:async';

import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

import 'navigation.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState>
    with SideEffectBlocMixin<NavigationEvent, NavigationState, NavigationSideEffect> {

  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigationInit>(init);
    on<NavigationHandleLandingRoute>(_handleLandingRoute);
    on<NavigationSelectTabEvent>(_selectTab);
    on<NavigationOnResumed>(_onResume);
    on<NavigationDebouncedOnTabChanged>(
      _onDebouncedTabChanged,
      transformer: debounce(
        const Duration(seconds: 1),
      ),
    );
  }

  FutureOr<void> init(NavigationInit event, Emitter<NavigationState> emit) async {

  }

  FutureOr<void> _handleLandingRoute(NavigationHandleLandingRoute event, Emitter<NavigationState> emit) async {
    final route = event.landingRoute;
    final landingBaseRoute = event.landingBaseRoute;
    final base = event.baseTab;

    final selectedTab = NavigationTabExtension.isTab(route) ? route : base;
    await _selectTab(NavigationSelectTabEvent(NavigationTabExtension.indexFromString(selectedTab)), emit);

    if (route == base || (NavigationTabExtension.isTab(route) && NavigationTabExtension.isTab(base))) {
      return;
    }
    await Future.delayed(Duration(milliseconds: 700));
    produceSideEffect(
      NavigationSchemeLandingPage(
        landingRoute: route,
        landingBaseRoute: landingBaseRoute,
      ),
    );
  }

  FutureOr<void> _selectTab(NavigationSelectTabEvent event, Emitter<NavigationState> emit) {
    final tabIndex = event.tabIndex;
    final nextTab = NavigationTabExtension.fromIndex(tabIndex);
    final updatedTabVisited = Map<NavigationTab, bool>.from(state.tabVisited);

    if (updatedTabVisited[nextTab] == false) {
      produceSideEffect(NavigationOnResumeEffect(nextTab));
      updatedTabVisited[nextTab] = true;
    } else {
      add(NavigationDebouncedOnTabChanged(nextTab));
    }

    emit(
      state.copyWith(
        currentTab: nextTab,
        tabVisited: updatedTabVisited,
      ),
    );
  }

  FutureOr<void> _onResume(NavigationOnResumed event, Emitter<NavigationState> emit) {
    produceSideEffect(NavigationOnResumeEffect(state.currentTab));
  }

  FutureOr<void> _onDebouncedTabChanged(NavigationDebouncedOnTabChanged event, Emitter<NavigationState> emit) {
    produceSideEffect(NavigationOnResumeEffect(event.tab));
  }
}
