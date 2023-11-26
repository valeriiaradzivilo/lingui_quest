part of 'game_preview_cubit.dart';

enum GamePreviewStatus { initial, progress, error }

class GamePreviewState extends Equatable {
  final GamePreviewStatus status;
  final String? errorMessage;
  final GameModel game;

  const GamePreviewState({required this.status, this.errorMessage, required this.game});
  factory GamePreviewState.initial() {
    return GamePreviewState(status: GamePreviewStatus.progress, game: GameModel.empty());
  }

  @override
  List<Object?> get props => [status, game];

  GamePreviewState copyWith({
    GamePreviewStatus? status,
    String? errorMessage,
    GameModel? game,
  }) {
    return GamePreviewState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      game: game ?? this.game,
    );
  }
}
