part of 'start_cubit.dart';

enum StartStatus { initial, progress, error, loggedIn }

class StartState extends Equatable {
  final StartStatus status;
  final String? errorMessage;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const StartState({required this.status, this.errorMessage});
  factory StartState.initial() {
    return const StartState(status: StartStatus.initial);
  }

  @override
  List<Object?> get props => [status, _time];

  StartState copyWith({
    StartStatus? status,
    String? errorMessage,
  }) {
    return StartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
