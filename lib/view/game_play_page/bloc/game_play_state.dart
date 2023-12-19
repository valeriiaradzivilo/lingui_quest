part of 'game_play_bloc.dart';

enum GamePlayStatus { progress, error, success, notLoggedIn, result }

class GamePlayState extends Equatable {
  final GamePlayStatus status;
  final String? errorMessage;
  final QuestionModel currentQuestion;
  final UserModel currentUser;
  final GameModel currentGame;
  final List<int> selectedAnswers;
  final List<QuestionModel> shuffledQuestions;
  final int questionNumber;
  final double resultInPercents;
  final List<GameErrorModel> errors;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamePlayState({
    required this.status,
    this.errorMessage,
    required this.currentQuestion,
    required this.currentUser,
    required this.currentGame,
    required this.selectedAnswers,
    required this.shuffledQuestions,
    required this.questionNumber,
    required this.resultInPercents,
    required this.errors,
  });
  factory GamePlayState.initial() {
    return GamePlayState(
      status: GamePlayStatus.progress,
      currentQuestion: QuestionModel.empty(),
      currentUser: UserModel.empty(),
      currentGame: GameModel.empty(),
      selectedAnswers: const [],
      shuffledQuestions: [],
      questionNumber: 0,
      resultInPercents: 0,
      errors: [],
    );
  }

  @override
  List<Object?> get props => [status, _time, currentQuestion, currentUser, currentGame, selectedAnswers, errors];

  GamePlayState copyWith({
    GamePlayStatus? status,
    String? errorMessage,
    QuestionModel? currentQuestion,
    UserModel? currentUser,
    GameModel? currentGame,
    List<int>? selectedAnswers,
    List<QuestionModel>? shuffledQuestions,
    int? questionNumber,
    double? resultInPercents,
    List<GameErrorModel>? errors,
  }) {
    return GamePlayState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentGame: currentGame ?? this.currentGame,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentUser: currentUser ?? this.currentUser,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      shuffledQuestions: shuffledQuestions ?? this.shuffledQuestions,
      questionNumber: questionNumber ?? this.questionNumber,
      errors: errors ?? this.errors,
      resultInPercents: resultInPercents ?? this.resultInPercents,
    );
  }
}
