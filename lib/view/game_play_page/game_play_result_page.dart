import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';

class GamePlayResultPage extends StatefulWidget {
  const GamePlayResultPage({super.key});

  @override
  State<GamePlayResultPage> createState() => _GamePlayResultPageState();
}

class _GamePlayResultPageState extends State<GamePlayResultPage> {
  late GamePlayCubit bloc;

  double rate = 3;

  @override
  void dispose() {
    bloc.deleteResults();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<GamePlayCubit>(context);
    return BlocBuilder<GamePlayCubit, GamePlayState>(
      builder: (context, state) => Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${context.loc.resultGame} ${state.resultInPercents}%'),
              Gap(PaddingConst.medium),
              Text(switch (state.resultInPercents / 100) {
                > 0.8 => context.loc.highScoreMessageGame,
                > 0.5 => context.loc.averageScoreMessageGame,
                _ => context.loc.lowScoreMessageGame,
              }),
              if (state.currentUser != UserModel.empty()) ...[
                Text(context.loc.rateTheGame),
                Gap(PaddingConst.large),
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
                    setState(() => rate = rating);
                  },
                ),
                Gap(PaddingConst.small),
                Center(
                  child: LinMainButton(
                      label: context.loc.rate,
                      onTap: () async {
                        await bloc.rateTheGame(rate);
                        Navigator.of(context).pushNamed(AppRoutes.initial.path);
                      }),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
