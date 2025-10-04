import 'dart:io';

import 'package:assets/gen/assets.gen.dart';
import 'package:component/fit_dot_loading.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';
import 'package:foundation/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FitScaffold extends StatelessWidget {
  final Widget body;
  final bool? bottom;
  final bool? top;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;
  final bool? isRemoveAppBar;
  final bool isLoading;
  final Widget? loadingView;
  final Widget? bottomSheet;
  final EdgeInsets? padding;

  const FitScaffold({
    super.key,
    required this.body,
    this.bottom,
    this.top,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
    this.isRemoveAppBar = false,
    this.isLoading = false,
    this.loadingView = const Center(child: FitDotLoading()),
    this.backgroundColor,
    this.bottomSheet,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        backgroundColor: backgroundColor ?? context.fitColors.backgroundAlternative,
        appBar: isRemoveAppBar == false
            ? _buildPlatformSpecificAppBar(
                appBar: appBar,
                backgroundColor: backgroundColor,
                context: context,
              )
            : null,
        bottomSheet: bottomSheet,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          bottom: bottom ?? true,
          top: top ?? true,
          child: Padding(
            padding: padding ??
                EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: bottom == true ? MediaQuery.of(context).padding.bottom : 0.0,
                ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                // topStart 정렬을 유지하기 위해 Align 추가
                return FadeTransition(
                  opacity: animation,
                  child: Align(
                    alignment: Alignment.topLeft, // Always align to topStart
                    child: child,
                  ),
                );
              },
              child: isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(key: const ValueKey('loading'), child: loadingView),
                        const SizedBox(height: 56),
                      ],
                    )
                  : SizedBox(key: const ValueKey('body'), child: body),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildPlatformSpecificAppBar({
    PreferredSizeWidget? appBar,
    Color? backgroundColor,
    required BuildContext context,
  }) {
    if (Platform.isAndroid) {
      return appBar ??
          FitEmptyAppBar(
            backgroundColor ?? context.fitColors.backgroundAlternative,
          );
    } else if (Platform.isIOS) {
      return appBar;
    }
    return appBar;
  }
}

class FitEmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color statusBarColor;
  final Color systemNavigationBarColor;
  final Color backgroundColor;

  const FitEmptyAppBar(
    Color color, {
    super.key,
  })  : statusBarColor = color,
        backgroundColor = color,
        systemNavigationBarColor = color;

  const FitEmptyAppBar.navigationBarColors({
    super.key,
    required this.statusBarColor,
    required this.systemNavigationBarColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}

abstract class FitCustomAppBar {
  static AppBar leadingAppBar(
    BuildContext context, {
    String title = "",
    Function0? onPressed,
    Widget? leadingIcon,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? titleColor, // 텍스트 컬러 추가
    bool centerTitle = false,
    bool leftAlignTitle = true,
  }) {
    return AppBar(
      toolbarHeight: 56,
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: backgroundColor ?? context.fitColors.backgroundAlternative,
        isDark: context.fitThemeMode.isDarkMode,
        systemNavigationBarColor: backgroundColor ?? context.fitColors.backgroundAlternative,
      ),
      backgroundColor: backgroundColor ?? context.fitColors.backgroundAlternative,
      leading: IconButton(
        icon: leadingIcon ?? ChipAssets.icons.icArrowLeft.svg(color: context.fitColors.grey900),
        onPressed: onPressed ?? () => Navigator.pop(context, true),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 24,
      ),
      title: Text(
        title,
        style: context.subtitle2().copyWith(color: titleColor ?? context.fitColors.grey900),
      ),
      centerTitle: centerTitle,
      titleSpacing: leftAlignTitle ? 0.0 : NavigationToolbar.kMiddleSpacing,
      actions: actions,
    );
  }
}
