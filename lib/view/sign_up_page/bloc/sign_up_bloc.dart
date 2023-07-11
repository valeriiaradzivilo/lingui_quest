import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/data/usecase/sign_up_email_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpWithEmailUsecase _signUpWithEmailUsecase;

  SignUpCubit(
    this._signUpWithEmailUsecase,
  ) : super(SignUpState.initial());

  void signUp(String email, String password) async {
    final Either<Failure, void> result = await _signUpWithEmailUsecase(SignUpParams(email, password));

    result.fold((l) {
      emit(state.copyWith(status: SignUpStatus.error, errorMessage: l.failureMessage));
    }, (r) {
      emit(state.copyWith(status: SignUpStatus.success));
    });
  }
}
