import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

part 'generated/game_search_model.freezed.dart';

@freezed
class GameSearchModel with _$GameSearchModel {
  const factory GameSearchModel({
    String? name, // text that will be looked up in a name or description
    List<EnglishLevel>? level,
    List<String>? theme,
  }) = _GameSearchModel;

  const GameSearchModel._();

  bool validate() => name != null || level != null || theme != null;

  bool isEmpty() => (name?.isEmpty ?? true) && (level?.isEmpty ?? true) && (theme?.isEmpty ?? true);
}
