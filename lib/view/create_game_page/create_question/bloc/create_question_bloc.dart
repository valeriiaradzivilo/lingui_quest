import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';

part 'create_question_state.dart';

class QuestionCreationCubit extends Cubit<QuestionCreationState> {
  QuestionCreationCubit() : super(QuestionCreationState.initial());

  void init(QuestionModel? questionToEdit) {
    emit(state.copyWith(status: QuestionCreationStatus.initial, question: questionToEdit));
  }

  void setQuestion(String text) => emit(state.copyWith(question: state.question.copyWith(question: text)));
  void setOptions(List<String> listOfOptions) =>
      emit(state.copyWith(question: state.question.copyWith(options: listOfOptions)));
  void setCorrectAnswers(List<int> listOfAnswers) {
    emit(state.copyWith(question: state.question.copyWithCustom(correctAnswers: listOfAnswers)));
  }

  void submitQuestion() => emit(QuestionCreationState.initial());
}
