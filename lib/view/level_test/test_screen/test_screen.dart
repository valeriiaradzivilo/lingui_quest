import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/data/models/test_task_model.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_question.dart';
import 'package:lingui_quest/view/level_test/test_screen/bloc/test_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late TestTaskModel _currentTask;
  final List<int> _selectedAnswers = [];
  bool _isNextButtonActive = false;
  late Timer _timer;
  int _remainingTime = 3600;

  @override
  void initState() {
    super.initState();
    _loadNextTask();
    _startTimer();
  }

  void _loadNextTask() {
    // Load the next test task
    _currentTask = TestTaskModel(
      creatorId: '',
      level: 'Intermediate',
      question: 'I ____ you',
      options: ['love', 'hate', 'miss'],
      correctAnswerIds: [0],
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          // Calculate and show the test result
        }
      });
    });
  }

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
              if (state.status == TestStatus.success) {
                return StreamBuilder(
                    stream: state.testsData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (state.tasksTree == null) {
                          bloc.makeTree(snapshot.data);
                        }
                        if (state.tasksTree != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: LinQuestionText(
                                  textTask: _currentTask.question,
                                  insertedText: [for (final i in _selectedAnswers) _currentTask.options.elementAt(i)],
                                ),
                              ),
                              Column(
                                children: _currentTask.options.map((option) {
                                  final index = _currentTask.options.indexOf(option);
                                  return CheckboxListTile(
                                    title: Text(option),
                                    value: _selectedAnswers.contains(index),
                                    onChanged: (selected) {
                                      setState(() {
                                        if (selected!) {
                                          _selectedAnswers.add(index);
                                        } else {
                                          _selectedAnswers.remove(index);
                                        }
                                        _isNextButtonActive = _selectedAnswers.isNotEmpty;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: LinMainButton(
                                  onTap: _isNextButtonActive ? _loadNextTask : null,
                                  label: context.loc.next,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                    'Time Remaining: ${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}'),
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
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
