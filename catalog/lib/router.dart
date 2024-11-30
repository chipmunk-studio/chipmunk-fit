import 'package:chipmunk_fit_catalog/presentation/component/button/button_page.dart';
import 'package:chipmunk_fit_catalog/presentation/navigation/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter catalogRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return NavigationPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'button',
          builder: (BuildContext context, GoRouterState state) {
            return const ButtonPage();
          },
        ),
      ],
    ),
  ],
);


