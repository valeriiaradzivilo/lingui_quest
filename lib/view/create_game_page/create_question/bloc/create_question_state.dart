part of 'create_question_bloc.dart';

enum QuestionCreationStatus { initial, progress, error }

class QuestionCreationState extends Equatable {
  final QuestionCreationStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final QuestionModel question;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const QuestionCreationState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.question,
  });
  factory QuestionCreationState.initial() {
    return QuestionCreationState(
        status: QuestionCreationStatus.progress, currentUser: UserModel.empty(), question: QuestionModel.empty());
  }

  @override
  List<Object?> get props => [status, _time, currentUser, question, errorMessage];

  QuestionCreationState copyWith({
    QuestionCreationStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    QuestionModel? question,
  }) {
    return QuestionCreationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentUser: currentUser ?? this.currentUser,
        question: question ?? this.question);
  }
}
