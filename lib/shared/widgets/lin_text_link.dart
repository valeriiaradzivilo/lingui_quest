import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:url_launcher/url_launcher.dart';

class LinTextLink extends StatelessWidget {
  const LinTextLink({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (text.contains('www') || text.contains('http')) {
      return InkWell(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(text))) {
            await launchUrl(
              Uri.parse(text),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: SelectableText('${context.loc.couldNotOpenTheLink}:$text'),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        child: Text(text),
      );
    }
    return SelectableText(text);
  }
}
