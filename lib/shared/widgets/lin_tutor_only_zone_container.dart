import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinTutorOnlyZoneContainer extends StatelessWidget {
  const LinTutorOnlyZoneContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(PaddingConst.medium),
      child: Container(
        padding: EdgeInsets.all(PaddingConst.medium),
        decoration: BoxDecoration(
            color: theme.colorScheme.onSecondaryContainer,
            border:
                Border.all(color: theme.colorScheme.onBackground, strokeAlign: BorderSide.strokeAlignCenter, width: 2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor,
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(10, 10),
                blurStyle: BlurStyle.normal,
              ),
            ]),
        child: child,
      ),
    );
  }
}
