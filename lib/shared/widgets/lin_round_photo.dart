import 'package:flutter/material.dart';

class LinRoundPhoto extends StatelessWidget {
  const LinRoundPhoto({super.key, required this.onTap, this.radius, required this.child});
  final Function()? onTap;
  final double? radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        minRadius: radius ?? 20,
        child: child,
      ),
    );
  }
}
