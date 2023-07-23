import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(CreateTaskState.initial());

  void setLevel(EnglishLevel level) {
    emit(state.copyWith(level: level));
  }

  void setCorrectAnswer(int index) {
    emit(state.copyWith(chosenOption: index));
  }
}
