part of 'create_question_bloc.dart';

enum GameCreationStatus { initial, progress, error }

class GameCreationState extends Equatable {
  final GameCreationStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final QuestionModel question;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GameCreationState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.question,
  });
  factory GameCreationState.initial() {
    return GameCreationState(
        status: GameCreationStatus.progress, currentUser: UserModel.empty(), question: GameModel.empty());
  }

  @override
  List<Object?> get props => [status, _time, currentUser, question];

  GameCreationState copyWith(
      {GameCreationStatus? status, String? errorMessage, UserModel? currentUser, GameModel? game}) {
    return GameCreationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentUser: currentUser ?? this.currentUser,
        question: game ?? question);
  }
}
