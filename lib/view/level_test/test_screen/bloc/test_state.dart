part of 'test_bloc.dart';

enum TestStatus { progress, error, success, notLoggedIn, result }

class TestState extends Equatable {
  final TestStatus status;
  final String? errorMessage;
  final Node? tasksTree;
  final EnglishLevel currentLevel;
  final Stream<List<TestTaskModel>> testsData;
  final UserModel currentUser;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const TestState(
      {required this.status,
      this.errorMessage,
      required this.currentLevel,
      required this.tasksTree,
      required this.testsData,
      required this.currentUser});
  factory TestState.initial() {
    return TestState(
        status: TestStatus.progress,
        currentLevel: EnglishLevel.a1,
        tasksTree: null,
        testsData: const Stream.empty(),
        currentUser: UserModel.empty());
  }

  @override
  List<Object?> get props => [status, _time, currentLevel, tasksTree, testsData];

  TestState copyWith(
      {TestStatus? status,
      String? errorMessage,
      EnglishLevel? currentLevel,
      Node? tasksTree,
      Stream<List<TestTaskModel>>? testsData,
      UserModel? currentUser}) {
    return TestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentLevel: currentLevel ?? this.currentLevel,
        tasksTree: tasksTree ?? this.tasksTree,
        testsData: testsData ?? this.testsData,
        currentUser: currentUser ?? this.currentUser);
  }
}
