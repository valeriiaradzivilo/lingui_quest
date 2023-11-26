import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/shared/widgets/lin_game_screen.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';

class GamePlayPage extends StatelessWidget {
  const GamePlayPage({super.key, required this.game});
  final GameModel game;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GamePlayCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocBuilder<GamePlayCubit, GamePlayState>(
              bloc: cubit..init(game),
              builder: (context, state) {
                return SingleChildScrollView(
                    child: LinGameScreen(
                  question: state.currentQuestion.question,
                  options: state.currentQuestion.options,
                  selectedAnswers: state.selectedAnswers,
                  onSelected: cubit.selectOrDeselectAnswer,
                  onNextTask: cubit.loadNextTask,
                  remainingTime: state.remainingTime,
                  isFinalQuestion: state.shuffledQuestions.length == state.questionNumber + 1,
                ));
              })),
    );
  }
}
