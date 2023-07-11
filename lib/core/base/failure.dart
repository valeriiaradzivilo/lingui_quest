import 'package:equatable/equatable.dart';

enum ExceptionMessage { tryAgain, serviceUnavailable, undefined }

abstract class Failure extends Equatable {
  final String failureMessage;
  final ExceptionMessage type;

  const Failure({
    required this.failureMessage,
    this.type = ExceptionMessage.tryAgain,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    ExceptionMessage type = ExceptionMessage.serviceUnavailable,
  }) : super(failureMessage: message, type: type);

  @override
  List<Object?> get props => [];
}

class UndefinedFailure extends Failure {
  const UndefinedFailure({
    required String message,
    ExceptionMessage type = ExceptionMessage.undefined,
  }) : super(failureMessage: message, type: type);

  @override
  List<Object?> get props => [];
}
