import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinQuestionText extends StatelessWidget {
  const LinQuestionText({super.key, required this.textTask, required this.insertedText});
  final String textTask;
  final List<String>? insertedText;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (insertedText != null && (insertedText?.isNotEmpty ?? false)) {
      return Column(
        children: [
          for (final answer in insertedText!)
            Padding(
              padding: EdgeInsets.all(PaddingConst.small),
              child: TextTaskType.getType(textTask).getWidget(textTask, answer, theme),
            ),
        ],
      );
    } else {
      return TextTaskType.getType(textTask).getWidget(textTask, null, theme);
    }
  }
}

class MissedTextBox extends StatelessWidget {
  const MissedTextBox({super.key, required this.insertedText});
  final String? insertedText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(2),
      color: theme.colorScheme.surfaceTint.withOpacity(0.5),
      child: Text(insertedText != null && (insertedText?.isNotEmpty ?? false) ? insertedText! : '                '),
    );
  }
}

// TODO: Move this enum to shared -> enum
enum TextTaskType {
  regularText, // just text 'Choose the correct option'
  missedText, // I ___ like your head.
  colonText; //'Fill in the gap : I ___ you.

  factory TextTaskType.getType(String text) {
    if (!text.contains(RegExp('[_"\']'))) {
      return TextTaskType.regularText;
    } else if (text.contains('___')) {
      if (text.contains(':') && !text.contains(RegExp('["\']'))) {
        return TextTaskType.colonText;
      } else {
        return TextTaskType.missedText;
      }
    }

    return TextTaskType.regularText;
  }

  Widget getWidget(String textTask, String? answer, ThemeData theme) {
    switch (this) {
      case TextTaskType.regularText:
        return Text(textTask);
      case TextTaskType.missedText:
        final String textBefore = textTask.substring(0, textTask.indexOf('_'));
        final String textAfter = textTask.substring(textTask.lastIndexOf('_') + 1);

        return Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: [
            Text(textBefore),
            MissedTextBox(
              insertedText: answer,
            ),
            Text(textAfter),
          ],
        );
      case TextTaskType.colonText:
        final String textBeforeColon = textTask.substring(0, textTask.indexOf(':') + 1);
        final String textAfterColon = textTask.substring(textTask.indexOf(':') + 1).trim();
        final String textBeforeMissed = textAfterColon.substring(0, textAfterColon.indexOf('_'));
        final String textAfterMissed = textAfterColon.substring(textAfterColon.lastIndexOf('_'));

        return Wrap(
          children: [
            Text(
              textBeforeColon.toUpperCase(),
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: theme.colorScheme.error),
            ),
            Text(textBeforeMissed),
            MissedTextBox(
              insertedText: answer,
            ),
            Text(textAfterMissed),
          ],
        );
    }
  }
}
