import 'package:chipfit/foundation/colors.dart';
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
      padding: EdgeInsets.zero,
      backgroundColor: context.fitColors.backgroundAlternative,
      isLoading: false,
      body: Column(
        children: [
          ListTile(
            title: Text(
              'FitTextStyle',
              style: context.body1(),
            ),
            trailing: ChipAssets.icons.icArrowRight16.svg(color: context.fitColors.grey900),
            onTap: () => context.go('/textstyle'),
          ),
          ListTile(
            title: Text(
              'FitAnimation',
              style: context.body1(),
            ),
            trailing: ChipAssets.icons.icArrowRight16.svg(color: context.fitColors.grey900),
            onTap: () => context.go('/animation'),
          ),
          ListTile(
            title: Text(
              'FitColor',
              style: context.body1(),
            ),
            trailing: ChipAssets.icons.icArrowRight16.svg(color: context.fitColors.grey900),
            onTap: () => context.go('/color'),
          ),
        ],
      ),
    );
  }
}
