/// 이미지 타입 Enum
enum FitImageType {
  LOTTIE,
  IMAGE,
  NONE;

  static FitImageType fromString(String? type) {
    if (type == null) return NONE;

    return FitImageType.values.firstWhere(
          (e) => e.name == type,
      orElse: () => NONE,
    );
  }
}

/// 이미지 형태 Enum
enum FitImageShape {
  RECTANGLE,
  SQUIRCLE,
  CIRCLE,
  NONE;

  static FitImageShape fromString(String? shape) {
    if (shape == null) return SQUIRCLE;

    return FitImageShape.values.firstWhere(
          (e) => e.name == shape,
      orElse: () => SQUIRCLE,
    );
  }
}