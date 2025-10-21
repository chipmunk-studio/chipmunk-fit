import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_bottomsheet.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitBottomSheet 테스트",
        actions: [],
      ),
      bottom: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: "기본 바텀시트 테스트",
              description: "기본 바텀시트를 열어 다양한 설정을 테스트합니다.",
              actions: [
                _buildActionButton(
                  context,
                  label: "기본 바텀시트 열기",
                  description: "상단 바와 닫기 버튼이 포함된 기본 바텀시트를 테스트합니다.",
                  onPressed: () {
                    FitBottomSheet.show(
                      context,
                      isShowTopBar: true,
                      content: (bottomSheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "기본 바텀시트",
                                style: context.h2(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "이 바텀시트는 상단 바와 닫기 버튼이 포함되어 있습니다.",
                                style: context.body1().copyWith(color: context.fitColors.grey300),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                                child: const Text("닫기"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  label: "닫기 버튼 없는 바텀시트",
                  description: "닫기 버튼을 제거한 바텀시트를 테스트합니다.",
                  onPressed: () {
                    FitBottomSheet.show(
                      context,
                      isShowCloseButton: false,
                      isDismissible: false,
                      content: (bottomSheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "닫기 버튼 없는 바텀시트",
                                style: context.h2(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "닫기 버튼과 외부 탭으로 닫을 수 없습니다.",
                                style: context.body1().copyWith(color: context.fitColors.grey300),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(bottomSheetContext);
                                },
                                child: const Text("닫기"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "풀스크린 바텀시트 테스트",
              description: "스크롤 가능한 풀스크린 바텀시트를 테스트합니다.",
              actions: [
                _buildActionButton(
                  context,
                  label: "풀스크린 바텀시트 열기",
                  description: "스크롤 가능한 콘텐츠를 포함한 풀스크린 바텀시트를 테스트합니다.",
                  onPressed: () {
                    FitBottomSheet.showFull(
                      context,
                      topContent: (bottomSheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "풀스크린 바텀시트",
                                style: context.h2(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "스크롤 가능한 콘텐츠를 포함합니다.",
                                style: context.body1().copyWith(color: context.fitColors.grey300),
                              ),
                            ],
                          ),
                        );
                      },
                      scrollContent: (scrollContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              20,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "항목 ${index + 1}",
                                  style: context.body1().copyWith(color: context.fitColors.grey100),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  label: "50% 크기의 풀스크린 바텀시트",
                  description: "50% 높이의 풀스크린 바텀시트를 테스트합니다.",
                  onPressed: () {
                    FitBottomSheet.showFull(
                      context,
                      heightFactor: 0.5,
                      isShowCloseButton: true,
                      isShowTopBar: true,
                      topContent: (bottomSheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "50% 풀스크린 바텀시트",
                            style: context.h2(),
                          ),
                        );
                      },
                      scrollContent: (scrollContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: List.generate(
                              10,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.label, color: context.fitColors.main),
                                    const SizedBox(width: 8),
                                    Text(
                                      "옵션 ${index + 1}",
                                      style: context
                                          .body1()
                                          .copyWith(color: context.fitColors.grey100),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              context,
              title: "드래그 가능한 바텀시트 테스트",
              description: "드래그 동작을 지원하는 바텀시트를 테스트합니다.",
              actions: [
                _buildActionButton(
                  context,
                  label: "드래그 바텀시트 열기",
                  description: "사용자가 크기를 조정할 수 있는 드래그 가능한 바텀시트를 테스트합니다.",
                  onPressed: () {
                    FitBottomSheet.showDraggable(
                      context,
                      initialHeightFactor: 0.4,
                      topContent: (bottomSheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "드래그 가능한 바텀시트",
                                style: context.h2(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "드래그하여 크기를 조정할 수 있습니다.",
                                style: context.body1().copyWith(color: context.fitColors.grey300),
                              ),
                            ],
                          ),
                        );
                      },
                      scrollContent: (scrollContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: List.generate(
                              15,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.list, color: context.fitColors.main),
                                    const SizedBox(width: 8),
                                    Text(
                                      "항목 ${index + 1}",
                                      style: context
                                          .body1()
                                          .copyWith(color: context.fitColors.grey100),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String description,
    required List<Widget> actions,
  }) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title),
            const SizedBox(height: 12),
            Text(
              description,
              style: context.body1().copyWith(color: context.fitColors.grey500),
            ),
            const SizedBox(height: 20),
            ...actions,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.format_align_center, color: context.fitColors.main, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey100),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required String description,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: context.body1().copyWith(color: context.fitColors.grey400),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
