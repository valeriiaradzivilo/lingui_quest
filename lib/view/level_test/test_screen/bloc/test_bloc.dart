import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/level_test_logic/level_test_tree.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/create_test_tasks_tree.dart';
import 'package:lingui_quest/data/usecase/get_all_test_tasks.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit(this._currentUserUsecase, this._createTestTaskTreeUsecase, this._getAllTestTasksUsecase)
      : super(TestState.initial());

  final GetCurrentUserUsecase _currentUserUsecase;
  final CreateTestTaskTreeUsecase _createTestTaskTreeUsecase;
  final GetAllTestTasksUsecase _getAllTestTasksUsecase;

  void init() async {
    //TODO: Clean
    final myUser = await _currentUserUsecase(NoParams());

    if (myUser.isRight()) {
      final allTests = await _getAllTestTasksUsecase(NoParams());
      if (allTests.isRight()) {
        final Stream<List<TestTaskModel>> allTestResult = allTests.foldRight(const Stream.empty(), (r, previous) => r);
        emit(state.copyWith(
            status: TestStatus.progress,
            testsData: allTestResult,
            currentUser: myUser.foldRight(UserModel.empty(), (r, previous) => r)));
      } else {
        emit(state.copyWith(status: TestStatus.error));
      }
    } else {
      emit(state.copyWith(status: TestStatus.notLoggedIn));
    }
  }

  void makeTree(List<TestTaskModel>? tasks) async {
    if (tasks != null) {
      emit(state.copyWith(status: TestStatus.progress));
      final createTreeRes = await _createTestTaskTreeUsecase(tasks);
      if (createTreeRes.isRight()) {
        final Node? tree = createTreeRes.foldRight(null, (r, previous) => r);
        startTimer();
        emit(state.copyWith(status: TestStatus.success, tasksTree: tree, currentTest: tree));
      } else {
        emit(state.copyWith(status: TestStatus.error));
      }
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
    Function deepEq = const ListEquality().equals;
    if (deepEq(state.selectedAnswers, state.currentTest?.testTask.correctAnswerIds)) {
// correct answer
      if (state.currentTest?.rightChild != null) {
        if (!state.currentTest!.rightChild!.isFinalNode) {
          emit(state.copyWith(
              currentTest: state.currentTest?.rightChild, selectedAnswers: [], currentLevel: state.currentTest?.level));
          return;
        } else {
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
          emit(state.copyWith(status: TestStatus.result));
          return;
        }
      }
    }
    emit(state.copyWith(status: TestStatus.result));
    return;
  }
}
