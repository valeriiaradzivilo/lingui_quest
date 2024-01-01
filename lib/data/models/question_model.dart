import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'generated/question_model.freezed.dart';
part 'generated/question_model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    required String question,
    required List<String> options,
    required List<int> correctAnswers,
  }) = _QuestionModel;
  factory QuestionModel.fromJson(Json json) => _$QuestionModelFromJson(json);

  factory QuestionModel.empty() {
    return QuestionModel(
      question: '',
      options: [],
      correctAnswers: [],
    );
  }

  const QuestionModel._();

  bool get validate => question.isNotEmpty && options.isNotEmpty && correctAnswers.isNotEmpty;
}
