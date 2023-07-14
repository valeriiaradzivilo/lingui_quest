import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinMainButton extends StatelessWidget {
  const LinMainButton(
      {super.key,
      this.icon,
      required this.label,
      required this.onTap,
      this.isEnabled = true});
  final IconData? icon;
  final String label;
  final Function() onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: Container(
        padding: EdgeInsets.all(PaddingConst.small),
        constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
