part of 'level_test_bloc.dart';

enum LevelTestStatus { initial, progress, error, success }

class LevelTestState extends Equatable {
  final LevelTestStatus status;
  final String? errorMessage;
  final Stream<List<TestTaskModel>> testsData;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const LevelTestState({required this.status, this.errorMessage, required this.testsData});
  factory LevelTestState.initial() {
    return const LevelTestState(
      status: LevelTestStatus.progress,
      testsData: Stream.empty(),
    );
  }

  @override
  List<Object?> get props => [status, _time, testsData];

  LevelTestState copyWith({
    LevelTestStatus? status,
    String? errorMessage,
    Stream<List<TestTaskModel>>? testsData,
  }) {
    return LevelTestState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        testsData: testsData ?? this.testsData);
  }
}
