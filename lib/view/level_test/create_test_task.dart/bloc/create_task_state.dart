part of 'create_task_bloc.dart';

enum CreateTaskStatus { initial, progress, error, success }

class CreateTaskState extends Equatable {
  final CreateTaskStatus status;
  final String? errorMessage;
  final EnglishLevel level;
  final int chosenOption;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const CreateTaskState({required this.status, this.errorMessage, required this.level, required this.chosenOption});
  factory CreateTaskState.initial() {
    return const CreateTaskState(status: CreateTaskStatus.initial, level: EnglishLevel.a1, chosenOption: 0);
  }

  @override
  List<Object?> get props => [status, _time];

  CreateTaskState copyWith({CreateTaskStatus? status, String? errorMessage, EnglishLevel? level, int? chosenOption}) {
    return CreateTaskState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        level: level ?? this.level,
        chosenOption: chosenOption ?? this.chosenOption);
  }
}
