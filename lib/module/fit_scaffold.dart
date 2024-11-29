import 'package:chipmunk_fit/fit/assets.gen.dart';
import 'package:chipmunk_fit/foundation/colors.dart';
import 'package:chipmunk_fit/foundation/textstyle.dart';
import 'package:chipmunk_fit/foundation/theme.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FitScaffold extends StatelessWidget {
  final Widget body;
  final bool? bottom;
  final bool? top;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool isRemoveAppBar;
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
    this.isRemoveAppBar = false,
    this.bottomSheet,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.fitColors.grey900,
      appBar: appBar ?? FitEmptyAppBar(backgroundColor ?? context.fitColors.grey900),
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Padding(
        padding: padding ??
            EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: bottom == true ? MediaQuery.of(context).padding.bottom : 0.0,
            ),
        child: body,
      ),
    );
  }
}

class FitEmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;

  const FitEmptyAppBar(
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: customSystemUiOverlayStyle(
        statusBarColor: color,
        isDark: isDarkMode(context),
        systemNavigationBarColor: color,
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
        icon: leadingIcon ?? Assets.icons.icArrowLeft.svg(color: context.fitColors.grey900),
        onPressed: onPressed ?? () => Navigator.pop(context, true),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 24,
      ),
      title: Text(
        title,
        style: context.subTitle1Medium(color: context.fitColors.grey900),
      ),
      centerTitle: centerTitle,
      titleSpacing: leftAlignTitle ? 0.0 : NavigationToolbar.kMiddleSpacing,
      actions: actions,
    );
  }
}
