import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/group_full_info.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/level_test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_all_groups_for_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_full_group_info.dart';
import 'package:lingui_quest/data/usecase/get_group_by_code_usecase.dart';
import 'package:lingui_quest/data/usecase/post_group_usecase.dart';
import 'package:lingui_quest/data/usecase/request_to_join_group_usecase.dart';
import 'package:lingui_quest/start/app_routes.dart';

part 'groups_state.dart';

class GroupsBloc extends Cubit<GroupsState> {
  GroupsBloc(
    this._getCurrentUserUsecase,
    this._getAllGroupsForCurrentUserUsecase,
    this._getGroupByCodeUsecase,
    this._postGroupUsecase,
    this._getFullGroupInfoUsecase,
    this._requestToJoinGroupUsecase,
  ) : super(GroupsState.initial());

  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final GetAllGroupsForCurrentUserUsecase _getAllGroupsForCurrentUserUsecase;
  final GetGroupByCodeUsecase _getGroupByCodeUsecase;
  final PostGroupUsecase _postGroupUsecase;
  final GetFullGroupInfoUsecase _getFullGroupInfoUsecase;
  final RequestToJoinGroupUsecase _requestToJoinGroupUsecase;

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

  Future chosenGroup(GroupModel group) async {
    final fullInfo = await _getFullGroupInfoUsecase(group);
    emit(state.copyWith(chosenGroup: fullInfo.foldRight(null, (r, previous) => r)));
  }

  void findChosenGroupByCode(String codeFromPath) async {
    emit(state.copyWith(status: GroupsStatus.progress));

    if (state.currentUser.userId.isEmpty) {
      final user = await _getCurrentUserUsecase(NoParams());
      emit(state.copyWith(currentUser: user.foldRight(UserModel.empty(), (r, previous) => r)));
    }
    final code = codeFromPath.replaceAll(AppRoutes.group.path, '');
    final groupFromCodeRes = await _getGroupByCodeUsecase(code);
    groupFromCodeRes.fold((l) {
      emit(state.copyWith(status: GroupsStatus.error, chosenGroup: null, errorMessage: 'Could not find the group'));
      return;
    }, (r) async {
      if (r.creatorId == state.currentUser.userId || r.students.contains(state.currentUser.userId)) {
        final fullInfoRes = await _getFullGroupInfoUsecase(r);
        emit(
            state.copyWith(status: GroupsStatus.initial, chosenGroup: fullInfoRes.foldRight(null, (r, previous) => r)));
        return;
      }
    });

    emit(state.copyWith(
        status: GroupsStatus.error, errorMessage: 'You do not have access to this group. Join the group firstly.'));
  }

  void deleteChosenGroup() {
    emit(state.copyWith(chosenGroup: null));
  }

  Future<bool> sendRequestToJoinTheGroup() async {
    if (state.searchResultGroup != null) {
      final requestRes = await _requestToJoinGroupUsecase(state.searchResultGroup!.code);
      return requestRes.isRight();
    }
    return false;
  }
}
