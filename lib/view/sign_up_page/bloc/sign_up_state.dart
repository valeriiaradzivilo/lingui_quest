part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, progress, error, success }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const SignUpState({required this.status, this.errorMessage});
  factory SignUpState.initial() {
    return const SignUpState(status: SignUpStatus.initial);
  }

  @override
  List<Object?> get props => [status, _time];

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
