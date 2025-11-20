import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chip_component/button/fit_button.dart';
import 'package:flutter/material.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:chip_foundation/textstyle.dart';

/// 공통 다이얼로그 생성 유틸리티
class FitDialog {
  /// 에러 메시지를 표시하는 다이얼로그 생성
  ///
  /// [message] - 에러 메시지
  /// [description] - 상세 설명 (제공 시 message 대신 표시)
  /// [onPress] - 확인 버튼 콜백
  /// [onDismissCallback] - 다이얼로그 닫힐 때 콜백
  /// [btnOkColor] - 확인 버튼 배경색 (기본값: mainColor)
  static AwesomeDialog makeErrorDialog({
    required BuildContext context,
    required String message,
    String? description,
    required VoidCallback onPress,
    Function(DismissType)? onDismissCallback,
    Color? dialogBackgroundColor,
    TextStyle? textStyle,
    TextStyle? buttonTextStyle,
    Color? btnOkColor,
    String? btnOkText,
    double borderRadius = 32.0,
  }) {
    final effectiveBtnOkColor = btnOkColor ?? context.fitColors.main;

    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: dialogBackgroundColor ?? context.fitColors.backgroundElevated,
      buttonsTextStyle: buttonTextStyle ?? _getDefaultButtonTextStyle(context),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      onDismissCallback: onDismissCallback,
      body: _buildErrorDialogBody(context, message, description, textStyle),
      padding: const EdgeInsets.only(bottom: 10),
      dialogBorderRadius: BorderRadius.circular(borderRadius),
      btnOkColor: effectiveBtnOkColor,
      btnOkText: btnOkText ?? '확인',
      btnOkOnPress: onPress,
    );
  }

  /// 커스터마이징 가능한 범용 다이얼로그 생성
  ///
  /// [title] - 제목
  /// [subTitle] - 부제목
  /// [btnOkText] - 확인 버튼 텍스트
  /// [btnOkPressed] - 확인 버튼 콜백
  /// [btnCancelPressed] - 취소 버튼 콜백
  /// [topContent] - 상단 커스텀 위젯
  /// [bottomContent] - 하단 커스텀 위젯
  /// [btnOkColor] - 확인 버튼 배경색 (기본값: mainColor)
  /// [btnCancelColor] - 취소 버튼 배경색 (기본값: grey200)
  /// [btnOkTextColor] - 확인 버튼 텍스트 색상 (기본값: staticBlack)
  /// [btnCancelTextColor] - 취소 버튼 텍스트 색상 (기본값: inverseText)
  static AwesomeDialog makeFitDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? btnOkText,
    VoidCallback? btnOkPressed,
    VoidCallback? btnCancelPressed,
    Function(DismissType)? onDismissCallback,
    String? btnCancelText,
    Color? titleTextColor,
    Color? subTitleTextColor,
    bool dismissOnTouchOutside = false,
    bool dismissOnBackKeyPress = false,
    Widget? topContent,
    Widget? bottomContent,
    double borderRadius = 32.0,
    Color? dialogBackgroundColor,
    FitButtonType? okButtonType,
    FitButtonType? cancelButtonType,
    Color? btnOkColor,
    Color? btnCancelColor,
    Color? btnOkTextColor,
    Color? btnCancelTextColor,
  }) {
    return AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: dialogBackgroundColor ?? context.fitColors.backgroundElevated,
      dismissOnTouchOutside: dismissOnTouchOutside,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      onDismissCallback: onDismissCallback,
      body: _buildDialogBody(
        context,
        title: title,
        subTitle: subTitle,
        titleTextColor: titleTextColor,
        subTitleTextColor: subTitleTextColor,
        topContent: topContent,
        bottomContent: bottomContent,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      dialogBorderRadius: BorderRadius.circular(borderRadius),
      btnOk: _buildOkButton(
        context,
        btnOkPressed,
        btnOkText,
        okButtonType,
        btnOkColor,
        btnOkTextColor,
      ),
      btnCancel: _buildCancelButton(
        context,
        btnCancelPressed,
        btnCancelText,
        cancelButtonType,
        btnCancelColor,
        btnCancelTextColor,
      ),
      btnOkOnPress: btnOkPressed,
      btnCancelOnPress: btnCancelPressed,
    );
  }

  /// 에러 다이얼로그 본문 빌드
  static Widget _buildErrorDialogBody(
    BuildContext context,
    String message,
    String? description,
    TextStyle? textStyle,
  ) {
    final displayText = description?.isNotEmpty == true ? description! : message;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            displayText,
            style: textStyle ?? context.body1().copyWith(color: context.fitColors.grey700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// 다이얼로그 본문 빌드
  static Widget _buildDialogBody(
    BuildContext context, {
    String? title,
    String? subTitle,
    Color? titleTextColor,
    Color? subTitleTextColor,
    Widget? topContent,
    Widget? bottomContent,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (topContent != null) topContent,
          if (title != null) ...[
            const SizedBox(height: 20),
            _buildTitle(context, title, titleTextColor),
          ],
          if (subTitle != null) ...[
            const SizedBox(height: 12),
            _buildSubTitle(context, subTitle, subTitleTextColor),
          ],
          if (bottomContent != null) bottomContent,
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// 제목 텍스트 빌드
  static Widget _buildTitle(BuildContext context, String title, Color? titleTextColor) {
    return Text(
      title,
      style: context.h2().copyWith(color: titleTextColor ?? context.fitColors.grey900),
      textAlign: TextAlign.center,
    );
  }

  /// 부제목 텍스트 빌드
  static Widget _buildSubTitle(BuildContext context, String subTitle, Color? subTitleTextColor) {
    return Text(
      subTitle,
      style: context.body1().copyWith(color: subTitleTextColor ?? context.fitColors.grey700),
      textAlign: TextAlign.center,
    );
  }

  /// 확인 버튼 빌드
  static Widget? _buildOkButton(
    BuildContext context,
    VoidCallback? btnOkPressed,
    String? btnOkText,
    FitButtonType? okButtonType,
    Color? btnOkColor,
    Color? btnOkTextColor,
  ) {
    if (btnOkPressed == null && btnOkText == null) return null;

    final effectiveButtonColor = btnOkColor ?? context.fitColors.main;
    final effectiveTextColor = btnOkTextColor ?? context.fitColors.staticBlack;

    return FitButton(
      onPressed: () => _handleButtonPress(context, btnOkPressed),
      type: okButtonType ?? FitButtonType.primary,
      isExpanded: true,
      style: FitButtonStyle.styleFrom(
        backgroundColor: effectiveButtonColor,
      ),
      child: Text(
        btnOkText ?? '확인',
        style: context.button1().copyWith(color: effectiveTextColor),
      ),
    );
  }

  /// 취소 버튼 빌드
  static Widget? _buildCancelButton(
    BuildContext context,
    VoidCallback? btnCancelPressed,
    String? btnCancelText,
    FitButtonType? cancelButtonType,
    Color? btnCancelColor,
    Color? btnCancelTextColor,
  ) {
    if (btnCancelPressed == null && btnCancelText == null) return null;

    final effectiveButtonColor = btnCancelColor ?? context.fitColors.grey200;
    final effectiveTextColor = btnCancelTextColor ?? context.fitColors.inverseText;

    return FitButton(
      type: cancelButtonType ?? FitButtonType.secondary,
      isExpanded: true,
      isEnabled: false,
      style: FitButtonStyle.styleFrom(
        backgroundColor: effectiveButtonColor,
      ),
      onDisabledPressed: () => _handleButtonPress(context, btnCancelPressed),
      child: Text(
        btnCancelText ?? '취소',
        style: context.button1().copyWith(color: effectiveTextColor),
      ),
    );
  }

  /// 버튼 클릭 처리 (지연 후 다이얼로그 닫고 콜백 실행)
  static _handleButtonPress(
    BuildContext context,
    VoidCallback? callback,
  ) async {
    if (context.mounted) {
      Navigator.pop(context);
      callback?.call();
    }
  }

  /// 기본 버튼 텍스트 스타일
  static TextStyle _getDefaultButtonTextStyle(BuildContext context) {
    return context.button1().copyWith(color: context.fitColors.staticBlack);
  }
}
