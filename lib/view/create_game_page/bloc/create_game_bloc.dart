import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/create_new_game_usecase.dart';
import 'package:lingui_quest/data/usecase/get_created_groups_by_current_user_usecase.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';

part 'create_game_state.dart';

class GameCreationCubit extends Cubit<GameCreationState> {
  GameCreationCubit(this._createNewGameUsecase, this._getCreatedGroupsByCurrentUserUsecase)
      : super(GameCreationState.initial());

  final CreateNewGameUsecase _createNewGameUsecase;
  final GetCreatedGroupsByCurrentUserUsecase _getCreatedGroupsByCurrentUserUsecase;

  void setTheme(String? theme) {
    emit(state.copyWith(game: state.game.copyWith(theme: theme ?? '')));
  }

  void setLevel(EnglishLevel? level) {
    emit(state.copyWith(game: state.game.copyWith(level: level ?? EnglishLevel.a1)));
  }

  void setTime(String time) {
    final t = int.tryParse(time);
    if (t != null) {
      emit(state.copyWith(game: state.game.copyWith(time: t * 60)));
    }
  }

  void setName(String name) => emit(state.copyWith(game: state.game.copyWith(name: name)));
  void setDescription(String description) => emit(state.copyWith(game: state.game.copyWith(description: description)));

  void setThemeDropdown(String? theme) {
    if (theme == GameTheme.custom.label) {
      emit(state.copyWith(customTheme: true, game: state.game.copyWith(theme: '')));
    } else {
      setTheme(theme);
    }
  }

  void addQuestion(QuestionModel question) {
    final newListOfQuestions = [...state.game.questions, question];
    emit(state.copyWith(game: state.game.copyWith(questions: newListOfQuestions)));
  }

  void replaceQuestion(QuestionModel question, int index) {
    final newListOfQuestions = [...state.game.questions];
    newListOfQuestions.removeAt(index);
    newListOfQuestions.insertAll(index, [question]);
    emit(state.copyWith(game: state.game.copyWith(questions: newListOfQuestions)));
  }

  void deleteQuestion(int index) {
    final newListOfQuestions = [...state.game.questions];
    newListOfQuestions.removeAt(index);
    emit(state.copyWith(game: state.game.copyWith(questions: newListOfQuestions)));
  }

  Future<bool> submitGame() async {
    final createNewGameRes = await _createNewGameUsecase(state.game);
    return createNewGameRes.isRight();
  }

  void setPublic(bool isPublic) {
    emit(state.copyWith(
      isPublic: isPublic,
      game: isPublic ? state.game.copyWith(groups: []) : null,
    ));
    if (!isPublic) getCreatedGroups();
  }

  Future getCreatedGroups() async {
    if (state.availableGroups.isEmpty) {
      final createdGroupsRes = await _getCreatedGroupsByCurrentUserUsecase(NoParams());
      createdGroupsRes.fold(
          (l) => emit(state.copyWith(errorMessage: 'Could not find created groups. Try again later!')),
          (r) => emit(state.copyWith(availableGroups: r)));
    }
  }

  void selectGroups(GroupModel group) {
    final currentGame = state.game;
    if (currentGame.groups.contains(group.code)) {
      final newGroupList = [...currentGame.groups];
      newGroupList.remove(group.code);
      emit(state.copyWith(game: currentGame.copyWith(groups: newGroupList)));
    } else {
      final newGroupList = [...currentGame.groups, group.code];
      emit(state.copyWith(game: currentGame.copyWith(groups: newGroupList)));
    }
  }
}
