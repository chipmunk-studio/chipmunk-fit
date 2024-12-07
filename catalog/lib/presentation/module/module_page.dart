import 'package:chipfit/foundation/index.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:chipfit/module/fit_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: context.fitColors.grey800,
      body: Column(
        children: [
          ListTile(
            title: Text(
              'FitAnimationText',
              style: context.body1Regular(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.white),
            onTap: () => context.go('/animation_text'),
          ),
          ListTile(
            title: Text(
              'FitDialog',
              style: context.body1Regular(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.white),
            onTap: () => context.go('/dialog'),
          ),
          ListTile(
            title: Text(
              'FitBottomSheet',
              style: context.body1Regular(),
            ),
            trailing: Assets.icons.icArrowRight16.svg(color: context.fitColors.white),
            onTap: () => context.go('/bottom_sheet'),
          ),
        ],
      ),
    );
  }
}
