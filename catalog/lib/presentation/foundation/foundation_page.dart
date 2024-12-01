import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      appBar: FitCustomAppBar.leadingAppBar(context, title: "Foundation"),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'FitTextStyle',
              style: context.body1Regular(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(),
            onTap: () => context.go('/textstyle'),
          ),
        ],
      ),
    );
  }
}
