/// Chip 타입 정의
enum FitChipType {
  /// 기본 칩 (단순 레이블)
  basic,

  /// 선택 가능한 칩 (선택 상태 표시)
  choice,

  /// 필터 칩 (체크마크 포함)
  filter,

  /// 입력 칩 (삭제 버튼 포함)
  input,

  /// 액션 칩 (아이콘 + 레이블)
  action,
}
