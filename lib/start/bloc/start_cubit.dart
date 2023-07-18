import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/local_storage/hive_database.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit() : super(StartState.initial());

  void checkIfUserLoggedIn() async {
    emit(state.copyWith(isLoggedIn: await HiveDatabase().isSignedIn()));
  }
}
