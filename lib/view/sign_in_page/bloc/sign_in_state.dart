part of 'sign_in_bloc.dart';

enum SignInStatus { initial, progress, error, success }

class SignInState extends Equatable {
  final SignInStatus status;
  final String? errorMessage;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const SignInState({required this.status, this.errorMessage});
  factory SignInState.initial() {
    return const SignInState(status: SignInStatus.initial);
  }

  @override
  List<Object?> get props => [status, _time];

  SignInState copyWith({
    SignInStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
