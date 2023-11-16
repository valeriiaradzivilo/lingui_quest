import 'package:json_annotation/json_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  final List<String> options;
  final List<int> correctAnswers;
  final String question;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswers,
  });
  factory QuestionModel.fromJson(Json json) => _$QuestionModelFromJson(json);
  Json toJson() => _$QuestionModelToJson(this);

  factory QuestionModel.empty() {
    return QuestionModel(
      question: '',
      options: [],
      correctAnswers: [],
    );
  }
}
