import 'dart:io';

import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FitScaffold extends StatelessWidget {
  final Widget body;
  final bool? bottom;
  final bool? top;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;
  final Widget? bottomSheet;
  final EdgeInsets? padding;

  const FitScaffold({
    super.key,
    required this.body,
    this.bottom,
    this.top,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
    this.backgroundColor,
    this.bottomSheet,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.fitColors.grey900,
      appBar: _buildPlatformSpecificAppBar(
        appBar: appBar,
        backgroundColor: backgroundColor,
        context: context,
      ),
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
          child: body,
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
            backgroundColor ?? context.fitColors.grey900,
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

  const FitEmptyAppBar(
    Color color, {
    super.key,
  })  : statusBarColor = color,
        systemNavigationBarColor = color;

  const FitEmptyAppBar.navigationBarColors({
    super.key,
    required this.statusBarColor,
    required this.systemNavigationBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        isDark: isDarkMode(context),
        systemNavigationBarColor: systemNavigationBarColor,
      ),
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
    bool centerTitle = false,
    bool leftAlignTitle = true,
  }) {
    return AppBar(
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: backgroundColor ?? context.fitColors.grey900,
        isDark: isDarkMode(context),
        systemNavigationBarColor: backgroundColor ?? context.fitColors.grey900,
      ),
      backgroundColor: backgroundColor ?? context.fitColors.grey900,
      leading: IconButton(
        icon: leadingIcon ?? Assets.icons.icArrowLeft.svg(color: context.fitColors.grey100),
        onPressed: onPressed ?? () => Navigator.pop(context, true),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 24,
      ),
      title: Text(
        title,
        style: context.subTitle2Medium(color: context.fitColors.grey100),
      ),
      centerTitle: centerTitle,
      titleSpacing: leftAlignTitle ? 0.0 : NavigationToolbar.kMiddleSpacing,
      actions: actions,
    );
  }
}
