import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/view/profile_page/become_tutor/tutor_form.dart';

class AlertTutor extends StatelessWidget {
  const AlertTutor({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AlertDialog(
        content: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.loc.howToBecomeTutor,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              Gap(PaddingConst.medium),
              Text(
                context.loc.areYouReady.toUpperCase(),
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        actions: [
          LinButton(
            label: context.loc.no,
            onTap: () => Navigator.pop(context),
            isTransparentBack: true,
          ),
          LinButton(
              label: context.loc.yes,
              onTap: () {
                if (!user.isTutor && EnglishLevel.englishLevelForTutors().contains(user.level)) {
                  // open form
                  Navigator.pop(context);
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      useRootNavigator: false,
                      builder: (BuildContext context) {
                        return TutorForm(
                          user: user,
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.loc.lowLevelMessage),
                      backgroundColor: theme.colorScheme.error,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
