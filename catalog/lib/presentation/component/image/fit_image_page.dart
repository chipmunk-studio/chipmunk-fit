import 'package:chipfit/component/image/fit_cached_network_image.dart';
import 'package:chipfit/component/image/fit_image_shape.dart';
import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class FitImagePage extends StatelessWidget {
  const FitImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "이미지 테스트",
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            _buildSection(context, title: "스쿼클(Squircle) 테스트", shape: FitImageShape.SQUIRCLE, description: "스쿼클"),
            SizedBox(height: 16),
            _buildSection(context, title: "원형(Circle) 테스트", shape: FitImageShape.CIRCLE, description: "원형"),
            SizedBox(height: 16),
            _buildSection(context, title: "직사각형(Rectangle) 테스트", shape: FitImageShape.RECTANGLE, description: "직사각형"),
            SizedBox(height: 16),
            _buildSection(context, title: "모양 없음(None) 테스트", shape: FitImageShape.NONE, description: "모양 없음"),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required FitImageShape shape, required String description}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, title),
            SizedBox(height: 16),
            ..._buildAllCases(context: context, shape: shape, description: description),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.image, color: context.fitColors.primary, size: 24),
        SizedBox(width: 8),
        Text(
          title,
          style: context.headLine2(color: context.fitColors.grey100),
        ),
      ],
    );
  }

  List<Widget> _buildAllCases({
    required BuildContext context,
    required FitImageShape shape,
    required String description,
  }) {
    return [
      _buildImageTest(
        context: context,
        label: "$description - 기본",
        shape: shape,
      ),
      _buildImageTest(
        context: context,
        label: "$description - 테두리",
        shape: shape,
        borderWidth: 3.0,
        borderColor: Colors.blue,
      ),
      _buildImageTest(
        context: context,
        label: "$description - 패딩",
        shape: shape,
        itemPadding: EdgeInsets.all(10.0),
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.cover",
        shape: shape,
        fit: BoxFit.cover,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.contain",
        shape: shape,
        fit: BoxFit.contain,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.fill",
        shape: shape,
        fit: BoxFit.fill,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.fitWidth",
        shape: shape,
        fit: BoxFit.fitWidth,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.fitHeight",
        shape: shape,
        fit: BoxFit.fitHeight,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.none",
        shape: shape,
        fit: BoxFit.none,
      ),
      _buildImageTest(
        context: context,
        label: "$description - BoxFit.scaleDown",
        shape: shape,
        fit: BoxFit.scaleDown,
      ),
    ];
  }

  Widget _buildImageTest({
    required BuildContext context,
    required String label,
    required FitImageShape shape,
    String url = "https://picsum.photos/200/300",
    double width = 100,
    double height = 100,
    Widget? placeholder,
    Widget? errorWidget,
    EdgeInsetsGeometry? itemPadding,
    double? borderWidth,
    Color? borderColor,
    BoxFit? fit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.body1Semibold(color: context.fitColors.grey100),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: context.fitColors.grey500,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8.0),
          child: buildFitImage(
            url: url,
            width: width,
            height: height,
            type: FitImageType.IMAGE,
            imageShape: shape,
            placeholder: placeholder ?? const CircularProgressIndicator(),
            errorWidget: errorWidget ?? const Icon(Icons.error, size: 40),
            itemPadding: itemPadding,
            borderWidth: borderWidth,
            borderColor: borderColor,
            fit: fit ?? BoxFit.cover,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
