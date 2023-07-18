import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
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
    StartCubit.new,
  );

  //usecases
  serviceLocator.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SignUpWithEmailUsecase>(
    () => SignUpWithEmailUsecase(repository: serviceLocator()),
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
