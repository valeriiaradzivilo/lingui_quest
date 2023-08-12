import 'package:flutter/material.dart';

class LinRoundPhoto extends StatelessWidget {
  const LinRoundPhoto({super.key, required this.onTap, this.radius, required this.child});
  final Function() onTap;
  final double? radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          minRadius: radius ?? 20,
          child: child,
        ),
      ),
    );
  }
}
