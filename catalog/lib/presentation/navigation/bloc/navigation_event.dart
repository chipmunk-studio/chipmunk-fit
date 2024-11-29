import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'navigation_state.dart';

@immutable
abstract class NavigationEvent extends Equatable {}

class NavigationInit extends NavigationEvent {
  NavigationInit();

  @override
  List<Object?> get props => [];
}

class NavigationHandleLandingRoute extends NavigationEvent {
  final String landingRoute;
  final String landingBaseRoute;
  final String baseTab;

  NavigationHandleLandingRoute({
    required this.landingRoute,
    this.landingBaseRoute = '',
    required this.baseTab,
  });

  @override
  List<Object?> get props => [
        landingRoute,
        landingBaseRoute,
      ];
}

class NavigationSelectTabEvent extends NavigationEvent {
  final int tabIndex;

  NavigationSelectTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class NavigationOnResumed extends NavigationEvent {
  NavigationOnResumed();

  @override
  List<Object?> get props => [];
}

class NavigationDebouncedOnTabChanged extends NavigationEvent {
  final NavigationTab tab;

  NavigationDebouncedOnTabChanged(this.tab);

  @override
  List<Object?> get props => [];
}
