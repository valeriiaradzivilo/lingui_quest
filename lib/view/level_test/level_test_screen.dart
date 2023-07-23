import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/start/routes.dart';

class LevelTestScreen extends StatelessWidget {
  const LevelTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinMainButton(
            label: context.loc.createTestTask, onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTestTask))
      ],
    );
  }
}
