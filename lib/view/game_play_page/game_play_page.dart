import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_game_screen.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';
import 'package:lingui_quest/view/game_play_page/game_play_result_page.dart';

class GamePlayPage extends StatefulWidget {
  const GamePlayPage({super.key, required this.game});
  final GameModel game;

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage> {
  late final GamePlayCubit cubit;
  @override
  void dispose() {
    cubit.deleteResults();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<GamePlayCubit>(context);
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.all(PaddingConst.large),
          child: BlocBuilder<GamePlayCubit, GamePlayState>(
              bloc: cubit..init(widget.game),
              builder: (context, state) {
                switch (state.status) {
                  case GamePlayStatus.success:
                    return SingleChildScrollView(
                        child: LinGameScreen(
                      question: state.currentQuestion.question,
                      options: state.currentQuestion.options,
                      selectedAnswers: state.selectedAnswers,
                      onSelected: cubit.selectOrDeselectAnswer,
                      onNextTask: cubit.loadNextTask,
                      remainingTime: state.remainingTime,
                      isFinalQuestion: state.shuffledQuestions.length == state.questionNumber + 1,
                      isOneAnswer: state.currentQuestion.correctAnswers.length == 1,
                    ));
                  case GamePlayStatus.result:
                    return GamePlayResultPage(
                      percentResult: state.amountOfCorrectlyAnsweredQuestions / state.currentGame.questions.length,
                    );

                  case GamePlayStatus.notLoggedIn:
                    return Center(child: Text(context.loc.notLoggedIn));

                  case GamePlayStatus.error:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(context.loc.error), Text(context.loc.tryAgain), Text(state.errorMessage ?? '')],
                    );

                  default:
                    return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
