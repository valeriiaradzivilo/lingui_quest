part of 'games_list_bloc.dart';

enum GamesUploadStatus { initial, progress, error }

class GamesListState extends Equatable {
  final GamesUploadStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final Stream<List<GameModel>> gamesList;
  final int page;
  final List<GameModel> searchResult;
  final GameSearchModel searchModel;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamesListState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.gamesList,
    required this.page,
    this.searchResult = const [],
    required this.searchModel,
  });
  factory GamesListState.initial() {
    return GamesListState(
      status: GamesUploadStatus.progress,
      currentUser: UserModel.empty(),
      gamesList: Stream.empty(),
      page: 0,
      searchModel: GameSearchModel(),
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser, gamesList, searchResult, searchModel];

  GamesListState copyWith({
    GamesUploadStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    Stream<List<GameModel>>? gamesList,
    int? page,
    List<GameModel>? searchResult,
    GameSearchModel? searchModel,
  }) {
    return GamesListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      gamesList: gamesList ?? this.gamesList,
      page: page ?? this.page,
      searchResult: searchResult ?? this.searchResult,
      searchModel: searchModel ?? this.searchModel,
    );
  }
}
