import 'package:lingui_quest/shared/enums/english_level_enum.dart';

class GameSearchModel {
  /// text that will be looked up in a name or description
  final String? name;
  final EnglishLevel? level;
  final String? theme;

  GameSearchModel({this.name, this.level, this.theme});

  bool validate() => name != null || level != null || theme != null;
}
