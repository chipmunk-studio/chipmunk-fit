import 'package:flutter/material.dart';

/// 체크 마크를 그리는 CustomPainter
///
/// progress 값(0.0 ~ 1.0)에 따라 체크 마크가 그려지는 애니메이션
class CheckMarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CheckMarkPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 체크 마크의 두 개의 선분 정의
    // 첫 번째 선: 왼쪽 아래에서 중앙으로
    final firstLineStart = Offset(size.width * 0.25, size.height * 0.5);
    final firstLineEnd = Offset(size.width * 0.45, size.height * 0.7);

    // 두 번째 선: 중앙에서 오른쪽 위로
    final secondLineStart = firstLineEnd;
    final secondLineEnd = Offset(size.width * 0.75, size.height * 0.3);

    final path = Path();

    // progress가 0.5 이하일 때는 첫 번째 선만 그림
    if (progress <= 0.5) {
      final currentProgress = progress * 2.0; // 0.0 ~ 1.0으로 정규화
      path.moveTo(firstLineStart.dx, firstLineStart.dy);
      path.lineTo(
        firstLineStart.dx + (firstLineEnd.dx - firstLineStart.dx) * currentProgress,
        firstLineStart.dy + (firstLineEnd.dy - firstLineStart.dy) * currentProgress,
      );
    } else {
      // 첫 번째 선 완성
      path.moveTo(firstLineStart.dx, firstLineStart.dy);
      path.lineTo(firstLineEnd.dx, firstLineEnd.dy);

      // 두 번째 선 그리기
      final currentProgress = (progress - 0.5) * 2.0; // 0.0 ~ 1.0으로 정규화
      path.moveTo(secondLineStart.dx, secondLineStart.dy);
      path.lineTo(
        secondLineStart.dx + (secondLineEnd.dx - secondLineStart.dx) * currentProgress,
        secondLineStart.dy + (secondLineEnd.dy - secondLineStart.dy) * currentProgress,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CheckMarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
