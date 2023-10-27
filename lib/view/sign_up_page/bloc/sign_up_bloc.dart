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

  Future<bool> signUp(String firstName, String lastName, String email, String password) async {
    final Either<Failure, void> result =
        await _signUpWithEmailUsecase(SignUpParams(email, password, firstName, lastName));

    return result.fold((l) {
      emit(state.copyWith(status: SignUpStatus.error, errorMessage: l.failureMessage));
      return false;
    }, (r) {
      return true;
    });
  }

  void setFirstName(String name) {
    emit(state.copyWith(firstName: name));
  }

  void setLastName(String name) {
    emit(state.copyWith(lastName: name));
  }

  void setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password));
  }
}
