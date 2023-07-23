import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/usecase/usercase.dart';
import 'package:lingui_quest/data/usecase/check_logged_in.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit(this._checkLoggedInUsecase) : super(StartState.initial());

  final CheckLoggedInUsecase _checkLoggedInUsecase;

  void setLoggedIn() {
    emit(state.copyWith(status: StartStatus.loggedIn));
  }

  void checkLoggedIn() async {
    if (await _checkLoggedInUsecase(NoParams())) {
      emit(state.copyWith(status: StartStatus.loggedIn));
    }
  }
}
