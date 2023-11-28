import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'groups_state.dart';

class GroupsBloc extends Cubit<GroupsState> {
  GroupsBloc(this._getCurrentUserUsecase) : super(GroupsState.initial());

  final GetCurrentUserUsecase _getCurrentUserUsecase;

  void getCurrentUser() async {
    final user = await _getCurrentUserUsecase(NoParams());
    if (user.isRight()) {
      emit(state.copyWith(
          status: GroupsStatus.initial, currentUser: user.foldRight(UserModel.empty(), (r, previous) => r)));
    } else {
      emit(state.copyWith(status: GroupsStatus.notSignedIn));
    }
  }
}
