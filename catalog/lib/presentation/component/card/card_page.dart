import 'package:chipfit/component/card/fit_card.dart';
import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitCard 테스트",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: "기본 카드",
              description: "기본 스타일의 FitCard를 테스트합니다.",
              child: FitCard(
                backgroundColor: context.fitColors.grey800,
                child: Text(
                  "이것은 기본 카드입니다.",
                  style: context.body1().copyWith(color: context.fitColors.grey300),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: "커스텀 배경색",
              description: "배경색과 내용을 커스터마이징한 FitCard입니다.",
              child: FitCard(
                backgroundColor: context.fitColors.main.withOpacity(0.8),
                child: Text(
                  "배경색이 커스터마이징된 카드입니다.",
                  style: context.body1().copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: "쉐도우와 테두리",
              description: "카드의 쉐도우 색상과 테두리를 조정합니다.",
              child: FitCard(
                shadowColor: Colors.black54,
                elevation: 12,
                borderRadius: BorderRadius.circular(20.r),
                child: Text(
                  "쉐도우와 테두리가 조정된 카드입니다.",
                  style: context.body1().copyWith(color: context.fitColors.grey300),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: "긴 내용을 가진 카드",
              description: "다양한 내용을 포함한 FitCard입니다.",
              child: FitCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "긴 내용을 가진 카드입니다.",
                      style: context.body1().copyWith(color: context.fitColors.grey300),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이 카드는 여러 줄의 텍스트를 포함할 수 있습니다. 이 예제에서는 텍스트를 길게 작성하여 FitCard가 긴 내용을 포함할 때의 동작을 확인합니다. "
                      "Flutter는 유연한 레이아웃 시스템을 제공하므로, 이러한 긴 텍스트도 적절히 레이아웃에 맞춰 표시됩니다. "
                      "카드는 다양한 콘텐츠를 담기에 적합하며, 그림자와 테두리를 통해 시각적 계층 구조를 효과적으로 구현할 수 있습니다. "
                      "이 텍스트는 사용자가 실제 앱에서 접할 수 있는 시나리오를 가정한 예제입니다.",
                      style: context.body2().copyWith(color: context.fitColors.grey500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "추가적으로, 이 FitCard는 상단에 아이콘과 하단에 다른 내용을 포함할 수 있는 구조를 제공합니다. "
                      "이를 통해 UI 컴포넌트를 보다 효과적으로 디자인할 수 있습니다.",
                      style: context.body2().copyWith(color: context.fitColors.grey500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: "커스텀 구성 요소 포함",
              description: "FitCard에 다양한 커스텀 구성 요소를 포함합니다.",
              child: FitCard(
                backgroundColor: context.fitColors.grey700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "커스텀 구성 요소",
                      style: context.h2().copyWith(color: context.fitColors.grey100),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이 카드는 leading과 trailing에 다양한 위젯을 포함할 수 있습니다. 이를 통해 사용자 상호작용을 지원하는 인터페이스를 제공합니다.",
                      style: context.body1().copyWith(color: context.fitColors.grey400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.h2().copyWith(color: context.fitColors.grey100),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: context.body1().copyWith(color: context.fitColors.grey500),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}
