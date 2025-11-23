import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

/// 파일 다운로드 및 캐싱을 관리하는 헬퍼 클래스
///
/// - 여러 만료 시간(stalePeriod)별로 독립적인 캐시 매니저를 관리
/// - HTTP GET으로 직접 다운로드 후 캐시에 저장 (헤더 문제 우회)
/// - URL에서 파일 확장자 자동 추출
class FitCacheHelper {
  FitCacheHelper._();

  // 기본 캐시 매니저 (30일 만료)
  static final CacheManager _defaultCacheManager = CacheManager(
    Config(
      'fit_cache_default',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: 'fit_cache_default'),
    ),
  );

  // 만료 시간별 캐시 매니저 맵
  static final Map<Duration, CacheManager> _cacheManagers = {};

  /// stalePeriod에 맞는 캐시 매니저 반환
  static CacheManager _getCacheManager(Duration? stalePeriod) {
    if (stalePeriod == null) return _defaultCacheManager;

    return _cacheManagers.putIfAbsent(stalePeriod, () {
      final key = 'fit_cache_${stalePeriod.inSeconds}s';
      debugPrint('FitCacheHelper: 새 캐시 매니저 생성 - $key');
      return CacheManager(
        Config(
          key,
          stalePeriod: stalePeriod,
          maxNrOfCacheObjects: 200,
          repo: JsonCacheInfoRepository(databaseName: key),
        ),
      );
    });
  }

  /// URL에서 파일 다운로드 후 캐시에 저장
  ///
  /// HTTP GET으로 직접 다운로드하여 putFile()로 캐시에 주입하는 방식 사용
  /// (서버 헤더 문제로 인한 캐시 실패를 우회)
  ///
  /// [url] 다운로드할 URL (http/https) 또는 로컬 파일 경로
  /// [stalePeriod] 캐시 만료 시간 (null이면 기본 30일)
  static Future<File?> downloadAndCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      // 로컬 파일은 그대로 반환
      if (!url.startsWith('http')) {
        final file = File(url);
        return file.existsSync() ? file : null;
      }

      final cacheManager = _getCacheManager(stalePeriod);

      // 캐시 확인
      final fileInfo = await cacheManager.getFileFromCache(url);
      if (fileInfo != null) {
        debugPrint('FitCacheHelper: 캐시 히트 - ${fileInfo.file.path}');
        return fileInfo.file;
      }

      // 캐시 미스: HTTP GET으로 다운로드
      debugPrint('FitCacheHelper: 다운로드 시작 - $url');
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 30),
          );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final extension = _extractFileExtension(url);

        // 다운로드한 바이트를 캐시에 주입
        final file = await cacheManager.putFile(
          url,
          bytes,
          fileExtension: extension,
        );

        debugPrint('FitCacheHelper: 캐시 저장 완료 ($extension) - ${file.path}');
        return file;
      } else {
        debugPrint('FitCacheHelper: 다운로드 실패 (${response.statusCode}) - $url');
        await cacheManager.removeFile(url);
        return null;
      }
    } catch (e) {
      debugPrint('FitCacheHelper: 오류 - $e');
      return null;
    }
  }

  /// URL에서 파일 확장자 추출
  ///
  /// 1. path에서 확장자 추출 시도 (예: /path/file.json → "json")
  /// 2. path에 없으면 쿼리 파라미터에서 힌트 탐색 (예: ?type=lottie)
  /// 3. 힌트도 없으면 "bin" 반환
  static String _extractFileExtension(String url) {
    try {
      final uri = Uri.parse(url);
      final path = uri.path;
      final extensionIndex = path.lastIndexOf('.');

      // path에서 확장자 추출
      if (extensionIndex != -1 && extensionIndex < path.length - 1) {
        final extension = path.substring(extensionIndex + 1);
        if (!extension.contains('/')) {
          return extension.toLowerCase();
        }
      }
    } catch (e) {
      debugPrint('FitCacheHelper: 확장자 추출 실패 - $e');
    }

    // 쿼리 파라미터나 URL 전체에서 힌트 탐색
    final lowerUrl = url.toLowerCase();

    if (lowerUrl.contains('.lottie') ||
        lowerUrl.contains('format=lottie') ||
        lowerUrl.contains('type=lottie')) {
      return 'lottie';
    }

    if (lowerUrl.contains('.json') ||
        lowerUrl.contains('format=json') ||
        lowerUrl.contains('type=json')) {
      return 'json';
    }

    // 확장자를 알 수 없으면 바이너리로 처리
    return 'bin';
  }

  /// 캐시 존재 여부 확인
  static Future<bool> isCached(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      if (!url.startsWith('http')) return true;

      final cacheManager = _getCacheManager(stalePeriod);
      final fileInfo = await cacheManager.getFileFromCache(url);
      return fileInfo != null;
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 확인 실패 - $e');
      return false;
    }
  }

  /// 특정 URL 캐시 삭제
  static Future<void> removeFromCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      final cacheManager = _getCacheManager(stalePeriod);
      await cacheManager.removeFile(url);
      debugPrint('FitCacheHelper: 캐시 삭제 - $url');
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 삭제 실패 - $e');
    }
  }

  /// 특정 stalePeriod의 모든 캐시 삭제
  static Future<void> clearCache({Duration? stalePeriod}) async {
    try {
      final cacheManager = _getCacheManager(stalePeriod);
      await cacheManager.emptyCache();
      debugPrint('FitCacheHelper: 캐시 전체 삭제 (stalePeriod: $stalePeriod)');
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 삭제 실패 - $e');
    }
  }

  /// 모든 캐시 매니저의 캐시 삭제
  static Future<void> clearAllCaches() async {
    try {
      await _defaultCacheManager.emptyCache();

      for (final manager in _cacheManagers.values) {
        await manager.emptyCache();
      }
      _cacheManagers.clear();

      debugPrint('FitCacheHelper: 전체 캐시 삭제 완료');
    } catch (e) {
      debugPrint('FitCacheHelper: 전체 캐시 삭제 실패 - $e');
    }
  }

  /// 여러 URL 일괄 다운로드 (병렬 처리)
  static Future<Map<String, File?>> preloadFiles(
    List<String> urls, {
    Duration? stalePeriod,
  }) async {
    final results = <String, File?>{};

    await Future.wait(
      urls.map((url) async {
        results[url] = await downloadAndCache(url, stalePeriod: stalePeriod);
      }),
    );

    return results;
  }

  /// 캐시된 파일 경로 반환
  static Future<String?> getCachedFilePath(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      if (!url.startsWith('http')) return url;

      final cacheManager = _getCacheManager(stalePeriod);
      final fileInfo = await cacheManager.getFileFromCache(url);
      return fileInfo?.file.path;
    } catch (e) {
      debugPrint('FitCacheHelper: 파일 경로 조회 실패 - $e');
      return null;
    }
  }

  /// 캐시 갱신 (재다운로드)
  static Future<void> touchCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      await downloadAndCache(url, stalePeriod: stalePeriod);
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 갱신 실패 - $e');
    }
  }
}

/// 캐시 기능을 위한 Mixin
mixin FitCacheMixin {
  /// 파일 다운로드 및 캐시 후 경로 반환
  Future<String?> downloadAndCacheFile(
    String url, {
    Duration? stalePeriod,
  }) async {
    final file = await FitCacheHelper.downloadAndCache(
      url,
      stalePeriod: stalePeriod,
    );
    return file?.path;
  }

  /// 캐시 존재 여부 확인
  Future<bool> isFileCached(
    String url, {
    Duration? stalePeriod,
  }) =>
      FitCacheHelper.isCached(url, stalePeriod: stalePeriod);

  /// 캐시 삭제
  Future<void> removeFileFromCache(
    String url, {
    Duration? stalePeriod,
  }) =>
      FitCacheHelper.removeFromCache(url, stalePeriod: stalePeriod);

  /// 캐시 전체 삭제
  Future<void> clearFileCache({Duration? stalePeriod}) =>
      FitCacheHelper.clearCache(stalePeriod: stalePeriod);
}
