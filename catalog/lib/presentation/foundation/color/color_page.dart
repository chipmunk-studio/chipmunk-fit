import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FitColors lightColors = lightFitColors;
    final FitColors darkColors = darkFitColors;

    return Scaffold(
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "FitColors 테스트",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComparisonSection("Grey Colors", [
              _buildComparisonTile("Grey 900", lightColors.grey900, darkColors.grey900),
              _buildComparisonTile("Grey 800", lightColors.grey800, darkColors.grey800),
              _buildComparisonTile("Grey 700", lightColors.grey700, darkColors.grey700),
              _buildComparisonTile("Grey 600", lightColors.grey600, darkColors.grey600),
              _buildComparisonTile("Grey 500", lightColors.grey500, darkColors.grey500),
              _buildComparisonTile("Grey 400", lightColors.grey400, darkColors.grey400),
              _buildComparisonTile("Grey 300", lightColors.grey300, darkColors.grey300),
              _buildComparisonTile("Grey 200", lightColors.grey200, darkColors.grey200),
              _buildComparisonTile("Grey 100", lightColors.grey100, darkColors.grey100),
            ]),
            _buildComparisonSection("Basic Colors", [
              _buildComparisonTile("White", lightColors.white, darkColors.white),
              _buildComparisonTile("Black", lightColors.black, darkColors.black),
            ]),
            _buildComparisonSection("Primary and Secondary Colors", [
              _buildComparisonTile("Primary", lightColors.primary, darkColors.primary),
              _buildComparisonTile("Secondary", lightColors.secondary, darkColors.secondary),
            ]),
            _buildComparisonSection("Positive and Negative Colors", [
              _buildComparisonTile("Positive", lightColors.positive, darkColors.positive),
              _buildComparisonTile("Positive Light", lightColors.positiveLight, darkColors.positiveLight),
              _buildComparisonTile("Negative", lightColors.negative, darkColors.negative),
              _buildComparisonTile("Negative Light", lightColors.negativeLight, darkColors.negativeLight),
              _buildComparisonTile("Negative Dark", lightColors.negativeDark, darkColors.negativeDark),
            ]),
            _buildComparisonSection("Warning Colors", [
              _buildComparisonTile("Warning", lightColors.warning, darkColors.warning),
              _buildComparisonTile("Warning Light", lightColors.warningLight, darkColors.warningLight),
            ]),
            _buildComparisonSection("Background Grey", [
              _buildComparisonTile("Background Grey", lightColors.backgroundGrey, darkColors.backgroundGrey),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection(String title, List<Widget> children) {
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
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
