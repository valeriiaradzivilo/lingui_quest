import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'generated/game_search_model.freezed.dart';

@freezed
class GameSearchModel with _$GameSearchModel {
  const factory GameSearchModel({
    required String name, // text that will be looked up in a name or description
    required List<EnglishLevel> level,
    required List<String> theme,
  }) = _GameSearchModel;

  const GameSearchModel._();

  bool validate() => name.isNotEmpty || level.isNotEmpty || theme.isNotEmpty;

  bool isEmpty() => name.isEmpty && level.isEmpty && theme.isEmpty;

  factory GameSearchModel.empty() => GameSearchModel(name: '', level: [], theme: []);
}
