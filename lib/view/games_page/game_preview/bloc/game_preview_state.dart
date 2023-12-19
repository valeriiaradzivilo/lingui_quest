part of 'game_preview_cubit.dart';

enum GamePreviewStatus { initial, progress, error }

class GamePreviewState extends Equatable {
  final GamePreviewStatus status;
  final String? errorMessage;
  final GameModel game;
  final UserModel currentUser;
  final List<GameResultFullModel> gameResults;

  const GamePreviewState({
    required this.status,
    this.errorMessage,
    required this.game,
    required this.currentUser,
    required this.gameResults,
  });
  factory GamePreviewState.initial() {
    return GamePreviewState(
      status: GamePreviewStatus.progress,
      game: GameModel.empty(),
      currentUser: UserModel.empty(),
      gameResults: [],
    );
  }

  @override
  List<Object?> get props => [status, game, gameResults, currentUser];

  GamePreviewState copyWith({
    GamePreviewStatus? status,
    String? errorMessage,
    GameModel? game,
    UserModel? currentUser,
    List<GameResultFullModel>? gameResults,
  }) {
    return GamePreviewState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      game: game ?? this.game,
      currentUser: currentUser ?? this.currentUser,
      gameResults: gameResults ?? this.gameResults,
    );
  }
}
