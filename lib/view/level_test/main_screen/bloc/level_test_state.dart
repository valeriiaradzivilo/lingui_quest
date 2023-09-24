part of 'level_test_bloc.dart';

enum LevelTestStatus { initial, progress, error, notSignedIn }

class LevelTestState extends Equatable {
  final LevelTestStatus status;
  final String? errorMessage;
  final UserModel currentUser;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const LevelTestState({required this.status, this.errorMessage, required this.currentUser});
  factory LevelTestState.initial() {
    return LevelTestState(
      status: LevelTestStatus.progress,
      currentUser: UserModel.empty(),
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser];

  LevelTestState copyWith({
    LevelTestStatus? status,
    String? errorMessage,
    Stream<List<TestTaskModel>>? testsData,
    UserModel? currentUser,
  }) {
    return LevelTestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentUser: currentUser ?? this.currentUser);
  }
}
