import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:lingui_quest/data/firebase/firebase_database.dart';
import 'package:lingui_quest/data/repository/remote_repository.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //cubits
  serviceLocator.registerFactory(
    () => SignInCubit(
      serviceLocator<SignInUsecase>(),
    ),
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
