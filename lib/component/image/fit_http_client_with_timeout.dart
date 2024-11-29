import 'dart:async';

import 'package:http/http.dart' as http;

class FitHttpClientWithTimeout extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Connection'] = 'keep-alive';
    return _inner.send(request).timeout(const Duration(seconds: 30), onTimeout: () {
      throw TimeoutException("Connection timeout");
    });
  }
}
