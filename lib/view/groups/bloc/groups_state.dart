part of 'groups_bloc.dart';

enum GroupsStatus { initial, progress, error, notSignedIn }

class GroupsState extends Equatable {
  final GroupsStatus status;
  final String? errorMessage;
  final UserModel currentUser;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GroupsState({required this.status, this.errorMessage, required this.currentUser});
  factory GroupsState.initial() {
    return GroupsState(
      status: GroupsStatus.progress,
      currentUser: UserModel.empty(),
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser];

  GroupsState copyWith({
    GroupsStatus? status,
    String? errorMessage,
    Stream<List<LevelTestTaskModel>>? testsData,
    UserModel? currentUser,
  }) {
    return GroupsState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentUser: currentUser ?? this.currentUser);
  }
}
