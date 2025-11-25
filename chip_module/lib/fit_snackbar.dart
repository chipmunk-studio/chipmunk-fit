import 'package:chipfit/foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:chip_foundation/textstyle.dart';

/// GlobalKey<ScaffoldMessengerState> 확장 (스낵바)
extension FitSnackBarExtension on GlobalKey<ScaffoldMessengerState> {
  /// 성공 스낵바 표시
  void showSuccessSnackBar(
    String message, {
    String buttonText = "바로가기",
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    IconData? icon,
    Color? iconColor,
    Color? iconBackgroundColor,
    Color? backgroundColor,
    TextStyle? messageStyle,
    int maxLines = 2,
  }) {
    final context = currentContext;
    if (context == null) return;

    _showFitSnackBar(
      context: context,
      message: message,
      margin: margin,
      onTap: onTap,
      buttonText: buttonText,
      icon: icon ?? Icons.check,
      iconColor: iconColor ?? context.fitColors.staticWhite,
      iconBackgroundColor: iconBackgroundColor ?? context.fitColors.main,
      backgroundColor: backgroundColor,
      messageStyle: messageStyle,
      maxLines: maxLines,
    );
  }

  /// 에러 스낵바 표시
  void showErrorSnackBar(
    String message, {
    EdgeInsetsGeometry? margin,
    IconData? icon,
    Color? iconColor,
    Color? iconBackgroundColor,
    Color? backgroundColor,
    TextStyle? messageStyle,
    int maxLines = 2,
  }) {
    final context = currentContext;
    if (context == null) return;

    _showFitSnackBar(
      context: context,
      message: message,
      margin: margin,
      icon: icon ?? Icons.error_outline,
      iconColor: iconColor ?? context.fitColors.staticWhite,
      iconBackgroundColor: iconBackgroundColor ?? context.fitColors.red50,
      backgroundColor: backgroundColor,
      messageStyle: messageStyle,
      maxLines: maxLines,
    );
  }

  /// 스낵바 UI 구성
  void _showFitSnackBar({
    required BuildContext context,
    required String message,
    IconData icon = Icons.info_outline,
    Color? iconColor,
    Color? iconBackgroundColor,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    String? buttonText,
    Color? backgroundColor,
    TextStyle? messageStyle,
    int maxLines = 2,
  }) {
    final messenger = currentState;
    if (messenger == null) return;

    // 기본값 설정
    final effectiveIconColor = iconColor ?? context.fitColors.staticWhite;
    final effectiveIconBackgroundColor = iconBackgroundColor ?? context.fitColors.main;
    final effectiveBackgroundColor = backgroundColor ?? const Color(0xFFF5F5F5);
    final effectiveMargin = margin ?? const EdgeInsets.only(left: 16, right: 16, bottom: 64);
    final effectiveMessageStyle = messageStyle ??
        context.body3().copyWith(
              color: context.fitColors.staticBlack,
            );

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: effectiveBackgroundColor,
          elevation: 0,
          margin: effectiveMargin,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconBadge(
                icon: icon,
                iconColor: effectiveIconColor,
                backgroundColor: effectiveIconBackgroundColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: effectiveMessageStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
              ),
              if (onTap != null && buttonText != null) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    buttonText,
                    style: context.subtitle5().copyWith(
                          color: context.fitColors.green700,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
  }
}

/// 스낵바 아이콘 뱃지
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const _IconBadge({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 16),
    );
  }
}
