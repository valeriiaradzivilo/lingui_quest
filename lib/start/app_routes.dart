import 'package:flutter/material.dart';
import 'package:lingui_quest/main.dart';
import 'package:lingui_quest/start/page/start_page.dart';
import 'package:lingui_quest/view/create_game_page/create_game.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/create_task.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/level_test_play_screen.dart';
import 'package:lingui_quest/view/profile_page/full_profile_page.dart';
import 'package:lingui_quest/view/sign_in_page/sign_in_page.dart';
import 'package:lingui_quest/view/sign_up_page/sign_up_page.dart';

enum AppRoutes {
  initial,
  signIn,
  signUp,
  createTestTask,
  test,
  profile,
  createGame,
  game,
  group;

  String get path => switch (this) {
        initial => '/',
        signIn => '/sign-in',
        signUp => '/sign-up',
        createTestTask => '/create-test-task',
        test => '/test',
        profile => '/profile',
        createGame => '/create-game',
        game => '/game',
        group => '/group',
      };

  static Map<String, Widget Function(BuildContext)> routes(ThemeModel model) {
    return {
      initial.path: (context) => StartPage(
            changeTheme: () {
              model.toggleMode();
            },
          ),
      signIn.path: (context) => const SignInPage(),
      signUp.path: (context) => const SignUpPage(),
      createTestTask.path: (context) => const CreateTestTaskPopup(),
      test.path: (context) => const LevelTestPlayScreen(),
      profile.path: (context) => const FullProfilePage(),
      createGame.path: (context) => const CreateGamePage(),
    };
  }
}
