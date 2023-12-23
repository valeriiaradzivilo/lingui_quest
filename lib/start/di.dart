import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:lingui_quest/data/data_source/implementation/firebase_remote_data_source_implementation.dart';
import 'package:lingui_quest/data/repository/implementation/remote_repository_implementation.dart';
import 'package:lingui_quest/data/usecase/accept_join_group_request_usecase.dart';
import 'package:lingui_quest/data/usecase/add_test_task_usecase.dart';
import 'package:lingui_quest/data/usecase/create_new_game_usecase.dart';
import 'package:lingui_quest/data/usecase/create_new_tutor_usecase.dart';
import 'package:lingui_quest/data/usecase/create_test_tasks_tree_usecase.dart';
import 'package:lingui_quest/data/usecase/decline_join_group_request_usecase.dart';
import 'package:lingui_quest/data/usecase/delete_student_from_group_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_game_results_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_groups_for_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_public_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_all_test_tasks_usecase.dart';
import 'package:lingui_quest/data/usecase/get_created_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_created_groups_by_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_tutor_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_full_group_info.dart';
import 'package:lingui_quest/data/usecase/get_game_by_group_code_usecase.dart';
import 'package:lingui_quest/data/usecase/get_game_by_id_usecase.dart';
import 'package:lingui_quest/data/usecase/get_group_by_code_usecase.dart';
import 'package:lingui_quest/data/usecase/get_join_requests_usecase.dart';
import 'package:lingui_quest/data/usecase/get_passed_games_usecase.dart';
import 'package:lingui_quest/data/usecase/get_public_games_count.dart';
import 'package:lingui_quest/data/usecase/post_game_result_usecase.dart';
import 'package:lingui_quest/data/usecase/post_group_usecase.dart';
import 'package:lingui_quest/data/usecase/rate_game_usecase.dart';
import 'package:lingui_quest/data/usecase/request_to_join_group_usecase.dart';
import 'package:lingui_quest/data/usecase/search_games_usecase.dart';
import 'package:lingui_quest/data/usecase/set_new_english_level_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_out_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/view/create_game_page/bloc/create_game_bloc.dart';
import 'package:lingui_quest/view/create_game_page/create_question/bloc/create_question_bloc.dart';
import 'package:lingui_quest/view/game_play_page/bloc/game_play_bloc.dart';
import 'package:lingui_quest/view/games_page/game_preview/bloc/game_preview_cubit.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';
import 'package:lingui_quest/view/level_test/main_info_screen/bloc/level_test_bloc.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/bloc/level_test_play_bloc.dart';
import 'package:lingui_quest/view/profile_page/become_tutor/bloc/become_tutor_cubit.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Initialize data sources
  await initDatasources();

  // Initialize repository
  await initRepository();

  // Initialize use cases
  await initUseCases();

  // Initialize cubs
  await initCubs();
}

Future<void> initDatasources() async {
  final firebaseDatabase = FirebaseRemoteDatasourceImplementation();
  serviceLocator.registerLazySingleton<FirebaseRemoteDatasourceImplementation>(
    () => firebaseDatabase,
  );
}

Future<void> initUseCases() async {
  final remoteRepository = serviceLocator<RemoteRepositoryImplementation>();

  serviceLocator.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<SignUpWithEmailUsecase>(
    () => SignUpWithEmailUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<SignOutUsecase>(
    () => SignOutUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<AddTestTaskUsecase>(
    () => AddTestTaskUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetAllGroupsForCurrentUserUsecase>(
    () => GetAllGroupsForCurrentUserUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetAllTestTasksUsecase>(
    () => GetAllTestTasksUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<CreateNewGameUsecase>(
    () => CreateNewGameUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetAllPublicGamesUsecase>(
    () => GetAllPublicGamesUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetGameByIdUsecase>(
    () => GetGameByIdUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<CreateNewTutorUsecase>(
    () => CreateNewTutorUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<CreateTestTaskTreeUsecase>(
    () => CreateTestTaskTreeUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetCurrentTutorUsecase>(
    () => GetCurrentTutorUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetGroupByCodeUsecase>(
    () => GetGroupByCodeUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<PostGroupUsecase>(
    () => PostGroupUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetFullGroupInfoUsecase>(
    () => GetFullGroupInfoUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetJoinRequestsUsecase>(
    () => GetJoinRequestsUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetCreatedGroupsByCurrentUserUsecase>(
    () => GetCreatedGroupsByCurrentUserUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetGameByGroupCodeUsecase>(
    () => GetGameByGroupCodeUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<RequestToJoinGroupUsecase>(
    () => RequestToJoinGroupUsecase(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<AcceptJoinGroupRequestUsecase>(
    () => AcceptJoinGroupRequestUsecase(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<DeclineJoinGroupRequestUsecase>(
    () => DeclineJoinGroupRequestUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<RateGameUsecase>(
    () => RateGameUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<SearchGamesUsecase>(
    () => SearchGamesUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<GetPublicGamesCount>(
    () => GetPublicGamesCount(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<PostGameResultUsecase>(
    () => PostGameResultUsecase(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<GetCreatedGamesUsecase>(
    () => GetCreatedGamesUsecase(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<GetPassedGamesUsecase>(
    () => GetPassedGamesUsecase(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<GetAllGameResults>(
    () => GetAllGameResults(repository: remoteRepository),
  );
  serviceLocator.registerLazySingleton<DeleteStudentFromGroupUsecase>(
    () => DeleteStudentFromGroupUsecase(repository: remoteRepository),
  );

  serviceLocator.registerLazySingleton<SetNewEnglishLevelUsecase>(
    () => SetNewEnglishLevelUsecase(repository: remoteRepository),
  );
}

Future<void> initRepository() async {
  final remoteDataSource = serviceLocator<FirebaseRemoteDatasourceImplementation>();
  serviceLocator.registerLazySingleton<RemoteRepositoryImplementation>(
    () => RemoteRepositoryImplementation(remoteDataSource),
  );
}

Future<void> initCubs() async {
  final getCurrentUserUsecase = serviceLocator<GetCurrentUserUsecase>();
  final getCurrentTutorUsecase = serviceLocator<GetCurrentTutorUsecase>();

  // Cubits for screens
  serviceLocator.registerFactory(
    () => StartCubit(
      getCurrentUserUsecase,
      serviceLocator<SignOutUsecase>(),
      getCurrentTutorUsecase,
      serviceLocator<GetJoinRequestsUsecase>(),
      serviceLocator<AcceptJoinGroupRequestUsecase>(),
      serviceLocator<DeclineJoinGroupRequestUsecase>(),
      serviceLocator<GetCreatedGamesUsecase>(),
      serviceLocator<GetPassedGamesUsecase>(),
    ),
  );
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
    () => CreateTaskCubit(
      serviceLocator<AddTestTaskUsecase>(),
      getCurrentUserUsecase,
    ),
  );
  serviceLocator.registerFactory(
    () => LevelTestBloc(getCurrentUserUsecase),
  );
  serviceLocator.registerFactory(
    () => LevelTestPlayCubit(
      getCurrentUserUsecase,
      serviceLocator<CreateTestTaskTreeUsecase>(),
      serviceLocator<GetAllTestTasksUsecase>(),
      serviceLocator<SetNewEnglishLevelUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => GamesListBloc(
      serviceLocator<GetAllPublicGamesUsecase>(),
      getCurrentUserUsecase,
      serviceLocator<SearchGamesUsecase>(),
      serviceLocator<GetPublicGamesCount>(),
    ),
  );
  serviceLocator.registerFactory(
    () => BecomeTutorCubit(
      getCurrentUserUsecase,
      serviceLocator<CreateNewTutorUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => GameCreationCubit(
      serviceLocator<CreateNewGameUsecase>(),
      serviceLocator<GetCreatedGroupsByCurrentUserUsecase>(),
    ),
  );
  serviceLocator.registerFactory(() => QuestionCreationCubit());
  serviceLocator.registerFactory(() => GamePreviewCubit(
        serviceLocator<GetGameByIdUsecase>(),
        getCurrentUserUsecase,
        serviceLocator<GetAllGameResults>(),
      ));
  serviceLocator.registerFactory(() => GamePlayCubit(
        getCurrentUserUsecase,
        serviceLocator<RateGameUsecase>(),
        serviceLocator<PostGameResultUsecase>(),
      ));
  serviceLocator.registerFactory(() => GroupsBloc(
        getCurrentUserUsecase,
        serviceLocator<GetAllGroupsForCurrentUserUsecase>(),
        serviceLocator<GetGroupByCodeUsecase>(),
        serviceLocator<PostGroupUsecase>(),
        serviceLocator<GetFullGroupInfoUsecase>(),
        serviceLocator<RequestToJoinGroupUsecase>(),
        serviceLocator<DeleteStudentFromGroupUsecase>(),
      ));
}
