import 'package:chipfit/foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:foundation/textstyle.dart';

/// GlobalKey<ScaffoldMessengerState>에 대한 확장 함수.
/// 전역 키를 통해 `context` 없이도 안전하게 스낵바를 표시할 수 있습니다.
///
/// 사용 예시:
/// scaffoldMessengerKey.showSuccessSnackBar('성공했습니다!');
/// scaffoldMessengerKey.showErrorSnackBar('에러가 발생했습니다.');
extension FitSnackBarExtension on GlobalKey<ScaffoldMessengerState> {
  /// 성공 또는 안내 메시지를 표시하는 스낵바 함수
  ///
  /// [message] - 표시할 메시지
  /// [buttonText] - (선택) 버튼에 표시할 텍스트
  /// [onTap] - (선택) 버튼을 눌렀을 때 실행될 콜백
  void showSuccessSnackBar(
    String message, {
    String buttonText = "바로가기",
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
  }) {
    final context = currentContext;
    if (context != null) {
      _showFitSnackBar(
        message: message,
        margin: margin,
        onTap: onTap,
        buttonText: buttonText,
        icon: Icons.check,
        iconColor: context.fitColors.staticWhite,
        iconBackgroundColor: context.fitColors.main,
      );
    }
  }

  /// 에러 메시지를 표시하는 스낵바 함수
  ///
  /// [message] - 표시할 에러 메시지
  void showErrorSnackBar(
    String message, {
    EdgeInsetsGeometry? margin,
  }) {
    final context = currentContext;
    if (context != null) {
      _showFitSnackBar(
        message: message,
        margin: margin,
        icon: Icons.error_outline,
        iconColor: context.fitColors.staticWhite,
        iconBackgroundColor: context.fitColors.red50,
      );
    }
  }

  /// 스낵바 UI를 구성하고 표시하는 내부 함수
  void _showFitSnackBar({
    required String message,
    required IconData icon,
    required Color iconColor,
    EdgeInsetsGeometry? margin,
    required Color iconBackgroundColor,
    VoidCallback? onTap,
    String? buttonText,
  }) {
    // `this`는 GlobalKey<ScaffoldMessengerState> 인스턴스를 가리킴
    final messenger = currentState;
    if (messenger == null) return;

    // GlobalKey를 통해 현재 context를 안전하게 가져옴 (테마, 스타일 접근용)
    final context = currentContext;
    if (context == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          margin: margin ?? const EdgeInsets.only(left: 16, right: 16, bottom: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ 아이콘 (성공/에러에 따라 다름)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 12),
              // ✅ 메시지 텍스트
              Expanded(
                child: Text(
                  message,
                  style: context.body3().copyWith(color: context.fitColors.staticBlack),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              // ✅ 커스텀 버튼 (onTap 있을 때만 보임)
              if (onTap != null && buttonText != null) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    buttonText,
                    style: context.subtitle5().copyWith(color: context.fitColors.green700),
                  ),
                ),
              ]
            ],
          ),
        ),
      );
  }
}
