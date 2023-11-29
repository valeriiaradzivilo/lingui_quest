part of 'groups_bloc.dart';

enum GroupsStatus { initial, progress, error, notSignedIn }

class GroupsState extends Equatable {
  final GroupsStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final Stream<List<GroupModel>> allGroups;
  final GroupModel? searchResultGroup;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GroupsState(
      {required this.status,
      this.errorMessage,
      required this.currentUser,
      required this.allGroups,
      required this.searchResultGroup});
  factory GroupsState.initial() {
    return GroupsState(
      status: GroupsStatus.progress,
      currentUser: UserModel.empty(),
      allGroups: Stream.empty(),
      searchResultGroup: null,
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser, allGroups, searchResultGroup];

  GroupsState copyWith({
    GroupsStatus? status,
    String? errorMessage,
    Stream<List<LevelTestTaskModel>>? testsData,
    UserModel? currentUser,
    Stream<List<GroupModel>>? allGroups,
    GroupModel? searchResultGroup,
  }) {
    return GroupsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      allGroups: allGroups ?? this.allGroups,
      searchResultGroup: searchResultGroup,
    );
  }
}
