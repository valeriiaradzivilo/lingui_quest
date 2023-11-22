import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/games_page/create_game/create_question/bloc/create_question_bloc.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key, this.questionToEdit});
  final QuestionModel? questionToEdit;

  @override
  CreateQuestionState createState() => CreateQuestionState();
}

class CreateQuestionState extends State<CreateQuestionPage> {
  final _questionController = TextEditingController();
  final _optionsControllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final cubit = BlocProvider.of<QuestionCreationCubit>(context);
    return AlertDialog(
      title: const Text('Create Test Task'),
      content: BlocConsumer<QuestionCreationCubit, QuestionCreationState>(
        bloc: cubit..init(widget.questionToEdit),
        listener: (context, state) {
          // Implement any logic here when the task is created or canceled.
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: PaddingConst.immense, vertical: PaddingConst.medium),
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - PaddingConst.immense),
              child: Form(
                key: _formKey,
                onChanged: () {
                  _formKey.currentState?.validate();
                  cubit.setQuestion(_questionController.text);
                  cubit.setOptions(_optionsControllers.map((e) => e.text).toList());
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
                              List<int> chosenOptions = [...state.question.correctAnswers];
                              if (chosenOptions.contains(index)) {
                                chosenOptions.remove(index);
                              } else {
                                chosenOptions.add(index);
                              }
                              cubit.setCorrectAnswers(chosenOptions);
                            },
                            child: CircleAvatar(
                              backgroundColor: state.question.correctAnswers.contains(index)
                                  ? theme.highlightColor
                                  : theme.canvasColor,
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
                        LinButton(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LinButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          label: context.loc.cancel,
                        ),
                        LinButton(
                          onTap: () async {
                            if ((_formKey.currentState?.validate() ?? false) && state.question.validate) {
                              Navigator.of(context).pop(state.question);
                            }
                          },
                          isEnabled: (_formKey.currentState?.validate() ?? false),
                          label: context.loc.questionCreate,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
