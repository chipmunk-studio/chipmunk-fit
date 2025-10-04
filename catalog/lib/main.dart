// main.dart
import 'dart:async';
import 'dart:io';

import 'package:catalog/router.dart';
import 'package:chipfit/foundation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runZonedGuarded(
    () async {
      // Flutter 에러 핸들러 설정
      _setupErrorHandler();

      runApp(const CatalogApp());
    },
    (error, stack) {
      // Zone 레벨 에러 처리
      debugPrint('Uncaught error: $error');
      debugPrint('Stack trace: $stack');
    },
  );
}

/// Flutter 에러 핸들러 설정
void _setupErrorHandler() {
  final originalOnError = FlutterError.onError;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (_shouldIgnoreError(details.exception)) {
      return;
    }

    originalOnError?.call(details);
  };
}

/// 무시해야 할 에러인지 확인
bool _shouldIgnoreError(Object exception) {
  return exception is OSError ||
      exception is HandshakeException ||
      exception is SocketException ||
      exception.runtimeType.toString() == '_Exception';
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 상태바 스타일 설정
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: false,
      minTextAdapt: true,
      rebuildFactor: RebuildFactors.change,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ChipFit Design System',
          routerConfig: catalogRouter,
          debugShowCheckedModeBanner: false,
          theme: fitLightTheme(context),
          darkTheme: fitDarkTheme(context),
          themeMode: ThemeMode.light,
          // 기본 라이트 모드
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
