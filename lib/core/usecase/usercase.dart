import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:lingui_quest/core/base/failure.dart';

abstract class UseCase<T, P> {
  T call(P params);
}

abstract class UseCaseFuture<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseFutureEither<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
