import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/data/firebase/firebase_options.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/di.dart';
import 'package:lingui_quest/start/gallery_option_theme.dart';
import 'package:lingui_quest/view/create_game_page/bloc/create_game_bloc.dart';
import 'package:lingui_quest/view/create_game_page/create_question/bloc/create_question_bloc.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';
import 'package:lingui_quest/view/games_page/game_preview/bloc/game_preview_cubit.dart';
import 'package:lingui_quest/view/games_page/game_preview/game_preview_page.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';
import 'package:lingui_quest/view/groups/chosen_group/chosen_group_screen.dart';
import 'package:lingui_quest/view/level_test/create_test_task/bloc/create_task_bloc.dart';
import 'package:lingui_quest/view/level_test/main_info_screen/bloc/level_test_bloc.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/bloc/level_test_play_bloc.dart';
import 'package:lingui_quest/view/profile_page/become_tutor/bloc/become_tutor_cubit.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_cubit.dart';

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
        BlocProvider(create: (_) => serviceLocator<SignInCubit>()),
        BlocProvider(create: (_) => serviceLocator<SignUpCubit>()),
        BlocProvider(create: (_) => serviceLocator<StartCubit>()),
        BlocProvider(create: (_) => serviceLocator<CreateTaskCubit>()),
        BlocProvider(create: (_) => serviceLocator<LevelTestBloc>()),
        BlocProvider(create: (_) => serviceLocator<LevelTestPlayCubit>()),
        BlocProvider(create: (_) => serviceLocator<GamesListBloc>()),
        BlocProvider(create: (_) => serviceLocator<BecomeTutorCubit>()),
        BlocProvider(create: (_) => serviceLocator<GameCreationCubit>()),
        BlocProvider(create: (_) => serviceLocator<QuestionCreationCubit>()),
        BlocProvider(create: (_) => serviceLocator<GamePreviewCubit>()),
        BlocProvider(create: (_) => serviceLocator<GamePlayCubit>()),
        BlocProvider(create: (_) => serviceLocator<GroupsBloc>()),
      ],
      child: Portal(
        child: MaterialApp(
          title: 'LinguiQuest',
          theme: GalleryOptionTheme.lightThemeData,
          darkTheme: GalleryOptionTheme.darkThemeData,
          themeMode: ThemeMode.dark,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: AppRoutes.routes,
          onGenerateRoute: (settings) {
            if (settings.name != null && settings.name!.startsWith(AppRoutes.game.path)) {
              return MaterialPageRoute(
                builder: (context) => GamePreviewPage(),
                settings: settings,
              );
            } else if (settings.name != null && settings.name!.startsWith(AppRoutes.group.path)) {
              return MaterialPageRoute(
                builder: (context) => ChosenGroupScreen(),
                settings: settings,
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
