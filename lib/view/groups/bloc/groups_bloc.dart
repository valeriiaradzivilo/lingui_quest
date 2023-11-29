import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_groups_for_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_group_by_code_usecase.dart';
import 'package:lingui_quest/data/usecase/post_group_usecase.dart';

part 'groups_state.dart';

class GroupsBloc extends Cubit<GroupsState> {
  GroupsBloc(this._getCurrentUserUsecase, this._getAllGroupsForCurrentUserUsecase, this._getGroupByCodeUsecase,
      this._postGroupUsecase)
      : super(GroupsState.initial());

  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final GetAllGroupsForCurrentUserUsecase _getAllGroupsForCurrentUserUsecase;
  final GetGroupByCodeUsecase _getGroupByCodeUsecase;
  final PostGroupUsecase _postGroupUsecase;

  void getCurrentUser() async {
    final user = await _getCurrentUserUsecase(NoParams());
    if (user.isRight()) {
      final allGroups = await _getAllGroupsForCurrentUserUsecase(NoParams());
      emit(state.copyWith(
        status: GroupsStatus.initial,
        currentUser: user.foldRight(UserModel.empty(), (r, previous) => r),
        allGroups: allGroups.foldRight(Stream.empty(), (r, previous) => r),
      ));
    } else {
      emit(state.copyWith(status: GroupsStatus.notSignedIn));
    }
  }

  Future<bool> findGroupByCode(String code) async {
    final searchGroupByCodeResult = await _getGroupByCodeUsecase(code);

    return searchGroupByCodeResult.fold((l) => false, (r) {
      emit(state.copyWith(searchResultGroup: r));
      return true;
    });
  }

  Future<bool> createGroup(String name, String description) async {
    final creationRes = await _postGroupUsecase(
        GroupModel(creatorId: '', name: name, description: description, code: '', students: []));

    return creationRes.isRight();
  }
}
