part of 'games_bloc.dart';

enum GamesUploadStatus { initial, progress, error }

class GamesState extends Equatable {
  final GamesUploadStatus status;
  final String? errorMessage;
  final UserModel currentUser;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamesState({required this.status, this.errorMessage, required this.currentUser});
  factory GamesState.initial() {
    return GamesState(
      status: GamesUploadStatus.progress,
      currentUser: UserModel.empty(),
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser];

  GamesState copyWith({
    GamesUploadStatus? status,
    String? errorMessage,
    UserModel? currentUser,
  }) {
    return GamesState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentUser: currentUser ?? this.currentUser);
  }
}
