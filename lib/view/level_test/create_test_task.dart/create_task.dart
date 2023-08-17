import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';

class CreateTestTaskPopup extends StatefulWidget {
  const CreateTestTaskPopup({super.key});

  @override
  CreateTestTaskPopupState createState() => CreateTestTaskPopupState();
}

class CreateTestTaskPopupState extends State<CreateTestTaskPopup> {
  final _questionController = TextEditingController();
  final _optionsControllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CreateTaskCubit cubit = BlocProvider.of<CreateTaskCubit>(context);
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Create Test Task'),
      content: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        bloc: cubit..init(),
        listener: (context, state) {
          // Implement any logic here when the task is created or canceled.
        },
        builder: (context, state) {
          if (state.creatorId.isNotEmpty) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: PaddingConst.immense, vertical: PaddingConst.medium),
              child: Container(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - PaddingConst.immense),
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    cubit.setQuestion(_questionController.text);
                    cubit.setAnswers(_optionsControllers.map((e) => e.text).toList());
                    cubit.validate();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Question'),
                      LinTextField(controller: _questionController),
                      const SizedBox(height: 16),
                      const Text(
                          'Options (to choose the correct option - click on number of option, click again to deselect)'),
                      Column(
                        children: List.generate(
                          _optionsControllers.length,
                          (index) => ListTile(
                            leading: InkWell(
                              onTap: () {
                                List<int> chosenOptions = [...state.chosenOption];
                                if (chosenOptions.contains(index)) {
                                  chosenOptions.remove(index);
                                } else {
                                  chosenOptions.add(index);
                                }
                                cubit.setCorrectAnswer(chosenOptions);
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    state.chosenOption.contains(index) ? theme.highlightColor : theme.canvasColor,
                                child: Text((index + 1).toString()),
                              ),
                            ),
                            title: LinTextField(controller: _optionsControllers[index]),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          LinButton(
                              label: 'Delete option',
                              onTap: () {
                                setState(() {
                                  _optionsControllers.removeLast();
                                });
                              }),
                          LinMainButton(
                            label: 'Add option',
                            onTap: () {
                              setState(() {
                                _optionsControllers.add(TextEditingController());
                              });
                            },
                            icon: FeatherIcons.plus,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Difficulty Level'),
                      DropdownButton<EnglishLevel>(
                        value: state.level,
                        items: EnglishLevel.values.map((level) {
                          return DropdownMenuItem<EnglishLevel>(
                            value: level,
                            child: Text('${level.levelName} (${level.name})'),
                          );
                        }).toList(),
                        onChanged: (level) {
                          if (level != null) {
                            cubit.setLevel(level);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LinButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            label: 'Delete',
                          ),
                          LinMainButton(
                            onTap: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                if (state.validationStatus == ValidationStatus.success) {
                                  await cubit.confirmAndAddTestTask();
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            isEnabled: (_formKey.currentState?.validate() ?? false),
                            label: 'Create task',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('You are not logged in');
          }
        },
      ),
    );
  }
}
