import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_question.dart';
import 'package:lingui_quest/view/level_test/test_screen/bloc/test_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TestCubit>(context);
    return Scaffold(
      appBar: AppBar(),
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: LinQuestionText(
                                  textTask: state.currentTest!.testTask.question,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (state.currentTest!.testTask.options[index].isNotEmpty) {
                                    return CheckboxListTile(
                                      title: Text(state.currentTest!.testTask.options[index]),
                                      value: state.selectedAnswers.contains(index),
                                      onChanged: (selected) => bloc.selectOrDeselectAnswer(index),
                                    );
                                  }
                                  return null;
                                },
                                itemCount: state.currentTest!.testTask.options.map((e) => e.isNotEmpty).length,
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: LinMainButton(
                                  onTap: state.selectedAnswers.isNotEmpty ? bloc.loadNextTask : null,
                                  label: context.loc.next,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                    'Time Remaining: ${state.remainingTime ~/ 60}:${(state.remainingTime % 60).toString().padLeft(2, '0')}'),
                              ),
                            ],
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
