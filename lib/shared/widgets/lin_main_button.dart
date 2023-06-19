import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinMainButton extends StatelessWidget {
  const LinMainButton({super.key, this.icon, required this.label, required this.onTap});
  final IconData? icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(20)),
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
