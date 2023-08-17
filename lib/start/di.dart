import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/add_test_task_usecase.dart';
import 'package:lingui_quest/data/usecase/check_logged_in.dart';
import 'package:lingui_quest/data/usecase/get_all_test_tasks.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/view/level_test/bloc/level_test_bloc.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';
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
      serviceLocator<CheckLoggedInUsecase>(),
      serviceLocator<GetCurrentUserUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateTaskCubit(serviceLocator<AddTestTaskUsecase>(), serviceLocator<GetCurrentUserUsecase>()),
  );
  serviceLocator.registerFactory(
    () => LevelTestBloc(serviceLocator<GetAllTestTasksUsecase>()),
  );

  //usecases
  serviceLocator.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SignUpWithEmailUsecase>(
    () => SignUpWithEmailUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CheckLoggedInUsecase>(
    () => CheckLoggedInUsecase(),
  );
  serviceLocator.registerLazySingleton<AddTestTaskUsecase>(
    () => AddTestTaskUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetAllTestTasksUsecase>(
    () => GetAllTestTasksUsecase(repository: serviceLocator()),
  );
  //datasources
  serviceLocator.registerLazySingleton<RemoteRepository>(
    () => RemoteRepository(
      serviceLocator<FirebaseDatabaseImpl>(),
    ),
  );

  //repositor

  serviceLocator.registerLazySingleton<FirebaseDatabaseImpl>(
    () => FirebaseDatabaseImpl(),
  );
}
