part of 'games_list_bloc.dart';

enum GamesUploadStatus { initial, progress, error, search }

class GamesListState extends Equatable {
  final GamesUploadStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final Stream<List<GameModel>> gamesList;
  final int page;
  final List<GameModel> searchResult;
  final GameSearchModel searchModel;
  final int totalPageCount;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamesListState(
      {required this.status,
      this.errorMessage,
      required this.currentUser,
      required this.gamesList,
      required this.page,
      this.searchResult = const [],
      required this.searchModel,
      required this.totalPageCount});
  factory GamesListState.initial() {
    return GamesListState(
      status: GamesUploadStatus.progress,
      currentUser: UserModel.empty(),
      gamesList: Stream.empty(),
      page: 0,
      searchModel: GameSearchModel.empty(),
      totalPageCount: 1,
    );
  }

  @override
  List<Object?> get props => [
        status,
        _time,
        currentUser,
        gamesList,
        searchResult,
        searchModel,
        totalPageCount,
        page,
      ];

  GamesListState copyWith({
    GamesUploadStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    Stream<List<GameModel>>? gamesList,
    int? page,
    List<GameModel>? searchResult,
    GameSearchModel? searchModel,
    int? totalPageCount,
  }) {
    return GamesListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      gamesList: gamesList ?? this.gamesList,
      page: page ?? this.page,
      searchResult: searchResult ?? this.searchResult,
      searchModel: searchModel ?? this.searchModel,
      totalPageCount: totalPageCount ?? this.totalPageCount,
    );
  }
}
