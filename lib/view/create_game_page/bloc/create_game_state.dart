part of 'create_game_bloc.dart';

enum GameCreationStatus { initial, progress, error }

class GameCreationState extends Equatable {
  final GameCreationStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final GameModel game;
  final bool customTheme;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GameCreationState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.game,
    this.customTheme = true,
  });
  factory GameCreationState.initial() {
    return GameCreationState(
        status: GameCreationStatus.progress, currentUser: UserModel.empty(), game: GameModel.empty());
  }

  @override
  List<Object?> get props => [status, _time, currentUser, game, customTheme];

  GameCreationState copyWith({
    GameCreationStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    GameModel? game,
    bool? customTheme,
  }) {
    return GameCreationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      game: game ?? this.game,
      customTheme: customTheme ?? this.customTheme,
    );
  }
}
