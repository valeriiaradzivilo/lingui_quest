import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/view/level_test/create_test_task.dart/bloc/create_task_bloc.dart';

class CreateTestTaskPopup extends StatefulWidget {
  const CreateTestTaskPopup({super.key});

  @override
  CreateTestTaskPopupState createState() => CreateTestTaskPopupState();
}

class CreateTestTaskPopupState extends State<CreateTestTaskPopup> {
  final _questionController = TextEditingController();
  final _optionsControllers = List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final CreateTaskCubit cubit = BlocProvider.of<CreateTaskCubit>(context);
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: const Text('Create Test Task'),
      content: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        listener: (context, state) {
          // Implement any logic here when the task is created or canceled.
        },
        builder: (context, state) {
          return Container(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - PaddingConst.immence),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Question'),
                TextField(controller: _questionController),
                const SizedBox(height: 16),
                const Text('Options'),
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
                      title: TextField(controller: _optionsControllers[index]),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Difficulty Level'),
                DropdownButton<EnglishLevel>(
                  value: state.level,
                  items: EnglishLevel.values.map((level) {
                    return DropdownMenuItem<EnglishLevel>(
                      value: level,
                      child: Text(level.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (level) {
                    if (level != null) {
                      cubit.setLevel(level);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Implement the logic to save the task.
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
