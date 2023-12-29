import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class LinMainButton extends StatelessWidget {
  const LinMainButton({super.key, this.icon, required this.label, required this.onTap, this.isEnabled = true});
  final IconData? icon;
  final String label;
  final Function()? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        child: Container(
          padding: EdgeInsets.all(PaddingConst.medium),
          decoration: BoxDecoration(
            color: !isEnabled || onTap == null ? Colors.transparent : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: PaddingConst.extraSmall,
                blurRadius: PaddingConst.extraSmall,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Flexible(child: Icon(icon)),
                  Gap(PaddingConst.medium),
                ],
                Flexible(
                    flex: 2,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
