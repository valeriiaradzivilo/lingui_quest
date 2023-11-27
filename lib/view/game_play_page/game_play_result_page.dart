import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class GamePlayResultPage extends StatelessWidget {
  const GamePlayResultPage({super.key, required this.percentResult});
  final double percentResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${context.loc.resultGame} ${percentResult * 100}%'),
            Gap(PaddingConst.medium),
            Text(switch (percentResult) {
              > 0.8 => context.loc.highScoreMessageGame,
              > 0.5 => context.loc.averageScoreMessageGame,
              _ => context.loc.lowScoreMessageGame,
            })
          ],
        ),
      ),
    );
  }
}
