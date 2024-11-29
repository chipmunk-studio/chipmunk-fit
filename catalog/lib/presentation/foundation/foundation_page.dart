import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/main.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      body: Column(
        children: [
          Assets.images.icLauncher.image(),
          Center(
            child: Text(
              "안녕하세요",
              style: context.body2Semibold(
                color: context.fitColors.negative,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
