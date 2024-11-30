import 'package:chipfit/foundation/textstyle.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      appBar: FitCustomAppBar.leadingAppBar(
        context,
        title: "Component",
        onPressed: () {},
      ),
      padding: EdgeInsets.zero,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'FitButton',
              style: context.body1Regular(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(),
            onTap: () => context.go('/button'),
          ),
        ],
      ),
    );
  }
}
