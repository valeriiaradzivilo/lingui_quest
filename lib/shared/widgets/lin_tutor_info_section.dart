import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_text_link.dart';

class LinTutorInfoSection extends StatelessWidget {
  const LinTutorInfoSection({super.key, required this.tutor, this.user});
  final TutorModel tutor;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(PaddingConst.large),
      decoration: ShapeDecoration(
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: theme.colorScheme.onSecondaryContainer,
                width: 3,
              ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.loc.tutorProfile.toUpperCase(),
            style: theme.textTheme.displaySmall,
          ),
          Gap(PaddingConst.medium),
          Text('${context.loc.aboutTutor} : ${tutor.about}'),
          Gap(PaddingConst.medium),
          Text('${context.loc.priceTutor} : '),
          for (final price in tutor.price.entries) Text('${price.key} - ${price.value} ${tutor.currency}'),
          Gap(PaddingConst.medium),
          Text(context.loc.contactsTutor),
          for (final contact in tutor.contacts.entries)
            Row(
              children: [
                Text('${contact.key} -> '),
                LinTextLink(text: contact.value),
              ],
            )
        ],
      ),
    );
  }
}
