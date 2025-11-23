# ChipMunk-Fit 프로젝트 컨텍스트

## 프로젝트 개요
Flutter 디자인 시스템 라이브러리. Fortune, Sophia 등 여러 앱에서 사용하는 공통 UI 컴포넌트 제공.

## 모노레포 구조
```
chipmunk-fit/
├── chip_foundation/     # 기초 디자인 토큰 (색상, 타이포그래피, 애니메이션)
├── chip_component/      # UI 컴포넌트 (버튼, 체크박스, 로딩 등)
├── chip_module/         # 고차원 모듈 (스캐폴드, 바텀시트, 다이얼로그)
├── chip_core/           # 핵심 유틸리티 (캐시, Delta 뷰어 등)
├── chip_assets/         # 에셋 (아이콘, 폰트, 이미지)
├── chip_dependencies/   # 중앙 의존성 관리
├── catalog/            # 테스트/데모 앱
├── lib/                # 메인 패키지 (deprecated, 점진적 마이그레이션 중)
└── component/          # (deprecated)
```

## 주요 패키지 설명

### chip_foundation
- **colors.dart**: FitColors - 라이트/다크 모드 색상 시스템
- **textstyle.dart**: 타이포그래피 (heading1~6, body1~3, etc)
- **theme/fit_theme.dart**: ThemeData 설정
- **buttonstyle.dart**: FitButtonType (primary, secondary, tertiary, ghost, destructive)

### chip_component
- **button/fit_button.dart**: 공통 버튼 (디바운스, 스케일 애니메이션, 로딩 상태)
- **checkbox/**: FitCheckBox (material, rounded, outlined 스타일)
  - fit_check_box.dart: 메인 위젯
  - fit_check_box_style.dart: 스타일 enum
  - fit_check_box_painter.dart: 체크 마크 그리기
- **button/fit_switch_button.dart**: 스위치 버튼
- **fit_dot_loading.dart**: 점 로딩 애니메이션
- **fit_animated_text.dart**: 타이핑 애니메이션

### chip_module
- **fit_scaffold.dart**: 공통 스캐폴드 (플랫폼별 AppBar, 로딩 상태)
- **fit_bottomsheet.dart**: 바텀시트
- **fit_dialog.dart**: 다이얼로그

### chip_core
- **fit_cache_helper.dart**: 파일 다운로드 및 캐싱 헬퍼
  - 만료 시간별 독립적인 캐시 매니저 관리
  - HTTP GET으로 직접 다운로드 후 캐시 저장
  - URL에서 파일 확장자 자동 추출
- **fit_delta_viewer.dart**: Quill Delta JSON 뷰어
  - 읽기 전용 Delta 렌더링
  - QuillController 기반

### catalog
테스트 앱. Foundation, Component, Module, Core 탭으로 구성.
- `catalog/lib/presentation/`

## 코드 컨벤션

### Import 순서
1. Dart/Flutter core
2. 외부 패키지
3. chipfit 패키지
4. 내부 파일 (상대 경로)

### 컴포넌트 작성 규칙
- StatefulWidget + State 패턴
- 애니메이션은 SingleTickerProviderStateMixin 사용
- onChanged 콜백은 `void Function(T)?` 형태 (dartz 사용 금지)
- 주석은 한글로 간결하게
- 파라미터 순서: required > optional > callback

### 파일 구조
컴포넌트가 복잡하면 폴더로 분리:
```
component_name/
├── component_name.dart        # 메인 위젯
├── component_name_style.dart  # 스타일/설정
└── component_name_painter.dart # CustomPainter (필요시)
```

메인 파일에서 export:
```dart
export 'component_name/component_name.dart';
export 'component_name/component_name_style.dart';
```

## 경로 패턴

### 절대 경로 사용
```dart
// Good
import 'package:chipfit/component/button/fit_button.dart';
import 'package:chipfit/foundation/colors.dart';

// Bad - 상대 경로 사용 금지
import '../foundation/colors.dart';
```

### 자주 사용하는 패턴
```dart
// 색상
context.fitColors.main
context.fitColors.grey900
context.fitColors.backgroundAlternative

// 타이포그래피
context.heading1()
context.body2(type: FitTextSp.SP)

// 버튼
FitButton(
  type: FitButtonType.primary,
  onPressed: () {},
  child: Text('버튼'),
)
```

## Melos 모노레포

### Melos 명령어
```bash
# 모든 패키지 pub get
melos bootstrap

# 모든 패키지 분석
melos run analyze

# 모든 패키지 클린
melos clean

# 코드 생성 (freezed 등)
melos run build_runner

# 카탈로그 앱 실행
cd catalog && flutter run -d [device]
```

### pubspec.yaml 구조
- **resolution: workspace** - melos workspace 사용
- 패키지들은 서로 참조 가능
- 의존성은 chip_dependencies에서 중앙 관리

## 작업 시 주의사항

### DO
- ✅ 기존 컴포넌트 수정 시 catalog 앱에서 테스트
- ✅ 애니메이션은 FitButton 스타일 참고 (GestureDetector + AnimatedContainer)
- ✅ 색상/스타일은 foundation에서 가져오기
- ✅ 새 컴포넌트는 chip_component에 추가
- ✅ 폴더 분리가 필요하면 checkbox처럼 구조화

### DON'T
- ❌ lib/ 폴더에 새 파일 추가 금지 (deprecated)
- ❌ dartz 사용 금지 (Function1 → void Function(T))
- ❌ 하드코딩된 색상 사용 금지
- ❌ 플랫폼별 조건문 남발 (foundation/module에서 처리)

## 최근 변경사항

### 2024-11-23
- FitCheckBox 완전 리팩토링
  - 3가지 스타일 (material, rounded, outlined)
  - CustomPainter로 체크 마크 그리기 애니메이션
  - FitButton 스타일의 press 애니메이션
  - 폴더 구조로 분리 (checkbox/)
- dartz 의존성 제거
  - Function1 → void Function(T)
  - Function0 → void Function()

## 토큰 최적화 팁

### 파일 읽기 전에
1. 이 CONTEXT.md 먼저 읽기
2. 해당 패키지의 pubspec.yaml 확인
3. 구조 파악 후 필요한 파일만 읽기

### 검색 활용
```bash
# Grep으로 먼저 찾기
Grep pattern:"FitButton" path:"chip_component"

# Glob으로 파일 목록 확인
Glob pattern:"**/*button*.dart"
```

### 중복 읽기 방지
- 동일한 파일을 여러 번 읽지 않기
- 변경이 필요한 파일만 Read
- 전체 탐색이 필요하면 Task tool 사용

## 관련 프로젝트

- **fortune-client**: 운세 앱 (이 라이브러리 사용)
- **sophia_backhyun**: 백현 앱 (이 라이브러리 사용)

두 프로젝트 모두 GitHub에서 chipfit를 의존성으로 가져옴:
```yaml
chipfit:
  git:
    url: https://github.com/chipmunk-studio/chipmunk-fit.git
    ref: main
```
