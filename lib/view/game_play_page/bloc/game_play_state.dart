part of 'game_play_bloc.dart';

enum GamePlayStatus { progress, error, success, notLoggedIn, result }

class GamePlayState extends Equatable {
  final GamePlayStatus status;
  final String? errorMessage;
  final QuestionModel currentQuestion;
  final UserModel currentUser;
  final int remainingTime;
  final GameModel currentGame;
  final List<int> selectedAnswers;
  final List<QuestionModel> shuffledQuestions;
  final int questionNumber;
  final int amountOfCorrectlyAnsweredQuestions;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const GamePlayState({
    required this.status,
    this.errorMessage,
    required this.currentQuestion,
    required this.currentUser,
    required this.remainingTime,
    required this.currentGame,
    required this.selectedAnswers,
    required this.shuffledQuestions,
    required this.questionNumber,
    required this.amountOfCorrectlyAnsweredQuestions,
  });
  factory GamePlayState.initial() {
    return GamePlayState(
        status: GamePlayStatus.progress,
        currentQuestion: QuestionModel.empty(),
        currentUser: UserModel.empty(),
        remainingTime: 3600,
        currentGame: GameModel.empty(),
        selectedAnswers: const [],
        shuffledQuestions: [],
        questionNumber: 0,
        amountOfCorrectlyAnsweredQuestions: 0);
  }

  @override
  List<Object?> get props => [status, _time, currentQuestion, currentUser, remainingTime, currentGame, selectedAnswers];

  GamePlayState copyWith({
    GamePlayStatus? status,
    String? errorMessage,
    QuestionModel? currentQuestion,
    UserModel? currentUser,
    int? remainingTime,
    GameModel? currentGame,
    List<int>? selectedAnswers,
    List<QuestionModel>? shuffledQuestions,
    int? questionNumber,
    int? amountOfCorrectlyAnsweredQuestions,
  }) {
    return GamePlayState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentGame: currentGame ?? this.currentGame,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      currentUser: currentUser ?? this.currentUser,
      remainingTime: remainingTime ?? this.remainingTime,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      shuffledQuestions: shuffledQuestions ?? this.shuffledQuestions,
      questionNumber: questionNumber ?? this.questionNumber,
      amountOfCorrectlyAnsweredQuestions: amountOfCorrectlyAnsweredQuestions ?? this.amountOfCorrectlyAnsweredQuestions,
    );
  }
}
