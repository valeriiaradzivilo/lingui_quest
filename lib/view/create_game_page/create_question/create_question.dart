import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_question.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/create_game_page/create_question/bloc/create_question_bloc.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key, this.questionToEdit});
  final QuestionModel? questionToEdit;

  @override
  CreateQuestionState createState() => CreateQuestionState();
}

class CreateQuestionState extends State<CreateQuestionPage> {
  final _questionController = TextEditingController();
  late final List<TextEditingController> _optionsControllers;
  final _formKey = GlobalKey<FormState>();
  bool _forgotToChooseRightAnswer = false;
  bool _showPreview = false;
  late final QuestionCreationCubit cubit;

  @override
  void initState() {
    _optionsControllers = List.generate(widget.questionToEdit?.options.length ?? 4, (index) => TextEditingController());
    cubit = BlocProvider.of<QuestionCreationCubit>(context);
    cubit..init(widget.questionToEdit);
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final element in _optionsControllers) {
      element.dispose();
    }
    cubit.submitQuestion();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      content: BlocBuilder<QuestionCreationCubit, QuestionCreationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: PaddingConst.medium, vertical: PaddingConst.medium),
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - PaddingConst.immense),
              child: Form(
                key: _formKey,
                onChanged: () {
                  cubit.setQuestion(_questionController.text);
                  cubit.setOptions(_optionsControllers.map((e) => e.text).toList());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Question', style: theme.textTheme.displayMedium),
                    Gap(PaddingConst.large),
                    const Text('Question'),
                    Row(
                      children: [
                        Expanded(
                          child: LinTextField(
                            controller: _questionController,
                            initialValue: widget.questionToEdit?.question,
                          ),
                        ),
                        Tooltip(
                          message:
                              'Try adding ___ for missing text. Student will be able to see his input when they choose an option. ',
                          child: const Icon(Icons.info_outline_rounded),
                        ),
                      ],
                    ),
                    LinButton(
                        label: _showPreview ? 'Hide preview' : 'Check how it will look for your students',
                        onTap: () => setState(() => _showPreview = !_showPreview)),
                    if (_showPreview)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinQuestionText(textTask: _questionController.text, answer: []),
                      ),
                    const SizedBox(height: 16),
                    const Text(
                        'Options (to choose the correct option - click on number of option, click again to deselect)'),
                    Column(
                      children: List.generate(
                        _optionsControllers.length,
                        (index) => Padding(
                          padding: EdgeInsets.all(PaddingConst.small),
                          child: ListTile(
                            leading: InkWell(
                              onTap: () {
                                List<int> chosenOptions = [...state.question.correctAnswers];
                                if (chosenOptions.contains(index)) {
                                  chosenOptions.remove(index);
                                } else {
                                  chosenOptions.add(index);
                                }
                                cubit.setCorrectAnswers(chosenOptions);
                                if (_forgotToChooseRightAnswer) {
                                  setState(() => _forgotToChooseRightAnswer = chosenOptions.isEmpty);
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: state.question.correctAnswers.contains(index)
                                    ? theme.highlightColor
                                    : theme.canvasColor,
                                child: Text((index + 1).toString()),
                              ),
                            ),
                            title: LinTextField(
                              controller: _optionsControllers[index],
                              initialValue: widget.questionToEdit != null
                                  ? widget.questionToEdit!.options.length > index
                                      ? widget.questionToEdit?.options[index]
                                      : null
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: LinButton(
                            label: context.loc.deleteLastOption,
                            onTap: () {
                              setState(() => _optionsControllers.removeLast());
                              _formKey.currentState?.validate();
                              cubit.setOptions(_optionsControllers.map((e) => e.text).toList());
                            },
                            isTransparentBack: true,
                          ),
                        ),
                        Flexible(
                          child: LinButton(
                            label: context.loc.addOption,
                            onTap: () {
                              setState(() => _optionsControllers.add(TextEditingController()));
                              cubit.setOptions(_optionsControllers.map((e) => e.text).toList());
                            },
                            icon: FeatherIcons.plus,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_forgotToChooseRightAnswer)
                      Center(
                        child: Flexible(
                          child: Text(
                            context.loc.forgotToChooseCorrectAnswer,
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: LinButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            label: context.loc.cancel,
                          ),
                        ),
                        Flexible(
                          child: LinMainButton(
                            onTap: () async {
                              setState(() => _forgotToChooseRightAnswer = state.question.correctAnswers.isEmpty);

                              if ((_formKey.currentState?.validate() ?? false) && state.question.validate) {
                                cubit.submitQuestion();
                                Navigator.of(context).pop(state.question);
                              }
                            },
                            label: context.loc.questionCreate,
                          ),
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
