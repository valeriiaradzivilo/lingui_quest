import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_error_model.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/game_result_model.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/post_game_result_usecase.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'game_play_state.dart';

class GamePlayCubit extends Cubit<GamePlayState> {
  GamePlayCubit(this._currentUserUsecase, this._rateGameUsecase, this._postGameResultUsecase)
      : super(GamePlayState.initial());

  late final ValueStream<int> remainingTimeStream = _remainingTimeController.stream;

  void init(GameModel game) async {
    emit(state.copyWith(status: GamePlayStatus.progress));
    final myUser = await _currentUserUsecase(NoParams());

    if (myUser.isRight()) {
      _remainingTimeController.add(game.time * 60);
      final shuffledQuestions = [...game.questions];
      shuffledQuestions.shuffle();
      startTimer();
      emit(state.copyWith(
        status: GamePlayStatus.success,
        currentUser: myUser.foldRight(UserModel.empty(), (r, previous) => r),
        currentGame: game,
        currentQuestion: shuffledQuestions.first,
        questionNumber: 0,
        shuffledQuestions: shuffledQuestions,
      ));
    } else {
      emit(state.copyWith(status: GamePlayStatus.notLoggedIn));
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1050), (_) {
      if (_remainingTimeController.value > 0) {
        _remainingTimeController.add(_remainingTimeController.value - 1);
      } else {
        emit(state.copyWith(status: GamePlayStatus.result));
        // Calculate and show the test result
      }
    });
  }

  void selectOrDeselectAnswer(int answerId) {
    if (state.currentQuestion.correctAnswers.length > 1) {
      if (state.selectedAnswers.contains(answerId)) {
        final List<int> newAnswers = [...state.selectedAnswers];
        newAnswers.remove(answerId);
        emit(state.copyWith(selectedAnswers: newAnswers));
      } else {
        final List<int> newAnswers = [...state.selectedAnswers];
        newAnswers.add(answerId);
        emit(state.copyWith(selectedAnswers: newAnswers));
      }
    } else {
      emit(state.copyWith(selectedAnswers: [answerId]));
    }
  }

  void loadNextTask() async {
    Function unOrdDeepEq = DeepCollectionEquality.unordered().equals;
    final isCorrectAnswer = unOrdDeepEq(state.currentQuestion.correctAnswers, state.selectedAnswers);
    final errors = [...state.errors];
    if (!isCorrectAnswer) {
      errors.add(GameErrorModel(
          question: state.currentQuestion,
          expectedResult: state.currentQuestion.correctAnswers.join(','),
          actualResult: state.selectedAnswers.join(',')));
      emit(state.copyWith(errors: errors));
    }

    if (state.shuffledQuestions.length > state.questionNumber + 1) {
      emit(state.copyWith(
        questionNumber: state.questionNumber + 1,
        currentQuestion: state.shuffledQuestions[state.questionNumber + 1],
        selectedAnswers: [],
        resultInPercents:
            (state.currentGame.questions.length - state.errors.length) * 100 / state.currentGame.questions.length,
      ));
    } else {
      emit(state.copyWith(status: GamePlayStatus.progress));
      final result =
          (state.currentGame.questions.length - state.errors.length) * 100 / state.currentGame.questions.length;

      if (state.currentUser.userId.isNotEmpty) {
        await _postGameResultUsecase(
          GameResultModel(
              userId: state.currentUser.userId,
              gameId: state.currentGame.id,
              result: result,
              timeFinished: DateTime.now().millisecondsSinceEpoch,
              errors: state.errors),
        );
      }
      emit(state.copyWith(status: GamePlayStatus.result, resultInPercents: result));
    }
  }

  void deleteResults() {
    _remainingTimeController.add(state.currentGame.time);
    timer?.cancel();
    emit(GamePlayState.initial());
  }

  Future<bool> rateTheGame(double rate) async {
    final res = await _rateGameUsecase(GameRate(state.currentGame.id, rate));
    return res.isRight();
  }

  // game time in creation is set in minutes
  // the timer should update each second
  late final _remainingTimeController = BehaviorSubject.seeded(state.currentGame.time * 60);
  Timer? timer;
  final GetCurrentUserUsecase _currentUserUsecase;
  final RateGameUsecase _rateGameUsecase;
  final PostGameResultUsecase _postGameResultUsecase;
}
