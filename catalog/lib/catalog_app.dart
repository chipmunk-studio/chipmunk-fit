import 'package:chipfit/foundation/theme.dart';
import 'package:chipmunk_fit_catalog/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogApp extends StatelessWidget {
  const CatalogApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: false,
      minTextAdapt: true,
      rebuildFactor: RebuildFactors.change,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          routerConfig: catalogRouter,
          debugShowCheckedModeBanner: false,
          theme: fitLightTheme(context),
          darkTheme: fitDarkTheme(context),
          themeMode: ThemeMode.dark,
        );
      },
    );
  }
}
