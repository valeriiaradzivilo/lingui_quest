part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, progress, error, success }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const SignUpState(
      {required this.status,
      this.errorMessage,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
  factory SignUpState.initial() {
    return const SignUpState(
      status: SignUpStatus.initial,
      email: '',
      firstName: '',
      lastName: '',
      password: '',
    );
  }

  @override
  List<Object?> get props => [status, _time, email, firstName, lastName, email, password];

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return SignUpState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password);
  }
}
