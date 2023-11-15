// import 'package:feather_icons/feather_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:lingui_quest/data/models/tutor_model.dart';
// import 'package:lingui_quest/shared/constants/padding_constants.dart';

// class TutorContainer extends StatelessWidget {
//   const TutorContainer({super.key, required this.tutor});
//   final TutorModel tutor;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: EdgeInsets.all(PaddingConst.large),
//       child: Container(
//         padding: EdgeInsets.all(PaddingConst.medium),
//         decoration: BoxDecoration(
//             border: Border.all(color: theme.colorScheme.onPrimary), borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           children: [
//             const Icon(FeatherIcons.user),
//             Text(tutor.user.firstName + tutor.user.lastName),
//             SizedBox(
//               height: PaddingConst.small,
//             ),
//             Expanded(
//               child: Text(
//                 tutor.about,
//                 overflow: TextOverflow.fade,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
