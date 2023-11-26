import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'game_play_state.dart';

class GamePlayCubit extends Cubit<GamePlayState> {
  GamePlayCubit(this._currentUserUsecase) : super(GamePlayState.initial());

  final GetCurrentUserUsecase _currentUserUsecase;

  void init(GameModel game) async {
    final myUser = await _currentUserUsecase(NoParams());

    if (myUser.isRight()) {
      final shuffledQuestions = [...game.questions];
      shuffledQuestions.shuffle();
      emit(state.copyWith(
        status: GamePlayStatus.progress,
        currentUser: myUser.foldRight(UserModel.empty(), (r, previous) => r),
        currentGame: game,
        currentQuestion: shuffledQuestions.first,
        questionNumber: 0,
        shuffledQuestions: shuffledQuestions,
      ));
      startTimer();
    } else {
      emit(state.copyWith(status: GamePlayStatus.notLoggedIn));
    }
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      } else {
        timer.cancel();
        // Calculate and show the test result
      }
    });
  }

  void selectOrDeselectAnswer(int answerId) {
    if (state.selectedAnswers.contains(answerId)) {
      final List<int> newAnswers = [...state.selectedAnswers];
      newAnswers.remove(answerId);
      emit(state.copyWith(selectedAnswers: newAnswers));
    } else {
      final List<int> newAnswers = [...state.selectedAnswers];
      newAnswers.add(answerId);
      emit(state.copyWith(selectedAnswers: newAnswers));
    }
  }

  void loadNextTask() {
    if (state.shuffledQuestions.length > state.questionNumber + 1) {
      emit(state.copyWith(
        questionNumber: state.questionNumber + 1,
        currentQuestion: state.shuffledQuestions[state.questionNumber + 1],
        selectedAnswers: [],
      ));
    }
  }
}
