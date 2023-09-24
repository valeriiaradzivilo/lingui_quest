import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';

class TutorContainer extends StatelessWidget {
  const TutorContainer({super.key, required this.tutor});
  final TutorModel tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [const Icon(FeatherIcons.user), Text(tutor.user.firstName + tutor.user.lastName), Text(tutor.about)],
      ),
    );
  }
}
