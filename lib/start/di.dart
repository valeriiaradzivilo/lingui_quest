import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/add_test_task_usecase.dart';
import 'package:lingui_quest/data/usecase/create_new_game_usecase.dart';
import 'package:lingui_quest/data/usecase/create_new_tutor_usecase.dart';
import 'package:lingui_quest/data/usecase/create_test_tasks_tree.dart';
import 'package:lingui_quest/data/usecase/get_all_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_test_tasks.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_out_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/view/games_page/create_game/bloc/create_game_bloc.dart';
import 'package:lingui_quest/view/games_page/create_game/create_question/bloc/create_question_bloc.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_bloc.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';
import 'package:lingui_quest/view/level_test/main_screen/bloc/level_test_bloc.dart';
import 'package:lingui_quest/view/level_test/test_screen/bloc/test_bloc.dart';
import 'package:lingui_quest/view/profile_page/become_tutor/bloc/become_tutor_cubit.dart';
import 'package:lingui_quest/view/search_tutor/bloc/tutors_bloc.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //cubits
  serviceLocator.registerFactory(
    () => SignInCubit(
      serviceLocator<SignInUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => SignUpCubit(
      serviceLocator<SignUpWithEmailUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => StartCubit(
      // serviceLocator<CheckLoggedInUsecase>(),
      serviceLocator<GetCurrentUserUsecase>(),
      serviceLocator<SignOutUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateTaskCubit(serviceLocator<AddTestTaskUsecase>(), serviceLocator<GetCurrentUserUsecase>()),
  );
  serviceLocator.registerFactory(
    () => LevelTestBloc(serviceLocator<GetCurrentUserUsecase>()),
  );
  serviceLocator.registerFactory(
    () => TestCubit(
      serviceLocator<GetCurrentUserUsecase>(),
      serviceLocator<CreateTestTaskTreeUsecase>(),
      serviceLocator<GetAllTestTasksUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => TutorsSearchBloc(),
  );
  serviceLocator.registerFactory(
    () => GameBloc(
      serviceLocator<GetCurrentUserUsecase>(),
      serviceLocator<GetAllGamesUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => BecomeTutorCubit(
      serviceLocator<GetCurrentUserUsecase>(),
      serviceLocator<CreateNewTutorUsecase>(),
    ),
  );
  serviceLocator.registerFactory(() => GameCreationCubit());
  serviceLocator.registerFactory(() => QuestionCreationCubit());

  //usecases
  serviceLocator.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SignUpWithEmailUsecase>(
    () => SignUpWithEmailUsecase(repository: serviceLocator()),
  );
  // serviceLocator.registerLazySingleton<CheckLoggedInUsecase>(
  //   () => CheckLoggedInUsecase(),
  // );
  serviceLocator.registerLazySingleton<AddTestTaskUsecase>(
    () => AddTestTaskUsecase(repository: serviceLocator<RemoteRepository>()),
  );
  serviceLocator.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetAllTestTasksUsecase>(
    () => GetAllTestTasksUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CreateTestTaskTreeUsecase>(
    () => CreateTestTaskTreeUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CreateNewTutorUsecase>(
    () => CreateNewTutorUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CreateNewGameUsecase>(
    () => CreateNewGameUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetAllGamesUsecase>(
    () => GetAllGamesUsecase(repository: serviceLocator()),
  );

  //datasources
  serviceLocator.registerLazySingleton<RemoteRepository>(
    () => RemoteRepository(
      serviceLocator<FirebaseDatabaseImpl>(),
    ),
  );

  //repository
  serviceLocator.registerLazySingleton<FirebaseDatabaseImpl>(
    () => FirebaseDatabaseImpl(),
  );
}
