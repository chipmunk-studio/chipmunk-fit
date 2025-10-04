enum FitImageType {
  LOTTIE, // 로띠.
  IMAGE, // 웹피.
  NONE
}

enum FitImageShape {
  RECTANGLE, // 직사각형.
  SQUIRCLE, // 스쿼클.
  CIRCLE, // 원.
  NONE
}

FitImageType getImageType(String? type) {
  if (FitImageType.LOTTIE.name == type) {
    return FitImageType.LOTTIE;
  } else if (FitImageType.IMAGE.name == type) {
    return FitImageType.IMAGE;
  } else {
    return FitImageType.NONE;
  }
}

FitImageShape getImageShape(String? shape) {
  if (FitImageShape.CIRCLE.name == shape) {
    return FitImageShape.CIRCLE;
  } else if (FitImageShape.RECTANGLE.name == shape) {
    return FitImageShape.RECTANGLE;
  } else if (FitImageShape.SQUIRCLE.name == shape) {
    return FitImageShape.SQUIRCLE;
  } else {
    return FitImageShape.SQUIRCLE;
  }
}