import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            }),
            Text(context.loc.rateTheGame),
            RatingBar.builder(
              initialRating: 3,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                  default:
                    return SizedBox();
                }
              },
              onRatingUpdate: (rating) {
                //TODO: Implement rating save
                print(rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
