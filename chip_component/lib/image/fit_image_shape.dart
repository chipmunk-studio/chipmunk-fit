/// 이미지 타입
enum FitImageType {
  /// Lottie 애니메이션
  LOTTIE,

  /// 일반 이미지
  IMAGE,

  /// 없음
  NONE;

  /// 문자열에서 enum으로 변환
  static FitImageType fromString(String? type) {
    if (type == null) return NONE;

    return FitImageType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => NONE,
    );
  }
}

/// 이미지 형태
enum FitImageShape {
  /// 직사각형
  RECTANGLE,

  /// Squircle (부드러운 사각형)
  SQUIRCLE,

  /// 원형
  CIRCLE,

  /// 없음 (기본 형태)
  NONE;

  /// 문자열에서 enum으로 변환
  static FitImageShape fromString(String? shape) {
    if (shape == null) return SQUIRCLE;

    return FitImageShape.values.firstWhere(
      (e) => e.name == shape,
      orElse: () => SQUIRCLE,
    );
  }
}
