#!/bin/bash

# =================================================================================
# Melos Flutter 프로젝트 완전 소거 및 재빌드 스크립트 (Ultimate Reset V2)
#
# 이 스크립트는 프로젝트를 소스 코드만 남기고 모두 초기화합니다.
# freezed, json_serializable(.g.dart) 뿐만 아니라 Chopper(.chopper.dart)가
# 생성한 네트워크 계층 코드까지 모두 삭제하고 재빌드합니다.
#
# [실행 과정]
# 1. 모든 코드 생성 파일(*.g.dart, *.freezed.dart, *.chopper.dart)을 삭제합니다.
# 2. 모든 'pubspec.lock' 파일을 삭제하여 의존성을 리셋합니다.
# 3. Melos를 통해 모든 패키지를 clean 합니다 (.dart_tool, build 폴더 등 삭제).
# 4. Flutter SDK를 최신 버전으로 업그레이드합니다 (flutter upgrade).
# 5. Flutter 업그레이드 후 모든 패키지를 최신 상태로 업데이트합니다 (고정 버전 제외).
# 6. 모든 패키지의 의존성을 처음부터 다시 설치하고 연결합니다 (bootstrap).
# 7. 모든 패키지를 빌드하여 코드 생성 파일을 다시 만듭니다 (build).
#
# [경고] 프로젝트 규모에 따라 전체 실행 시간이 매우 길어질 수 있습니다.
#
# 사용법:
#   프로젝트 최상위 디렉토리에서 스크립트 파일을 저장하고 실행하세요.
# =================================================================================

# 스크립트 실행 중 오류가 발생하면 즉시 중단하도록 설정합니다.
set -e

# --- 1. 모든 코드 생성 파일 삭제 ---
# 'find' 명령어를 사용하여 프로젝트 전체에서 패턴과 일치하는 파일을 찾아 삭제합니다.
# 오래되거나 불필요하게 남은 생성 파일을 제거하여 충돌을 방지합니다.
echo "🧹 모든 코드 생성 파일(*.g.dart, *.freezed.dart, *.chopper.dart)을 삭제합니다..."
find . -name "*.g.dart" -type f -delete
find . -name "*.freezed.dart" -type f -delete
find . -name "*.chopper.dart" -type f -delete # Chopper 생성 파일 삭제 추가

# --- 2. 모든 pubspec.lock 파일 삭제 ---
# 의존성 해석을 처음부터 다시 시작하도록 모든 lock 파일을 삭제합니다.
echo "🧹 모든 패키지의 pubspec.lock 파일을 삭제합니다..."
find . -name "pubspec.lock" -type f -delete

# --- 3. Melos 기본 Clean 실행 ---
# .dart_tool, build 폴더 등 기본적인 빌드 캐시를 삭제합니다.
echo "🧹 Melos 프로젝트를 초기화합니다 (flutter clean)..."
melos clean

# --- 4. Flutter SDK 업그레이드 ---
# Flutter SDK를 최신 버전으로 업그레이드합니다.
echo "🚀 Flutter SDK를 최신 버전으로 업그레이드합니다..."
flutter upgrade

# --- 5. Flutter 업그레이드 후 패키지 업데이트 ---
# Flutter SDK가 업그레이드된 후 모든 패키지를 최신 상태로 업데이트합니다 (고정 버전 제외).
echo "🔄 Flutter 업그레이드 후 모든 패키지를 업데이트합니다 (고정 버전 제외)..."
melos exec --concurrency=10 -- "flutter pub upgrade"

# --- 6. Melos 부트스트랩 (Bootstrap) ---
# 모든 의존성을 깨끗한 상태에서 다시 설치하고 로컬 패키지를 연결합니다.
echo "🔗 모든 의존성을 처음부터 다시 설치하고 연결합니다 (bootstrap)..."
melos bootstrap

# --- 7. 전체 워크플로우 빌드 (Complete Build Workflow) ---
# 모든 패키지와 메인 앱의 코드 생성 파일을 빌드합니다.
echo "🚀 전체 빌드 워크플로우를 실행합니다 (모든 패키지 + 메인 앱)..."
melos run build:all # 모든 패키지 빌드 (dev_dependencies 포함)

# 개별 모듈 빌드 (확실히 하기 위해)
echo "🔧 개별 모듈 빌드를 실행합니다..."
melos run build:main # 메인 앱 빌드
melos run build:features # features 모듈 빌드

# --- 완료 ---
echo "✅ 모든 작업이 성공적으로 완료되었습니다! 프로젝트가 소스 코드 외 모든 것을 초기화하고 재빌드했습니다."