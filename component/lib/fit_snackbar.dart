import 'package:chipfit/foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:foundation/textstyle.dart';

/// GlobalKey<ScaffoldMessengerState> 확장 (스낵바)
extension FitSnackBarExtension on GlobalKey<ScaffoldMessengerState> {
  /// 성공 스낵바 표시
  void showSuccessSnackBar(
    String message, {
    String buttonText = "바로가기",
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
  }) {
    final context = currentContext;
    if (context == null) return;

    _showFitSnackBar(
      context: context,
      message: message,
      margin: margin,
      onTap: onTap,
      buttonText: buttonText,
      icon: Icons.check,
      iconColor: context.fitColors.staticWhite,
      iconBackgroundColor: context.fitColors.main,
    );
  }

  /// 에러 스낵바 표시
  void showErrorSnackBar(
    String message, {
    EdgeInsetsGeometry? margin,
  }) {
    final context = currentContext;
    if (context == null) return;

    _showFitSnackBar(
      context: context,
      message: message,
      margin: margin,
      icon: Icons.error_outline,
      iconColor: context.fitColors.staticWhite,
      iconBackgroundColor: context.fitColors.red50,
    );
  }

  /// 스낵바 UI 구성
  void _showFitSnackBar({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    String? buttonText,
  }) {
    final messenger = currentState;
    if (messenger == null) return;

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
              _IconBadge(
                icon: icon,
                iconColor: iconColor,
                backgroundColor: iconBackgroundColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: context.body3().copyWith(
                        color: context.fitColors.staticBlack,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
