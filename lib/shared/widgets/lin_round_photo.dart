import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class LinRoundPhoto extends StatelessWidget {
  const LinRoundPhoto({super.key, required this.onTap, this.radius});
  final Function() onTap;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        minRadius: radius ?? 20,
        child: const Icon(FeatherIcons.user),
      ),
    );
  }
}
