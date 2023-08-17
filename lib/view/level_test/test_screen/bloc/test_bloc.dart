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
        emit(state.copyWith(
            status: TestStatus.success,
            testsData: allTests.foldRight(const Stream.empty(), (r, previous) => r),
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
        emit(state.copyWith(status: TestStatus.success, tasksTree: createTreeRes.foldRight(null, (r, previous) => r)));
      } else {
        emit(state.copyWith(status: TestStatus.error));
      }
    }
  }
}
