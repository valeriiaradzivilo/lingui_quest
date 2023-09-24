import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/check_logged_in.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit(this._checkLoggedInUsecase, this._getCurrentUserUsecase) : super(StartState.initial());

  final CheckLoggedInUsecase _checkLoggedInUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  void init() async {
    await checkLoggedIn();
    await getInitials();
    emit(state.copyWith(status: StartStatus.initial));
  }

  void setLoggedIn() {
    emit(state.copyWith(isLoggedIn: true));
  }

  Future<void> checkLoggedIn() async {
    if (await _checkLoggedInUsecase(NoParams())) {
      emit(state.copyWith(isLoggedIn: true));
    } else {
      emit(state.copyWith(isLoggedIn: false));
    }
  }

  Future<void> getInitials() async {
    Either<Failure, UserModel> currentUser = await _getCurrentUserUsecase(NoParams());
    if (currentUser.isRight()) {
      emit(state.copyWith(currentUser: currentUser.foldRight(UserModel.empty(), (r, previous) => r)));
    }
  }

  void signOut() {}
}
