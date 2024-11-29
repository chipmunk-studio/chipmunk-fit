import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'catalog_app.dart';

void main() {
  runZonedGuarded(
    () async {
      final onError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exception is! OSError &&
            details.exception is! HandshakeException &&
            !(details.exception.runtimeType.toString() == '_Exception') &&
            details.exception is! SocketException) {
          if (onError != null) {
            onError(details);
          }
        }
      };

      runApp(CatalogApp());
    },
    (error, stack) {},
  );
}
