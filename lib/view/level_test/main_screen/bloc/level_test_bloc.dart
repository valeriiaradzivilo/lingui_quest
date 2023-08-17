import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/test_task_model.dart';

part 'level_test_state.dart';

sealed class CounterEvent {}

final class AddedNewTask extends CounterEvent {}

final class ReadAllTasks extends CounterEvent {}

class LevelTestBloc extends Bloc<CounterEvent, LevelTestState> {
  LevelTestBloc() : super(LevelTestState.initial()) {
    on<AddedNewTask>((event, emit) => emit(state));
    on<ReadAllTasks>(
      (event, emit) async {
        // final allTests = await _getAllTestTasksUsecase(NoParams());
        // if (allTests.isRight()) {
        //   emit(state.copyWith(
        //       status: LevelTestStatus.initial,
        //       testsData: allTests.foldRight(const Stream.empty(), (r, previous) => r)));
        // } else {
        //   emit(state.copyWith(status: LevelTestStatus.error));
        // }
        emit(state.copyWith(
          status: LevelTestStatus.initial,
        ));
      },
    );
  }

  // final GetAllTestTasksUsecase _getAllTestTasksUsecase;
}
