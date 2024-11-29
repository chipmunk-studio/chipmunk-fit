import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'navigation_state.dart';

@immutable
abstract class NavigationSideEffect extends Equatable {}

class NavigationError extends NavigationSideEffect {
  NavigationError();

  @override
  List<Object?> get props => [];
}

class NavigationSchemeLandingPage extends NavigationSideEffect {
  final String landingRoute;
  final String landingBaseRoute;

  NavigationSchemeLandingPage({
    required this.landingRoute,
    required this.landingBaseRoute,
  });

  @override
  List<Object?> get props => [landingRoute, landingBaseRoute];
}

class NavigationOnResumeEffect extends NavigationSideEffect {
  final NavigationTab tab;

  NavigationOnResumeEffect(this.tab);

  @override
  List<Object?> get props => [];
}
