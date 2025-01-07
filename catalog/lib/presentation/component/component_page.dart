import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      backgroundColor: context.fitColors.grey800,
      padding: EdgeInsets.zero,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'FitButton',
              style: context.body1(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.grey0),
            onTap: () => context.go('/button'),
          ),
          ListTile(
            title: Text(
              'FitImage',
              style: context.body1(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.grey0),
            onTap: () => context.go('/image'),
          ),
          ListTile(
            title: Text(
              'FitCheckBox',
              style: context.body1(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.grey0),
            onTap: () => context.go('/check_box'),
          ),
          ListTile(
            title: Text(
              'FitCard',
              style: context.body1(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.grey0),
            onTap: () => context.go('/card'),
          ),
        ],
      ),
    );
  }
}
