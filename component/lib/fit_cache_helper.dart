import 'dart:io';

import 'package:component/image/fit_cached_network_Image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http; // http 패키지 추가

/// 통합 캐시 헬퍼 클래스
class FitCacheHelper {
  FitCacheHelper._();

  /// 캐시 매니저 맵 (만료 시간별로 관리)
  static final Map<Duration, CacheManager> _cacheManagers = {};

  /// 기본 캐시 매니저 가져오기 또는 생성
  static CacheManager _getCacheManager(Duration? stalePeriod) {
    // stalePeriod가 없으면 기본 캐시 매니저 사용
    if (stalePeriod == null) {
      return FitCachedNetworkImage.cacheManager;
    }

    // 이미 생성된 캐시 매니저가 있으면 반환
    if (_cacheManagers.containsKey(stalePeriod)) {
      return _cacheManagers[stalePeriod]!;
    }

    // 새로운 캐시 매니저 생성
    final key = 'cache_${stalePeriod.inSeconds}s';
    final manager = CacheManager(
      Config(
        key,
        stalePeriod: stalePeriod,
        maxNrOfCacheObjects: 200,
        repo: JsonCacheInfoRepository(databaseName: key),
      ),
    );

    _cacheManagers[stalePeriod] = manager;
    debugPrint('FitCacheHelper: 새 캐시 매니저 생성 - $key (${stalePeriod.inHours}시간)');
    return manager;
  }

  /// [수정됨] URL에서 파일 다운로드 및 캐시
  ///
  /// Lottie 파일(.json) 등 서버 헤더 문제로 캐시되지 않는 파일을 위해
  /// http.get()으로 직접 다운로드 후 putFile()로 캐시에 저장하는 방식으로 변경
  ///
  /// [url] 다운로드할 URL
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
        // 캐시가 유효하면 (stalePeriod 이내)
        debugPrint('FitCacheHelper: 캐시 히트 - ${fileInfo.file.path}');
        return fileInfo.file;
      }

      // 캐시가 없거나 만료되었으면 수동 다운로드
      debugPrint('FitCacheHelper: 수동 다운로드 시작 (HTTP GET) - $url');
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 30),
          );

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        // [수정] 수정된 확장자 추출 함수 사용
        final String fileExtension = _extractFileExtension(url);

        // 다운로드한 바이트를 캐시 매니저에 직접 주입
        final file = await cacheManager.putFile(
          url,
          bytes,
          fileExtension: fileExtension,
          // eTag: response.headers['etag'], // ETag가 있다면 제공
        );

        debugPrint('FitCacheHelper: 다운로드 및 캐시 저장 완료 (${fileExtension}) - ${file.path}');
        return file;
      } else {
        debugPrint('FitCacheHelper: 다운로드 실패 (HTTP ${response.statusCode}) - $url');
        // 다운로드 실패 시 기존 캐시가 있다면 삭제 시도
        await cacheManager.removeFile(url);
        return null;
      }
    } catch (e) {
      debugPrint('FitCacheHelper: 다운로드/캐시 실패 - $e');
      return null;
    }
  }

  /// [⭐️ 수정됨] URL에서 파일 확장자 추출 (e.g., "json", "png", "lottie")
  ///
  /// 기존 로직은 URL의 마지막 경로 세그먼트(pathSegments.last)만 확인하여
  /// 확장자가 없는 URL(e.g., /api/getLottie)에 대응하지 못했습니다.
  ///
  /// 수정된 로직:
  /// 1. URL의 전체 'path' (e.g., /api/resource.json)에서 확장자를 먼저 찾습니다.
  /// 2. 'path'에 확장자가 없다면, '전체 URL' (쿼리 파라미터 포함)에서 힌트를 찾습니다.
  ///    (e.g., ?type=lottie, ?format=json)
  static String _extractFileExtension(String url) {
    try {
      final uri = Uri.parse(url);
      // 1. 쿼리 파라미터가 제외된 'path' (e.g., /path/to/file.json)
      final String path = uri.path;

      // 2. path에서 마지막 '.'의 위치를 찾습니다.
      final int extensionIndex = path.lastIndexOf('.');

      // 3. '.'이 존재하고, path의 마지막 글자가 아닌 경우
      if (extensionIndex != -1 && extensionIndex < path.length - 1) {
        // 4. 확장자 부분만 추출 (e.g., "json")
        String extension = path.substring(extensionIndex + 1);

        // 5. 확장자에 '/'가 포함되어 있지 않은지 확인 (e.g. /path/file.v1/other)
        if (!extension.contains('/')) {
          debugPrint('FitCacheHelper: Path에서 확장자 찾음: $extension');
          return extension.toLowerCase();
        }
      }
    } catch (e) {
      debugPrint('FitCacheHelper: URI path에서 확장자 추출 실패 (URL: $url) - $e');
    }

    // 6. Path에서 확장자를 못찾은 경우, URL 전체(쿼리 파라미터 포함)에서 힌트를 찾습니다.
    final lowerUrl = url.toLowerCase();

    // .lottie 힌트 (바이너리 Lottie)
    if (lowerUrl.contains('.lottie') ||
        lowerUrl.contains('format=lottie') ||
        lowerUrl.contains('type=lottie')) {
      debugPrint('FitCacheHelper: URL 힌트에서 "lottie" 확장자 찾음');
      return 'lottie';
    }

    // .json 힌트 (JSON Lottie)
    if (lowerUrl.contains('.json') ||
        lowerUrl.contains('format=json') ||
        lowerUrl.contains('type=json')) {
      debugPrint('FitCacheHelper: URL 힌트에서 "json" 확장자 찾음');
      return 'json';
    }

    // 7. 힌트도 없으면 'bin' (바이너리)로 처리
    debugPrint('FitCacheHelper: 확장자를 알 수 없어 "bin"으로 처리 - $url');
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

  // ... (removeFromCache, clearCache, clearAllCaches, preloadFiles, getCachedFilePath, touchCache 함수 동일) ...
  // ... (FitCacheMixin 동일) ...

  /// 특정 URL 캐시 삭제
  static Future<void> removeFromCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      final cacheManager = _getCacheManager(stalePeriod);
      await cacheManager.removeFile(url);
      debugPrint('FitCacheHelper: 캐시 삭제 완료 - $url');
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 삭제 실패 - $e');
    }
  }

  /// 모든 캐시 삭제 (특정 만료 시간의 캐시만 삭제)
  static Future<void> clearCache({Duration? stalePeriod}) async {
    try {
      final cacheManager = _getCacheManager(stalePeriod);
      await cacheManager.emptyCache();
      debugPrint('FitCacheHelper: 캐시 삭제 완료 (stalePeriod: $stalePeriod)');
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 삭제 실패 - $e');
    }
  }

  /// 모든 캐시 매니저의 캐시 삭제
  static Future<void> clearAllCaches() async {
    try {
      // 기본 캐시 매니저
      await FitCachedNetworkImage.cacheManager.emptyCache();

      // 생성된 모든 캐시 매니저
      for (final manager in _cacheManagers.values) {
        await manager.emptyCache();
      }
      _cacheManagers.clear(); // 맵에서도 제거

      debugPrint('FitCacheHelper: 전체 캐시 삭제 완료');
    } catch (e) {
      debugPrint('FitCacheHelper: 전체 캐시 삭제 실패 - $e');
    }
  }

  /// 여러 URL 일괄 다운로드 (프리로드)
  static Future<Map<String, File?>> preloadFiles(
    List<String> urls, {
    Duration? stalePeriod,
  }) async {
    final results = <String, File?>{};

    // Future.wait를 사용하면 병렬 처리가 가능합니다.
    await Future.wait(
      urls.map((url) async {
        results[url] = await downloadAndCache(url, stalePeriod: stalePeriod);
      }),
    );

    return results;
  }

  /// 캐시된 파일 경로 가져오기
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

  /// 캐시 만료 시간 갱신 (파일을 다시 다운로드하여 덮어쓰기)
  static Future<void> touchCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      // downloadAndCache가 이미 '다운로드 및 덮어쓰기' 로직을 포함하므로
      // 이를 호출하는 것만으로 갱신(touch) 효과가 있습니다.
      await downloadAndCache(url, stalePeriod: stalePeriod);
    } catch (e) {
      debugPrint('FitCacheHelper: 캐시 갱신 실패 - $e');
    }
  }
}

/// 캐시 상태를 추적하는 Mixin
mixin FitCacheMixin {
  /// URL에서 파일 다운로드 및 캐시
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

  /// 특정 URL 캐시 삭제
  Future<void> removeFileFromCache(
    String url, {
    Duration? stalePeriod,
  }) =>
      FitCacheHelper.removeFromCache(url, stalePeriod: stalePeriod);

  /// 캐시 삭제
  Future<void> clearFileCache({Duration? stalePeriod}) =>
      FitCacheHelper.clearCache(stalePeriod: stalePeriod);
}
