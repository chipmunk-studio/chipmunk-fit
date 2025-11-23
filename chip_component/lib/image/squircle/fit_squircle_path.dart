import 'dart:ui';

/// Squircle 형태의 Path를 생성하는 유틸리티
///
/// 여러 위젯(Clipper, Painter)에서 동일한 Squircle Path를 재사용
class FitSquirclePath {
  FitSquirclePath._();

  /// Squircle Path 생성
  ///
  /// 부드러운 사각형 형태로, 모서리가 완만한 곡선을 이룸
  /// [size] Path를 그릴 영역의 크기
  static Path create(Size size) {
    final w = size.width;
    final h = size.height;

    return Path()
      ..moveTo(0, h * 0.5)
      ..cubicTo(0, h * 0.125, w * 0.125, 0, w * 0.5, 0)
      ..cubicTo(w * 0.875, 0, w, h * 0.125, w, h * 0.5)
      ..cubicTo(w, h * 0.875, w * 0.875, h, w * 0.5, h)
      ..cubicTo(w * 0.125, h, 0, h * 0.875, 0, h * 0.5)
      ..close();
  }
}
