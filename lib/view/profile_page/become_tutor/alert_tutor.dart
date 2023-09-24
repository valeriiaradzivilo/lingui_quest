import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';

class AlertTutor extends StatelessWidget {
  const AlertTutor({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Center(
          child: Text(context.loc.howToBecomeTutor),
        ),
        actions: [
          LinButton(label: context.loc.no, onTap: () => Navigator.pop(context)),
          LinButton(
              label: context.loc.yes,
              onTap: () {
                if (!user.isTeacher && EnglishLevel.englishLevelForTutors().contains(user.level)) {
                  // open form
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.loc.lowLevelMessage),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
