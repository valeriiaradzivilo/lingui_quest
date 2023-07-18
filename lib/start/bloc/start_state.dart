part of 'start_cubit.dart';

enum StartStatus { initial, progress, error, success }

class StartState extends Equatable {
  final StartStatus status;
  final String? errorMessage;
  final bool isLoggedIn;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const StartState({required this.status, this.errorMessage, this.isLoggedIn = false});
  factory StartState.initial() {
    return const StartState(status: StartStatus.initial);
  }

  @override
  List<Object?> get props => [status, _time];

  StartState copyWith({
    StartStatus? status,
    String? errorMessage,
    bool? isLoggedIn,
  }) {
    return StartState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
