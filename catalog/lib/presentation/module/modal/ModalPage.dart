import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_dialog.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class ModalPage extends StatelessWidget {
  const ModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitDialog 테스트",
        actions: [],
      ),
      bottom: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: "1. 에러 대화상자 테스트",
              description: "간단한 에러 메시지를 표시합니다.",
              actions: [
                FitButton(
                  onPress: () {
                    FitDialog.makeErrorDialog(
                      context: context,
                      message: "에러가 발생했습니다!",
                      description: "이 작업을 수행할 수 없습니다.",
                      onPress: () => print("확인 버튼 클릭됨"),
                    ).show();
                  },
                  isExpand: true,
                  text: "에러 대화상자 표시",
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "2. 기본 대화상자 테스트",
              description: "확인 및 취소 버튼을 포함한 기본 대화상자입니다.",
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FitDialog.makeFitDialog(
                      context: context,
                      title: "기본 대화상자",
                      subTitle: "이 대화상자는 기본 스타일을 따릅니다.",
                      btnOkText: "확인",
                      btnOkPressed: () => print("확인 버튼 클릭됨"),
                      btnCancelText: "취소",
                      btnCancelPressed: () => print("취소 버튼 클릭됨"),
                    ).show();
                  },
                  child: const Text("기본 대화상자 표시"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: "3. 커스텀 대화상자 테스트",
              description: "사용자 지정 스타일 및 콘텐츠를 가진 대화상자입니다.",
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FitDialog.makeFitDialog(
                      context: context,
                      title: "커스텀 대화상자",
                      subTitle: "커스텀 스타일과 버튼 색상을 테스트합니다.",
                      btnOkText: "확인",
                      btnOkPressed: () => print("확인 버튼 클릭됨"),
                      btnCancelText: "취소",
                      btnCancelPressed: () => print("취소 버튼 클릭됨"),
                      topContent: const Icon(Icons.info, size: 60, color: Colors.blue),
                      bottomContent: const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Text("추가 정보가 여기에 표시됩니다."),
                      ),
                    );
                  },
                  child: const Text("커스텀 대화상자 표시"),
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title),
            const SizedBox(height: 8),
            Text(
              description,
              style: context.body1().copyWith(color: context.fitColors.grey500),
            ),
            const SizedBox(height: 16),
            ...actions,
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.ac_unit, color: context.fitColors.main, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: context.h2().copyWith(color: context.fitColors.grey100),
        ),
      ],
    );
  }
}
