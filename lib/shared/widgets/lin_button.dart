import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinButton extends StatelessWidget {
  const LinButton(
      {super.key,
      this.icon,
      required this.label,
      required this.onTap,
      this.isEnabled = true,
      this.isTransparentBack = false});
  final String label;
  final Function() onTap;
  final bool isEnabled;
  final IconData? icon;
  final bool isTransparentBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(PaddingConst.small),
          decoration: BoxDecoration(
            color: isTransparentBack ? Colors.transparent : Theme.of(context).colorScheme.primary,
          ),
          child: IntrinsicWidth(
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
                  Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: !isTransparentBack ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
