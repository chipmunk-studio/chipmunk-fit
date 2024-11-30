import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/gen/fonts.gen.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      appBar: FitCustomAppBar.leadingAppBar(context,title: "adfda"),
      body: Column(
        children: [
          Center(
            child: Text(
              "안녕하세요",
              style: context.headLine1(
                color: context.fitColors.negative,
              ),
            ),
          ),
          Center(
            child: Text(
              "안녕하세요",
              style: TextStyle(
                fontSize: 30,
                letterSpacing: -0.06,
                fontFamily: FontFamily.pretendardSemiBold,
                color: context.fitColors.grey400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
