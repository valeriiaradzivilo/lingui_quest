import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinMainButton extends StatelessWidget {
  const LinMainButton({super.key, this.icon, required this.label, required this.onTap, this.isEnabled = true});
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
          padding: EdgeInsets.all(PaddingConst.medium),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  SizedBox(
                    width: PaddingConst.medium,
                  )
                ],
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
