import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/foundation/buttonstyle.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_dialog.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;

    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitDialog",
        actions: [],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(context, '기본 다이얼로그', [
            _buildDialogTest(
              context,
              '확인만 있는 다이얼로그',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '알림',
                subTitle: '이것은 확인 버튼만 있는 다이얼로그입니다.',
                btnOkText: '확인',
                btnOkPressed: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              '확인 + 취소 다이얼로그',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '확인 필요',
                subTitle: '이 작업을 계속하시겠습니까?',
                btnOkText: '확인',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, '에러 다이얼로그', [
            _buildDialogTest(
              context,
              '기본 에러',
              () => FitDialog.makeErrorDialog(
                context: context,
                message: '에러 발생',
                description: '작업을 수행하는 중 오류가 발생했습니다.',
                onPress: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              '커스텀 버튼 색상',
              () => FitDialog.makeErrorDialog(
                context: context,
                message: '심각한 오류',
                description: '시스템 오류가 발생했습니다.',
                btnOkColor: colors.red500,
                onPress: () {},
              ).show(),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, '커스텀 콘텐츠', [
            _buildDialogTest(
              context,
              '아이콘 포함',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '성공',
                subTitle: '작업이 성공적으로 완료되었습니다.',
                topContent: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Icon(
                    Icons.check_circle,
                    size: 60,
                    color: colors.green500,
                  ),
                ),
                btnOkText: '확인',
                btnOkPressed: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              '하단 추가 정보',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '주의',
                subTitle: '이 작업은 되돌릴 수 없습니다.',
                bottomContent: Container(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '* 삭제된 데이터는 복구할 수 없습니다.',
                    style: context.caption1().copyWith(
                          color: colors.red500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                btnOkText: '삭제',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, '버튼 타입', [
            _buildDialogTest(
              context,
              'Primary 버튼',
              () => FitDialog.makeFitDialog(
                context: context,
                title: 'Primary',
                subTitle: 'Primary 타입 버튼',
                okButtonType: FitButtonType.primary,
                btnOkText: '확인',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              'Secondary 버튼',
              () => FitDialog.makeFitDialog(
                context: context,
                title: 'Secondary',
                subTitle: 'Secondary 타입 버튼',
                okButtonType: FitButtonType.secondary,
                btnOkText: '확인',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              'Destructive 버튼',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '삭제',
                subTitle: '정말 삭제하시겠습니까?',
                okButtonType: FitButtonType.destructive,
                btnOkText: '삭제',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, '외부 터치 옵션', [
            _buildDialogTest(
              context,
              '외부 터치로 닫기',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '외부 터치 가능',
                subTitle: '다이얼로그 외부를 터치하면 닫힙니다.',
                dismissOnTouchOutside: true,
                btnOkText: '확인',
                btnOkPressed: () {},
              ).show(),
            ),
            const SizedBox(height: 12),
            _buildDialogTest(
              context,
              '뒤로가기로 닫기',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '뒤로가기 가능',
                subTitle: '뒤로가기 버튼으로 닫을 수 있습니다.',
                dismissOnBackKeyPress: true,
                btnOkText: '확인',
                btnOkPressed: () {},
              ).show(),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(context, '긴 텍스트', [
            _buildDialogTest(
              context,
              '긴 내용',
              () => FitDialog.makeFitDialog(
                context: context,
                title: '이용약관',
                subTitle: '본 약관은 회사가 제공하는 서비스의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다. '
                    '이용자는 본 약관에 동의함으로써 서비스를 이용할 수 있습니다.',
                btnOkText: '동의',
                btnOkPressed: () {},
                btnCancelText: '취소',
                btnCancelPressed: () {},
              ).show(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            title,
            style: context.subtitle3().copyWith(
                  color: context.fitColors.textPrimary,
                ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDialogTest(BuildContext context, String label, VoidCallback onPressed) {
    return FitButton(
      onPressed: onPressed,
      isExpanded: true,
      type: FitButtonType.secondary,
      child: Text(
        label,
        style: context.button1().copyWith(
              color: FitButtonStyle.textColorOf(
                context,
                FitButtonType.secondary,
                isEnabled: true,
              ),
            ),
      ),
    );
  }
}
