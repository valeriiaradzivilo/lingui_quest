import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_game_screen.dart';
import 'package:lingui_quest/view/level_test/test_screen/bloc/test_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TestCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FeatherIcons.arrowLeft),
          onPressed: () {
            //bloc.deleteData
          },
        ),
      ),
      body: Center(
        child: BlocConsumer<TestCubit, TestState>(
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
                return const Text('Error');
              } else if (state.status == TestStatus.notLoggedIn) {
                return const Text('You need to log in first to complete the test');
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
