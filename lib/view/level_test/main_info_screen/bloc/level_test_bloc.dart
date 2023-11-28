import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'level_test_state.dart';

class LevelTestBloc extends Cubit<LevelTestState> {
  LevelTestBloc(this._getCurrentUserUsecase) : super(LevelTestState.initial());

  final GetCurrentUserUsecase _getCurrentUserUsecase;

  void getCurrentUser() async {
    final user = await _getCurrentUserUsecase(NoParams());
    if (user.isRight()) {
      emit(state.copyWith(
          status: LevelTestStatus.initial, currentUser: user.foldRight(UserModel.empty(), (r, previous) => r)));
    } else {
      emit(state.copyWith(status: LevelTestStatus.notSignedIn));
    }
  }
}
