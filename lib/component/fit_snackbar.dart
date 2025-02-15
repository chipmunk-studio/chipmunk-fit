import 'package:flutter/material.dart';

extension ShowSnackBarBuildContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = const Color(0xFFF5F5F5), // 기본 배경색
    double elevation = 0, // 그림자 제거
    EdgeInsetsGeometry margin = const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    double? width,
    ShapeBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)), // 기본 둥근 스타일
    ),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    DismissDirection dismissDirection = DismissDirection.down,
    void Function()? onTap, // 버튼 클릭 시 동작
    String buttonText = "바로가기", // 기본 버튼 텍스트
    Color buttonTextColor = const Color(0xFF4CAF50), // 버튼 텍스트 색상 (초록색)
  }) {
    try {
      final messengerState = ScaffoldMessenger.maybeOf(this);
      if (messengerState == null) {
        return;
      }
      messengerState.hideCurrentSnackBar();
      messengerState.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          width: width,
          shape: shape,
          behavior: behavior,
          dismissDirection: dismissDirection,
          content: Row(
            children: [
              // ✅ 초록 체크 아이콘
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFF24F97D), // 초록색 배경
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8), // 간격
              // ✅ 메시지 텍스트
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF212121), // 기본 검은색
                    fontSize: 16,
                  ),
                ),
              ),
              // ✅ 커스텀 버튼 (onTap 없으면 안 보이게)
              if (onTap != null)
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    buttonText, // 버튼 텍스트 커스텀 가능
                    style: TextStyle(
                      color: buttonTextColor, // 버튼 색상도 변경 가능
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } catch (_) {}
  }
}
