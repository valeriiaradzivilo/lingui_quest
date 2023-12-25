part of 'level_test_play_bloc.dart';

enum TestStatus { progress, error, success, result }

class LevelTestPlayState extends Equatable {
  final TestStatus status;
  final String? errorMessage;
  final Node? tasksTree;
  final EnglishLevel currentLevel;
  final Stream<List<LevelTestTaskModel>> testsData;
  final UserModel currentUser;
  final int remainingTime;
  final Node? currentTest;
  final List<int> selectedAnswers;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const LevelTestPlayState(
      {required this.status,
      this.errorMessage,
      required this.currentLevel,
      required this.tasksTree,
      required this.testsData,
      required this.currentUser,
      required this.remainingTime,
      required this.currentTest,
      required this.selectedAnswers});
  factory LevelTestPlayState.initial() {
    return LevelTestPlayState(
        status: TestStatus.progress,
        currentLevel: EnglishLevel.a1,
        tasksTree: null,
        testsData: const Stream.empty(),
        currentUser: UserModel.empty(),
        remainingTime: 3600,
        currentTest: null,
        selectedAnswers: const []);
  }

  @override
  List<Object?> get props =>
      [status, _time, currentLevel, tasksTree, testsData, currentUser, remainingTime, currentTest, selectedAnswers];

  LevelTestPlayState copyWith({
    TestStatus? status,
    String? errorMessage,
    EnglishLevel? currentLevel,
    Node? tasksTree,
    Stream<List<LevelTestTaskModel>>? testsData,
    UserModel? currentUser,
    int? remainingTime,
    Node? currentTest,
    List<int>? selectedAnswers,
  }) {
    return LevelTestPlayState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentLevel: currentLevel ?? this.currentLevel,
        tasksTree: tasksTree ?? this.tasksTree,
        testsData: testsData ?? this.testsData,
        currentUser: currentUser ?? this.currentUser,
        remainingTime: remainingTime ?? this.remainingTime,
        currentTest: currentTest ?? this.currentTest,
        selectedAnswers: selectedAnswers ?? this.selectedAnswers);
  }
}
