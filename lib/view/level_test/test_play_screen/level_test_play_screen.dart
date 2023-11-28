import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_game_screen.dart';
import 'package:lingui_quest/view/level_test/test_play_screen/bloc/level_test_play_bloc.dart';

class LevelTestPlayScreen extends StatefulWidget {
  const LevelTestPlayScreen({super.key});

  @override
  State<LevelTestPlayScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<LevelTestPlayScreen> {
  late final LevelTestPlayCubit bloc;

  @override
  void dispose() {
    bloc.deleteTestData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LevelTestPlayCubit>(context);

    return Scaffold(
      body: Center(
        child: BlocConsumer<LevelTestPlayCubit, LevelTestPlayState>(
            bloc: bloc..init(),
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == TestStatus.progress || state.status == TestStatus.success) {
                return StreamBuilder(
                    stream: state.testsData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (state.tasksTree == null) {
                          bloc.makeTree(snapshot.data);
                        }
                        if (state.tasksTree != null && state.currentTest != null) {
                          return LinGameScreen(
                            question: state.currentTest!.testTask.question,
                            options: state.currentTest!.testTask.options,
                            selectedAnswers: state.selectedAnswers,
                            onSelected: bloc.selectOrDeselectAnswer,
                            onNextTask: bloc.loadNextTask,
                            remainingTime: state.remainingTime,
                          );
                        }
                        return const Text('Error generating test - try again :(');
                      }
                      return const SizedBox();
                    });
              } else if (state.status == TestStatus.error) {
                return Text(context.loc.error);
              } else if (state.status == TestStatus.notLoggedIn) {
                return Text(context.loc.notLoggedIn);
              } else if (state.status == TestStatus.result) {
                return Center(
                  child: Text('Your level is : ${state.currentLevel.levelName} (${state.currentLevel.name})'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
