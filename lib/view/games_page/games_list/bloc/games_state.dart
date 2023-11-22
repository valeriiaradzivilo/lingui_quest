part of 'games_bloc.dart';

enum GamesUploadStatus { initial, progress, error }

class GamesState extends Equatable {
  final GamesUploadStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final Stream<List<GameModel>> gamesList;
  final int page;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamesState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.gamesList,
    required this.page,
  });
  factory GamesState.initial() {
    return GamesState(
        status: GamesUploadStatus.progress, currentUser: UserModel.empty(), gamesList: Stream.empty(), page: 0);
  }

  @override
  List<Object?> get props => [status, _time, currentUser, gamesList];

  GamesState copyWith({
    GamesUploadStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    Stream<List<GameModel>>? gamesList,
    int? page,
  }) {
    return GamesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      gamesList: gamesList ?? this.gamesList,
      page: page ?? this.page,
    );
  }
}
