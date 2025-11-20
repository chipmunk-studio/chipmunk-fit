import 'dart:async';

import 'package:http/http.dart' as http;

/// 타임아웃이 적용된 HTTP 클라이언트
class FitHttpClientWithTimeout extends http.BaseClient {
  final http.Client _inner;
  final Duration timeout;

  FitHttpClientWithTimeout({
    http.Client? client,
    this.timeout = const Duration(seconds: 30),
  }) : _inner = client ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Connection'] = 'keep-alive';

    return _inner.send(request).timeout(
          timeout,
          onTimeout: () => throw TimeoutException(
            'Connection timeout after ${timeout.inSeconds}s',
          ),
        );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
