import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/add_test_task_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this._addTestTaskUsecase, this._currentUserUsecase) : super(CreateTaskState.initial());

  final AddTestTaskUsecase _addTestTaskUsecase;
  final GetCurrentUserUsecase _currentUserUsecase;

  void init() async {
    final Either<Failure, UserModel> getMyUser = await _currentUserUsecase(NoParams());
    getMyUser.fold((l) => emit(state.copyWith(status: CreateTaskStatus.error)), (r) {
      emit(state.copyWith(
          status: CreateTaskStatus.initial, creatorId: getMyUser.foldRight('', (r, previous) => r.userId)));
    });
  }

  void setLevel(EnglishLevel level) {
    emit(state.copyWith(level: level));
  }

  void setCorrectAnswer(List<int> index) {
    emit(state.copyWith(chosenOption: index));
  }

  void setQuestion(String question) {
    emit(state.copyWith(question: question));
  }

  void setAnswers(List<String> optionControllers) {
    emit(state.copyWith(options: optionControllers));
  }

  Future confirmAndAddTestTask() async {
    Either<Failure, void> addTestTaskResult = await _addTestTaskUsecase(TestTaskModel(
        creatorId: state.creatorId,
        question: state.question,
        options: state.options,
        correctAnswerIds: state.chosenOption,
        level: state.level.name));

    addTestTaskResult.fold((l) => emit(state.copyWith(status: CreateTaskStatus.error, errorMessage: l.failureMessage)),
        (r) => emit(state.copyWith(status: CreateTaskStatus.success)));
  }

  void validate() async {
    if (state.chosenOption.isNotEmpty &&
        state.creatorId.isNotEmpty &&
        state.options.isNotEmpty &&
        state.question.isNotEmpty) {
      emit(state.copyWith(validationStatus: ValidationStatus.success));
    } else {
      emit(state.copyWith(validationStatus: ValidationStatus.error, validationError: 'Check all fields'));
    }
  }
}
