import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_out_usecase.dart';
import 'package:lingui_quest/start/page/start_page.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit(
      // this._checkLoggedInUsecase,
      this._getCurrentUserUsecase,
      this._signOutUsecase)
      : super(StartState.initial());

  // final CheckLoggedInUsecase _checkLoggedInUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final SignOutUsecase _signOutUsecase;

  void init() async {
    await checkLoggedIn();
    await getInitials();
    emit(state.copyWith(status: StartStatus.initial));
  }

  void setLoggedIn() {
    emit(state.copyWith(isLoggedIn: true));
  }

  Future<void> checkLoggedIn() async {
    emit(state.copyWith(isLoggedIn: state.currentUser != UserModel.empty()));
  }

  Future<void> getInitials() async {
    Either<Failure, UserModel> currentUser = await _getCurrentUserUsecase(NoParams());
    if (currentUser.isRight()) {
      emit(state.copyWith(currentUser: currentUser.foldRight(UserModel.empty(), (r, previous) => r)));
    }
  }

  void signOut() async {
    emit(state.copyWith(status: StartStatus.progress));
    Either<Failure, void> currentUser = await _signOutUsecase(NoParams());
    if (currentUser.isRight()) {
      emit(state.copyWith(status: StartStatus.initial, currentUser: UserModel.empty()));
    } else {
      emit(state.copyWith(status: StartStatus.error, currentUser: UserModel.empty()));
    }
  }

  void setTabOption(TabBarOption option) {
    emit(state.copyWith(currentTab: option));
  }
}
