import 'package:chipfit/foundation/colors.dart';
import 'package:chipfit/foundation/textstyle.dart';
import 'package:flutter/material.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FitColors lightColors = lightFitColors;
    final FitColors darkColors = darkFitColors;

    return Scaffold(
      backgroundColor: context.fitColors.grey0,
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: context.fitColors.grey0,
        backgroundColor: context.fitColors.grey0,
        title: Text(
          "FitColors 테스트",
          style: context.subtitle2().copyWith(color: context.fitColors.grey0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComparisonSection(context, "Grey Colors", [
              _buildComparisonTile("Grey 0", lightColors.grey0, darkColors.grey0),
              _buildComparisonTile("Grey 50", lightColors.grey50, darkColors.grey50),
              _buildComparisonTile("Grey 100", lightColors.grey100, darkColors.grey100),
              _buildComparisonTile("Grey 200", lightColors.grey200, darkColors.grey200),
              _buildComparisonTile("Grey 300", lightColors.grey300, darkColors.grey300),
              _buildComparisonTile("Grey 400", lightColors.grey400, darkColors.grey400),
              _buildComparisonTile("Grey 500", lightColors.grey500, darkColors.grey500),
              _buildComparisonTile("Grey 600", lightColors.grey600, darkColors.grey600),
              _buildComparisonTile("Grey 700", lightColors.grey700, darkColors.grey700),
              _buildComparisonTile("Grey 800", lightColors.grey800, darkColors.grey800),
              _buildComparisonTile("Grey 900", lightColors.grey900, darkColors.grey900),
            ]),
            _buildComparisonSection(context, "Green Colors", [
              _buildComparisonTile("Green 50", lightColors.green50, darkColors.green50),
              _buildComparisonTile("Green 200", lightColors.green200, darkColors.green200),
              _buildComparisonTile("Green 500", lightColors.green500, darkColors.green500),
              _buildComparisonTile("Green 600", lightColors.green600, darkColors.green600),
              _buildComparisonTile("Green 700", lightColors.green700, darkColors.green700),
              _buildComparisonTile("Green Base", lightColors.greenBase, darkColors.greenBase),
              _buildComparisonTile("Green Alpha 72", lightColors.greenAlpha72, darkColors.greenAlpha72),
              _buildComparisonTile("Green Alpha 48", lightColors.greenAlpha48, darkColors.greenAlpha48),
              _buildComparisonTile("Green Alpha 24", lightColors.greenAlpha24, darkColors.greenAlpha24),
              _buildComparisonTile("Green Alpha 12", lightColors.greenAlpha12, darkColors.greenAlpha12),
            ]),
            _buildComparisonSection(context, "Blue Colors", [
              _buildComparisonTile("Blue Alpha 72", lightColors.blueAlpha72, darkColors.blueAlpha72),
              _buildComparisonTile("Blue Alpha 48", lightColors.blueAlpha48, darkColors.blueAlpha48),
              _buildComparisonTile("Blue Alpha 24", lightColors.blueAlpha24, darkColors.blueAlpha24),
              _buildComparisonTile("Blue Alpha 12", lightColors.blueAlpha12, darkColors.blueAlpha12),
            ]),
            _buildComparisonSection(context, "Red Colors", [
              _buildComparisonTile("Red 50", lightColors.red50, darkColors.red50),
              _buildComparisonTile("Red 200", lightColors.red200, darkColors.red200),
              _buildComparisonTile("Red 500", lightColors.red500, darkColors.red500),
              _buildComparisonTile("Red 600", lightColors.red600, darkColors.red600),
              _buildComparisonTile("Red 700", lightColors.red700, darkColors.red700),
              _buildComparisonTile("Red Base", lightColors.redBase, darkColors.redBase),
              _buildComparisonTile("Red Alpha 72", lightColors.redAlpha72, darkColors.redAlpha72),
              _buildComparisonTile("Red Alpha 48", lightColors.redAlpha48, darkColors.redAlpha48),
              _buildComparisonTile("Red Alpha 24", lightColors.redAlpha24, darkColors.redAlpha24),
              _buildComparisonTile("Red Alpha 12", lightColors.redAlpha12, darkColors.redAlpha12),
            ]),
            _buildComparisonSection(context, "Yellow Colors", [
              _buildComparisonTile("Yellow Base", lightColors.yellowBase, darkColors.yellowBase),
              _buildComparisonTile("Yellow Alpha 72", lightColors.yellowAlpha72, darkColors.yellowAlpha72),
              _buildComparisonTile("Yellow Alpha 48", lightColors.yellowAlpha48, darkColors.yellowAlpha48),
              _buildComparisonTile("Yellow Alpha 24", lightColors.yellowAlpha24, darkColors.yellowAlpha24),
              _buildComparisonTile("Yellow Alpha 12", lightColors.yellowAlpha12, darkColors.yellowAlpha12),
            ]),
            _buildComparisonSection(context, "Brick Colors", [
              _buildComparisonTile("Brick 50", lightColors.brick50, darkColors.brick50),
              _buildComparisonTile("Brick 200", lightColors.brick200, darkColors.brick200),
              _buildComparisonTile("Brick 500", lightColors.brick500, darkColors.brick500),
              _buildComparisonTile("Brick 600", lightColors.brick600, darkColors.brick600),
              _buildComparisonTile("Brick 700", lightColors.brick700, darkColors.brick700),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.subtitle2().copyWith(color: context.fitColors.grey900)),
              const SizedBox(height: 16),
              Column(
                children: children,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonTile(String colorName, Color lightColor, Color darkColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _buildColorBox(colorName, lightColor, "Light Mode"),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildColorBox(colorName, darkColor, "Dark Mode"),
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(String colorName, Color color, String mode) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            colorName,
            style: TextStyle(
              color: _getContrastingColor(color),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            mode,
            style: TextStyle(
              color: _getContrastingColor(color).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            color.toString(),
            style: TextStyle(
              color: _getContrastingColor(color).withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Color _getContrastingColor(Color color) {
    final brightness = color.computeLuminance();
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}
