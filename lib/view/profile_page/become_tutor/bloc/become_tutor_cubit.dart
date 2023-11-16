import 'package:currency_picker/currency_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/base/failure.dart';
import 'package:lingui_quest/core/usecase/usecase.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/data/usecase/create_new_tutor_usecase.dart';

import '../../../../data/usecase/get_current_user_usecase.dart';

part 'become_tutor_state.dart';

class BecomeTutorCubit extends Cubit<BecomeTutorState> {
  BecomeTutorCubit(this._currentUserUsecase, this._createNewTutorUsecase) : super(BecomeTutorState.initial());

  final GetCurrentUserUsecase _currentUserUsecase;
  final CreateNewTutorUsecase _createNewTutorUsecase;

  void init() async {
    final Either<Failure, UserModel> getMyUser = await _currentUserUsecase(NoParams());
    getMyUser.fold((l) => emit(state.copyWith(status: BecomeTutorStatus.error, errorMessage: "You are not signed in")),
        (r) {
      emit(state.copyWith(
          status: BecomeTutorStatus.initial, userId: getMyUser.foldRight('', (r, previous) => r.userId)));
    });
  }

  Future<bool> create(
      {required String about,
      required String preferences,
      required Currency currency,
      required Map<String, String> contacts,
      required Map<String, double> price}) async {
    final tutor = TutorModel(
        userId: state.userId,
        about: about,
        contacts: contacts,
        currency: currency.name,
        preferences: preferences,
        price: price);
    final Either<Failure, void> createTutor = await _createNewTutorUsecase(tutor);
    return createTutor.fold(
      (l) => false,
      (r) => true,
    );
  }
}
