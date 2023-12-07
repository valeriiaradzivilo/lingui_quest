import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/get_current_tutor_usecase.dart';
import 'package:lingui_quest/data/usecase/get_current_user_usecase.dart';
import 'package:lingui_quest/data/usecase/get_join_requests_usecase.dart';
import 'package:lingui_quest/data/usecase/sign_out_usecase.dart';
import 'package:lingui_quest/start/page/start_page.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit(
    this._getCurrentUserUsecase,
    this._signOutUsecase,
    this._getCurrentTutorUsecase,
    this._getJoinRequestsUsecase,
  ) : super(StartState.initial());

  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final SignOutUsecase _signOutUsecase;
  final GetCurrentTutorUsecase _getCurrentTutorUsecase;
  final GetJoinRequestsUsecase _getJoinRequestsUsecase;

  void init() async {
    await checkLoggedIn();
    await getInitials();
    await findTutorProfile();
    emit(state.copyWith(status: StartStatus.initial));
  }

  Future findTutorProfile() async {
    if (state.currentUser.isTutor) {
      final tutor = await _getCurrentTutorUsecase(NoParams());
      final joinRequests = await _getJoinRequestsUsecase(NoParams());
      emit(state.copyWith(
        tutorModel: tutor.foldRight(TutorModel.empty(), (r, previous) => r),
        joinRequests: joinRequests.foldRight(Stream.empty(), (r, previous) => r),
      ));
    }
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
