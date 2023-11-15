import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/tutor_model.dart';

part 'tutor_search_state.dart';

sealed class CounterEvent {}

final class AddedNewTutor extends CounterEvent {}

final class FindAllTutors extends CounterEvent {}

class TutorsSearchBloc extends Bloc<CounterEvent, TutorSearchState> {
  TutorsSearchBloc() : super(TutorSearchState.initial()) {
    on<AddedNewTutor>((event, emit) => emit(state));
    on<FindAllTutors>(
      (event, emit) async {
        // final allTutors = await _getAllTutorsUsecase(NoParams());
        // if (allTutors.isRight()) {
        //   emit(state.copyWith(
        //       status: TutorSearchStatus.success,
        //       allTutors: allTutors.foldRight(const Stream.empty(), (r, previous) => r)));
        // } else {
        //   emit(state.copyWith(status: TutorSearchStatus.error, errorMessage: 'Could not find any tutors. Try again.'));
        // }
      },
    );
  }

  // final GetAllTestTasksUsecase _getAllTestTasksUsecase;
}
