import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class HomeIconButton extends StatelessWidget {
  const HomeIconButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(PaddingConst.small),
        child: InkWell(
          onTap: onTap,
          child: SvgPicture.asset(
            allowDrawingOutsideViewBox: true,
            'assets/logo/logo.svg',
            width: 50,
            height: 50,
          ),
        ));
  }
}
