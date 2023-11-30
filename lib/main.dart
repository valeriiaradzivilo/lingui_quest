import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/data/firebase/firebase_options.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/di.dart';
import 'package:lingui_quest/start/gallery_option_theme.dart';
import 'package:lingui_quest/start/page/start_page.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/view/create_game_page/bloc/create_game_bloc.dart';
import 'package:lingui_quest/view/create_game_page/create_game.dart';
import 'package:lingui_quest/view/create_game_page/create_question/bloc/create_question_bloc.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';
import 'package:lingui_quest/view/games_page/game_preview/bloc/game_preview_cubit.dart';
import 'package:lingui_quest/view/games_page/game_preview/game_preview_page.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/create_task.dart';
import 'package:lingui_quest/view/level_test/main_info_screen/bloc/level_test_bloc.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/bloc/level_test_play_bloc.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/level_test_play_screen.dart';
import 'package:lingui_quest/view/profile_page/become_tutor/bloc/become_tutor_cubit.dart';
import 'package:lingui_quest/view/profile_page/full_profile_page.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:lingui_quest/view/sign_in_page/sign_in_page.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:lingui_quest/view/sign_up_page/sign_up_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  // HiveDatabase.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (_) => serviceLocator<SignInCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => serviceLocator<SignUpCubit>()),
        BlocProvider<StartCubit>(create: (_) => serviceLocator<StartCubit>()),
        BlocProvider<CreateTaskCubit>(create: (_) => serviceLocator<CreateTaskCubit>()),
        BlocProvider<LevelTestBloc>(create: (_) => serviceLocator<LevelTestBloc>()),
        BlocProvider<LevelTestPlayCubit>(create: (_) => serviceLocator<LevelTestPlayCubit>()),
        BlocProvider<GamesListBloc>(create: (_) => serviceLocator<GamesListBloc>()),
        BlocProvider<BecomeTutorCubit>(create: (_) => serviceLocator<BecomeTutorCubit>()),
        BlocProvider<GameCreationCubit>(create: (_) => serviceLocator<GameCreationCubit>()),
        BlocProvider<QuestionCreationCubit>(create: (_) => serviceLocator<QuestionCreationCubit>()),
        BlocProvider<GamePreviewCubit>(create: (_) => serviceLocator<GamePreviewCubit>()),
        BlocProvider<GamePlayCubit>(create: (_) => serviceLocator<GamePlayCubit>()),
        BlocProvider<GroupsBloc>(create: (_) => serviceLocator<GroupsBloc>()),
      ],
      child: ChangeNotifierProvider<ThemeModel>(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(builder: (_, model, __) {
          return Portal(
              child: MaterialApp(
            title: 'LinguiQuest',
            theme: GalleryOptionTheme.lightThemeData,
            darkTheme: GalleryOptionTheme.darkThemeData,
            themeMode: model.mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: '/',
            routes: _routes(model),
            onGenerateRoute: (settings) {
              if (settings.name != null && settings.name!.startsWith(AppRoutes.game)) {
                return MaterialPageRoute(builder: (context) => GamePreviewPage(), settings: settings);
              }
              return null;
            },
          ));
        }),
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> _routes(ThemeModel model) {
    return {
      AppRoutes.initial: (context) => StartPage(
            changeTheme: () {
              model.toggleMode();
            },
          ),
      AppRoutes.signIn: (context) => const SignInPage(),
      AppRoutes.signUp: (context) => const SignUpPage(),
      AppRoutes.createTestTask: (context) => const CreateTestTaskPopup(),
      AppRoutes.test: (context) => const LevelTestPlayScreen(),
      AppRoutes.profile: (context) => const FullProfilePage(),
      AppRoutes.createGame: (context) => const CreateGamePage(),
    };
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.dark}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
