import 'dart:io';

import 'package:component/image/fit_cached_network_Image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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

  /// URL에서 파일 다운로드 및 캐시
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
        debugPrint('FitCacheHelper: 캐시 히트 - ${fileInfo.file.path}');
        return fileInfo.file;
      }

      // 다운로드
      debugPrint('FitCacheHelper: 다운로드 시작 - $url');
      final file = await cacheManager.getSingleFile(url);
      debugPrint('FitCacheHelper: 다운로드 완료 - ${file.path}');
      return file;
    } catch (e) {
      debugPrint('FitCacheHelper: 다운로드 실패 - $e');
      return null;
    }
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
      debugPrint('FitCacheHelper: 캐시 삭제 완료');
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

  /// 캐시 만료 시간 갱신
  static Future<void> touchCache(
    String url, {
    Duration? stalePeriod,
  }) async {
    try {
      final cacheManager = _getCacheManager(stalePeriod);
      await cacheManager.downloadFile(url);
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
