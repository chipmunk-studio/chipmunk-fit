import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/component/button/button_page.dart';
import 'presentation/component/card/card_page.dart';
import 'presentation/component/checkbox/check_box_page.dart';
import 'presentation/component/image/fit_image_page.dart';
import 'presentation/foundation/animation/animation_page.dart';
import 'presentation/foundation/color/color_page.dart';
import 'presentation/foundation/textstyle/text_style_page.dart';
import 'presentation/module/animation_text/animation_text_page.dart';
import 'presentation/module/bottomsheet/bottom_sheet_page.dart';
import 'presentation/module/modal/ModalPage.dart';
import 'presentation/navigation/navigation_page.dart';

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
        GoRoute(
          path: 'animation_text',
          builder: (BuildContext context, GoRouterState state) {
            return const AnimationText();
          },
        ),
        GoRoute(
          path: 'check_box',
          builder: (BuildContext context, GoRouterState state) {
            return const CheckBoxPage();
          },
        ),
        GoRoute(
          path: 'dialog',
          builder: (BuildContext context, GoRouterState state) {
            return const ModalPage();
          },
        ),
        GoRoute(
          path: 'bottom_sheet',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomSheetPage();
          },
        ),
        GoRoute(
          path: 'card',
          builder: (BuildContext context, GoRouterState state) {
            return const CardPage();
          },
        ),
        GoRoute(
          path: 'color',
          builder: (BuildContext context, GoRouterState state) {
            return const ColorPage();
          },
        ),
      ],
    ),
  ],
);
