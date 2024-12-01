import 'package:chipmunk_fit_catalog/presentation/component/button/button_page.dart';
import 'package:chipmunk_fit_catalog/presentation/foundation/animation/animation_page.dart';
import 'package:chipmunk_fit_catalog/presentation/foundation/textstyle/text_style_page.dart';
import 'package:chipmunk_fit_catalog/presentation/navigation/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/component/image/fit_image_page.dart';

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
        GoRoute(
          path: 'textstyle',
          builder: (BuildContext context, GoRouterState state) {
            return const TextStylePage();
          },
        ),
        GoRoute(
          path: 'image',
          builder: (BuildContext context, GoRouterState state) {
            return const FitImagePage();
          },
        ),
        GoRoute(
          path: 'animation',
          builder: (BuildContext context, GoRouterState state) {
            return const AnimationPage();
          },
        ),
      ],
    ),
  ],
);
