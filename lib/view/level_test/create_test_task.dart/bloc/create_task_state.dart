part of 'create_task_bloc.dart';

enum CreateTaskStatus { initial, progress, error, success }

enum ValidationStatus { error, unchecked, success }

class CreateTaskState extends Equatable {
  final CreateTaskStatus status;
  final String? errorMessage;
  final EnglishLevel level;
  final List<int> chosenOption;
  final String creatorId;
  final String question;
  final List<String> options;
  final ValidationStatus validationStatus;
  final String validationError;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const CreateTaskState({
    required this.status,
    this.errorMessage,
    required this.level,
    required this.chosenOption,
    required this.creatorId,
    required this.options,
    required this.question,
    required this.validationStatus,
    required this.validationError,
  });
  factory CreateTaskState.initial() {
    return const CreateTaskState(
        status: CreateTaskStatus.initial,
        level: EnglishLevel.a1,
        chosenOption: [0],
        creatorId: '',
        options: [],
        question: '',
        validationStatus: ValidationStatus.unchecked,
        validationError: '');
  }

  @override
  List<Object?> get props => [status, _time, level, chosenOption, creatorId, options, question];

  CreateTaskState copyWith(
      {CreateTaskStatus? status,
      String? errorMessage,
      EnglishLevel? level,
      List<int>? chosenOption,
      String? creatorId,
      String? question,
      List<String>? options,
      ValidationStatus? validationStatus,
      String? validationError}) {
    return CreateTaskState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        level: level ?? this.level,
        chosenOption: chosenOption ?? this.chosenOption,
        creatorId: creatorId ?? this.creatorId,
        question: question ?? this.question,
        options: options ?? this.options,
        validationStatus: validationStatus ?? this.validationStatus,
        validationError: validationError ?? this.validationError);
  }
}
