import 'package:chip_component/button/fit_button.dart';
import 'package:chip_core/fit_delta_viewer.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';
import 'package:chip_module/scaffold/fit_app_bar.dart';
import 'package:chip_module/scaffold/fit_scaffold.dart';
import 'package:flutter/material.dart';

/// FitDeltaViewer 테스트 페이지
class DeltaViewerPage extends StatefulWidget {
  const DeltaViewerPage({super.key});

  @override
  State<DeltaViewerPage> createState() => _DeltaViewerPageState();
}

class _DeltaViewerPageState extends State<DeltaViewerPage> {
  int _sampleIndex = 0;

  // 테스트용 Delta JSON 샘플
  final List<Map<String, dynamic>> _samples = [
    {
      'name': '기본 텍스트',
      'delta': '{"ops":[{"insert":"안녕하세요!\\nFitDeltaViewer 테스트입니다.\\n"}]}',
    },
    {
      'name': '서식 포함',
      'delta':
          '{"ops":[{"insert":"볼드체","attributes":{"bold":true}},{"insert":" 와 "},{"insert":"이탤릭","attributes":{"italic":true}},{"insert":"\\n"}]}',
    },
    {
      'name': '제목 + 본문',
      'delta':
          '{"ops":[{"insert":"제목입니다","attributes":{"header":1}},{"insert":"\\n본문 내용입니다.\\n"}]}',
    },
  ];

  String get _currentDelta => _samples[_sampleIndex]['delta'] as String;

  String get _currentName => _samples[_sampleIndex]['name'] as String;

  void _nextSample() {
    setState(() {
      _sampleIndex = (_sampleIndex + 1) % _samples.length;
    });
  }

  void _previousSample() {
    setState(() {
      _sampleIndex = (_sampleIndex - 1 + _samples.length) % _samples.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitLeadingAppBar(
        title: "Delta Viewer",
        actions: [],
      ),
      body: Column(
        children: [
          // 헤더
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: colors.backgroundElevated,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FitDeltaViewer 테스트',
                  style: context.h2().copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Quill Delta JSON 뷰어 기능을 테스트합니다',
                  style: context.body2().copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 샘플 선택
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                FitButton(
                  type: FitButtonType.secondary,
                  onPressed: _previousSample,
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.backgroundElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _currentName,
                        style: context.subtitle5().copyWith(color: colors.textPrimary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FitButton(
                  type: FitButtonType.secondary,
                  onPressed: _nextSample,
                  child: const Icon(Icons.arrow_forward, size: 20),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Delta JSON 원본
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
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
                    'Delta JSON',
                    style: context.subtitle6().copyWith(color: colors.textTertiary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentDelta,
                    style: context.caption1().copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 뷰어 미리보기
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
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
                      '렌더링 결과',
                      style: context.subtitle6().copyWith(color: colors.textTertiary),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.backgroundBase,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FitDeltaViewer(
                          deltaJson: _currentDelta,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
