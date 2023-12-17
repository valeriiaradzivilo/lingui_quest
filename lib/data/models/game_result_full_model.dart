import 'package:lingui_quest/data/models/game_error_model.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';

class GameResultFullModel {
  final UserModel user;
  final GameModel game;
  final double result;
  final int timeFinished;
  final List<GameErrorModel> errors;

  GameResultFullModel({
    required this.user,
    required this.game,
    required this.result,
    required this.timeFinished,
    required this.errors,
  });
}
