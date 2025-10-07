#!/bin/bash

# =================================================================================
# Melos Flutter 프로젝트 - 최적화된 초기화 및 재빌드 스크립트 (V2)
#
# [설명]
#   다른 프로젝트의 사례를 참고하여 초기화 및 빌드 과정을 개선했습니다.
#   - Chopper 생성 파일(*.chopper.dart) 삭제 로직 추가
#   - 분리되어 있던 모듈 및 메인 앱 빌드 과정을 'melos run build' 명령어로 통합
#
# [실행 과정]
#   1. 생성된 모든 파일(*.g.dart, *.freezed.dart, *.chopper.dart) 및 pubspec.lock 삭제
#   2. 빌드 캐시 정리 (melos clean)
#   3. (선택) Flutter SDK 및 패키지 업그레이드
#   4. 의존성 재설치 및 연결 (melos bootstrap)
#   5. 전체 코드 생성 (melos run build)
#
# [사용법]
#   ./reset_and_rebuild.sh                    # 업그레이드 없이 실행
#   ./reset_and_rebuild.sh --upgrade          # Flutter SDK만 업그레이드
#   ./reset_and_rebuild.sh --upgrade-packages # 패키지만 업그레이드
#   ./reset_and_rebuild.sh --upgrade-all      # 전체 업그레이드
# =================================================================================

# --- 스크립트 설정 ---
# 명령어 실행 중 오류 발생 시 즉시 중단
set -e

# --- 터미널 출력 스타일 ---
# 터미널 출력에 사용할 ANSI 색상 코드 정의
readonly COLOR_BLUE='\033[1;34m'
readonly COLOR_GREEN='\033[1;32m'
readonly COLOR_RED='\033[1;31m'
readonly COLOR_YELLOW='\033[1;33m'
readonly COLOR_RESET='\033[0m'

# --- 옵션 플래그 ---
UPGRADE_FLUTTER=false
UPGRADE_PACKAGES=false

# =================================================================================
# 유틸리티 함수
# =================================================================================

# 단계별 진행 상황을 알려주는 헤더 출력
print_step() {
  echo -e "\n${COLOR_BLUE}▶ $1${COLOR_RESET}"
}

# 작업 성공 메시지 출력
print_success() {
  echo -e "${COLOR_GREEN}✅ $1${COLOR_RESET}"
}

# 오류 메시지 출력 후 스크립트 종료
print_error() {
  echo -e "${COLOR_RED}❌ 오류: $1${COLOR_RESET}"
  exit 1
}

# 도움말 출력
print_help() {
  echo "사용법: $0 [OPTIONS]"
  echo ""
  echo "옵션:"
  echo "  --upgrade, -u          Flutter SDK만 업그레이드합니다."
  echo "  --upgrade-packages, -p 패키지만 업그레이드합니다."
  echo "  --upgrade-all, -a      Flutter SDK와 모든 패키지를 업그레이드합니다."
  echo "  --help, -h             이 도움말을 표시합니다."
  exit 0
}

# =================================================================================
# 실행 단계별 함수
# =================================================================================

# 스크립트 실행 인자(옵션) 파싱
parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      --upgrade|-u) UPGRADE_FLUTTER=true; shift ;;
      --upgrade-packages|-p) UPGRADE_PACKAGES=true; shift ;;
      --upgrade-all|-a) UPGRADE_FLUTTER=true; UPGRADE_PACKAGES=true; shift ;;
      --help|-h) print_help ;;
      *)
        echo "알 수 없는 옵션: $1"
        print_help
        exit 1
        ;;
    esac
  done
}

# 생성된 모든 파일 삭제 (Chopper 파일 포함)
clean_generated_files() {
  print_step "생성된 파일을 모두 삭제합니다..."
  echo "   - *.g.dart, *.freezed.dart, *.chopper.dart, pubspec.lock 파일을 찾아서 삭제합니다..."
  find . -type f \( -name "*.g.dart" -o -name "*.freezed.dart" -o -name "*.chopper.dart" -o -name "pubspec.lock" \) -delete
  print_success "모든 생성 파일이 삭제되었습니다."
}

# 빌드 캐시 정리
clean_build_cache() {
  print_step "빌드 캐시를 정리합니다..."
  melos clean
  print_success "빌드 캐시 정리가 완료되었습니다."
}

# Flutter SDK 업그레이드 (옵션)
upgrade_sdk() {
  if [ "$UPGRADE_FLUTTER" = true ]; then
    print_step "Flutter SDK를 업그레이드합니다..."
    flutter upgrade
    print_success "Flutter SDK 업그레이드가 완료되었습니다."
  else
    print_step "Flutter SDK 업그레이드를 건너뜁니다."
  fi
}

# 의존성 재설치
bootstrap_dependencies() {
  print_step "의존성을 재설치 및 연결합니다..."
  melos bootstrap
  print_success "의존성 설치가 완료되었습니다."
}

# 패키지 업그레이드 (옵션)
upgrade_all_packages() {
  if [ "$UPGRADE_PACKAGES" = true ]; then
    print_step "모든 패키지를 업그레이드합니다..."
    melos exec --concurrency=10 -- "flutter pub upgrade"
    print_success "패키지 업그레이드가 완료되었습니다."
  else
    print_step "패키지 업그레이드를 건너뜁니다."
  fi
}

# 모든 모듈 및 메인 앱 빌드 통합
run_full_build() {
  print_step "프로젝트 전체 빌드를 실행합니다 (모든 모듈 + 메인 앱)..."
  # melos.yaml에 정의된 'build' 스크립트는 모든 하위 모듈과 메인 앱의 코드 생성을 포함합니다.
  melos run build
  print_success "프로젝트 전체 빌드가 완료되었습니다."
}

# 최종 요약 및 팁 출력
summarize_reset() {
  echo -e "\n${COLOR_YELLOW}=======================================================${COLOR_RESET}"
  echo -e "${COLOR_GREEN}🎉 프로젝트 초기화 및 재빌드가 성공적으로 완료되었습니다! 🎉${COLOR_RESET}"
  echo -e "${COLOR_YELLOW}=======================================================${COLOR_RESET}"

  if [ "$UPGRADE_FLUTTER" = false ] && [ "$UPGRADE_PACKAGES" = false ]; then
    echo -e "\n💡 Tip: 다음 옵션을 사용하여 SDK 또는 패키지를 업그레이드할 수 있습니다."
    echo "  $0 --upgrade          (Flutter SDK만 업그레이드)"
    echo "  $0 --upgrade-packages (패키지만 업그레이드)"
    echo "  $0 --upgrade-all      (전체 업그레이드)"
  fi
}

# =================================================================================
# 메인 실행 함수
# =================================================================================

main() {
  echo "🚀 Melos Flutter 프로젝트 초기화를 시작합니다..."

  parse_arguments "$@"
  clean_generated_files
  clean_build_cache
  upgrade_sdk
  bootstrap_dependencies
  upgrade_all_packages
  run_full_build
  summarize_reset
}

# 메인 함수 실행 (스크립트 인자 전달)
main "$@"

