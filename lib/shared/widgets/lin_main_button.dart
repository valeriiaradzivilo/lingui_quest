import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinMainButton extends StatelessWidget {
  const LinMainButton(
      {super.key,
      this.icon,
      required this.label,
      required this.onTap,
      this.isEnabled = true});
  final String label;
  final Function() onTap;
  final bool isEnabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(PaddingConst.small),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!kIsWeb) Icon(icon),
                if (kIsWeb || icon == null) Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
