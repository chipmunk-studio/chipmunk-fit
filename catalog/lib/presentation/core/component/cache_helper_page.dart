import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/core/fit_cache_helper.dart';
import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

/// FitCacheHelper 테스트 페이지
class CacheHelperPage extends StatefulWidget {
  const CacheHelperPage({super.key});

  @override
  State<CacheHelperPage> createState() => _CacheHelperPageState();
}

class _CacheHelperPageState extends State<CacheHelperPage> {
  final TextEditingController _urlController = TextEditingController();
  String _status = '대기 중...';
  String? _cachedPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 테스트용 기본 URL (Lottie JSON 예시)
    _urlController.text = 'https://lottie.host/embed/xyz/animation.json';
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _downloadAndCache() async {
    if (_urlController.text.isEmpty) {
      setState(() => _status = '❌ URL을 입력하세요');
      return;
    }

    setState(() {
      _isLoading = true;
      _status = '⏳ 다운로드 중...';
      _cachedPath = null;
    });

    try {
      final file = await FitCacheHelper.downloadAndCache(_urlController.text);

      setState(() {
        _isLoading = false;
        if (file != null) {
          _status = '✅ 다운로드 완료';
          _cachedPath = file.path;
        } else {
          _status = '❌ 다운로드 실패';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _status = '❌ 오류: $e';
      });
    }
  }

  Future<void> _checkCache() async {
    if (_urlController.text.isEmpty) return;

    setState(() => _isLoading = true);

    final isCached = await FitCacheHelper.isCached(_urlController.text);

    setState(() {
      _isLoading = false;
      _status = isCached ? '✅ 캐시 존재' : '❌ 캐시 없음';
    });
  }

  Future<void> _clearCache() async {
    setState(() => _isLoading = true);

    await FitCacheHelper.clearAllCaches();

    setState(() {
      _isLoading = false;
      _status = '🗑️ 전체 캐시 삭제 완료';
      _cachedPath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "Cache Helper",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FitCacheHelper 테스트',
              style: context.h2().copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              '파일 다운로드 및 캐싱 기능을 테스트합니다',
              style: context.body2().copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: 32),

            // URL 입력
            Text(
              'URL',
              style: context.subtitle5().copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'https://example.com/file.json',
                hintStyle: TextStyle(color: colors.textTertiary),
                filled: true,
                fillColor: colors.backgroundElevated,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: context.body2().copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 24),

            // 상태 표시
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.backgroundElevated,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상태',
                    style: context.subtitle6().copyWith(color: colors.textTertiary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _status,
                    style: context.body2().copyWith(color: colors.textPrimary),
                  ),
                  if (_cachedPath != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      '캐시 경로',
                      style: context.subtitle6().copyWith(color: colors.textTertiary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _cachedPath!,
                      style: context.caption1().copyWith(color: colors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 버튼들
            FitButton(
              type: FitButtonType.primary,
              isExpanded: true,
              isEnabled: !_isLoading,
              isLoading: _isLoading,
              onPressed: _downloadAndCache,
              child: Text('다운로드 및 캐시'),
            ),
            const SizedBox(height: 12),
            FitButton(
              type: FitButtonType.secondary,
              isExpanded: true,
              isEnabled: !_isLoading,
              onPressed: _checkCache,
              child: Text('캐시 확인'),
            ),
            const SizedBox(height: 12),
            FitButton(
              type: FitButtonType.destructive,
              isExpanded: true,
              isEnabled: !_isLoading,
              onPressed: _clearCache,
              child: Text('전체 캐시 삭제'),
            ),
          ],
        ),
      ),
    );
  }
}
