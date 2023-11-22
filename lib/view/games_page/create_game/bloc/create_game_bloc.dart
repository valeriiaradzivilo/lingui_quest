import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';

part 'create_game_state.dart';

class GameCreationCubit extends Cubit<GameCreationState> {
  GameCreationCubit() : super(GameCreationState.initial());

  void setTheme(String? theme) {
    emit(state.copyWith(game: state.game.copyWith(theme: theme ?? '')));
  }

  void setLevel(EnglishLevel? level) {
    emit(state.copyWith(game: state.game.copyWith(level: level ?? EnglishLevel.a1)));
  }

  void setName(String name) => emit(state.copyWith(game: state.game.copyWith(name: name)));
  void setDescription(String description) => emit(state.copyWith(game: state.game.copyWith(description: description)));

  void setThemeDropdown(String? theme) {
    if (theme == GameTheme.custom.label) {
      setTheme('');
    } else {
      setTheme(theme);
    }
  }

  void addQuestion(QuestionModel question) {
    final newListOfQuestions = [...state.game.questions, question];
    emit(state.copyWith(game: state.game.copyWith(questions: newListOfQuestions)));
  }
}
