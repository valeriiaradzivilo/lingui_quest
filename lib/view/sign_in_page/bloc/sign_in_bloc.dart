import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/usecase/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUsecase _signInUseCase;

  SignInCubit(
    this._signInUseCase,
  ) : super(SignInState.initial());

  Future<void> login(String email, String password) async {
    final Either<Failure, void> result = await _signInUseCase(SignInParams(email, password));

    result.fold((l) {
      emit(state.copyWith(status: SignInStatus.error, errorMessage: l.failureMessage));
    }, (r) {
      emit(state.copyWith(status: SignInStatus.success));
    });
  }
}
