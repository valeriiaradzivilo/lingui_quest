import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/create_test_tasks_tree_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_test_tasks_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/set_new_english_level_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:rxdart/rxdart.dart';

part 'level_test_play_state.dart';

class LevelTestPlayCubit extends Cubit<LevelTestPlayState> {
  LevelTestPlayCubit(this._currentUserUsecase, this._createTestTaskTreeUsecase, this._getAllTestTasksUsecase,
      this._setNewEnglishLevelUsecase)
      : super(LevelTestPlayState.initial());

  late final ValueStream<int> remainingTimeStream = _remainingTimeController.stream;

  void init() async {
    emit(state.copyWith(status: TestStatus.progress));

    final myUser = await _currentUserUsecase(NoParams());

    if (myUser.isRight()) {
      final allTests = await _getAllTestTasksUsecase(NoParams());
      _remainingTimeController.add(state.remainingTime);
      if (allTests.isRight()) {
        final Stream<List<LevelTestTaskModel>> allTestResult =
            allTests.foldRight(const Stream.empty(), (r, previous) => r);
        startTimer();
        emit(state.copyWith(
            status: TestStatus.success,
            testsData: allTestResult,
            currentUser: myUser.foldRight(UserModel.empty(), (r, previous) => r)));
      } else {
        emit(state.copyWith(status: TestStatus.error));
      }
    }
  }

  void makeTree(List<LevelTestTaskModel>? tasks) async {
    if (tasks != null) {
      emit(state.copyWith(status: TestStatus.progress));
      final createTreeRes = await _createTestTaskTreeUsecase(tasks);
      if (createTreeRes.isRight()) {
        final Node? tree = createTreeRes.foldRight(null, (r, previous) => r);
        emit(state.copyWith(status: TestStatus.success, tasksTree: tree, currentTest: tree));
      } else {
        emit(state.copyWith(status: TestStatus.error));
      }
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1050), (_) {
      if (_remainingTimeController.value > 0) {
        _remainingTimeController.add(_remainingTimeController.value - 1);
      } else {
        emit(state.copyWith(status: TestStatus.result));
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
    Function deepEq = const ListEquality().equals;
    if (deepEq(state.selectedAnswers, state.currentTest?.testTask.correctAnswerIds)) {
// correct answer
      if (state.currentTest?.rightChild != null) {
        if (!state.currentTest!.rightChild!.isFinalNode) {
          emit(state.copyWith(
              currentTest: state.currentTest?.rightChild, selectedAnswers: [], currentLevel: state.currentTest?.level));
          return;
        } else {
          _setNewEnglishLevelUsecase(state.currentLevel);
          emit(state.copyWith(status: TestStatus.result));
          return;
        }
      }
    } else {
      if (state.currentTest?.leftChild != null) {
        if (!state.currentTest!.leftChild!.isFinalNode) {
          emit(state.copyWith(
              currentTest: state.currentTest?.leftChild, selectedAnswers: [], currentLevel: state.currentTest?.level));
          return;
        } else {
          _setNewEnglishLevelUsecase(state.currentLevel);
          emit(state.copyWith(status: TestStatus.result));
          return;
        }
      }
    }
    _setNewEnglishLevelUsecase(state.currentLevel);
    emit(state.copyWith(status: TestStatus.result));
    return;
  }

  void deleteTestData() {
    _remainingTimeController.add(state.remainingTime);
    timer?.cancel;
    emit(LevelTestPlayState.initial());
  }

  late final _remainingTimeController = BehaviorSubject.seeded(state.remainingTime);
  Timer? timer;
  final GetCurrentUserUsecase _currentUserUsecase;
  final CreateTestTaskTreeUsecase _createTestTaskTreeUsecase;
  final GetAllTestTasksUsecase _getAllTestTasksUsecase;
  final SetNewEnglishLevelUsecase _setNewEnglishLevelUsecase;
}
