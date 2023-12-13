import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/question_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_number_editing_field.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/start/components/home_icon_button.dart';
import 'package:lingui_quest/view/create_game_page/bloc/create_game_bloc.dart';
import 'package:lingui_quest/view/create_game_page/create_question/create_question.dart';

enum CreateGameMainParts {
  name,
  description,
  theme,
  time;

  Widget widget({TextEditingController? controller, required BuildContext context, required GameCreationState state}) =>
      switch (this) {
        name => _TopicNTextField(controller: controller!, topic: topic(context), label: label(context)),
        description => _TopicNTextField(controller: controller!, topic: topic(context), label: label(context)),
        theme => _ThemeWidget(
            themeController: controller!,
            label: label(context),
            topic: topic(context),
            state: state,
          ),
        time => _TopicNTextField(controller: controller!, topic: topic(context), label: label(context))
      };

  String topic(BuildContext context) => switch (this) {
        name => context.loc.gameName,
        description => context.loc.gameDescription,
        theme => context.loc.gameTheme,
        time => context.loc.gameTime,
      };
  String label(BuildContext context) => switch (this) {
        name => context.loc.gameNameLabel,
        description => context.loc.gameDescriptionLabel,
        theme => context.loc.gameTheme,
        time => context.loc.gameTimeLabel
      };
}

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final GameCreationCubit bloc = BlocProvider.of<GameCreationCubit>(context);
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: HomeIconButton(
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.initial.path),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<GameCreationCubit, GameCreationState>(
            builder: (_, state) => Form(
              key: formKey,
              onChanged: () {
                final validRes = formKey.currentState?.validate() ?? false;
                if (validRes) {
                  bloc.setName(_nameController.text);
                  bloc.setDescription(_descriptionController.text);
                  if (state.customTheme) {
                    bloc.setTheme(_themeController.text);
                  }
                  bloc.setTime(_timeController.text);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(PaddingConst.large),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (final part in CreateGameMainParts.values) ...[
                      part.widget(controller: _correctController(part), context: context, state: state),
                      Gap(PaddingConst.large),
                    ],
                    _ChooseLevel(
                      value: state.game.level,
                      onChanged: bloc.setLevel,
                    ),
                    Gap(PaddingConst.medium),
                    _TopicText(context.loc.gameQuestions),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: theme.colorScheme.onBackground)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (state.game.questions.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (_, index) => _QuestionTile(
                                question: state.game.questions[index],
                                index: index,
                              ),
                              itemCount: state.game.questions.length,
                            ),
                          LinButton(
                            label: context.loc.gameAddQuestion,
                            onTap: () async {
                              final newQuestion = await showDialog<QuestionModel>(
                                  context: context, builder: (_) => CreateQuestionPage());
                              if (newQuestion != null) bloc.addQuestion(newQuestion);
                            },
                            icon: FeatherIcons.plusCircle,
                          ),
                        ],
                      ),
                    ),
                    Gap(PaddingConst.medium),
                    SwitchListTile(
                      value: state.isPublic,
                      onChanged: bloc.setPublic,
                      title: Text(context.loc.public),
                      secondary: Tooltip(
                        message: context.loc.publicInfo,
                        child: const Icon(Icons.info_outline_rounded),
                      ),
                    ),
                    if (!state.isPublic) ...[
                      Gap(PaddingConst.small),
                      _GroupSelectionBox(state),
                    ],
                    Gap(PaddingConst.medium),
                    if (state.errorMessage != null && state.errorMessage!.isNotEmpty)
                      Text(
                        state.errorMessage!,
                        style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.error),
                      ),
                    Gap(PaddingConst.medium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LinButton(
                          label: context.loc.cancel,
                          onTap: () => Navigator.pushNamed(context, AppRoutes.initial.path),
                          isTransparentBack: true,
                        ),
                        LinMainButton(
                          label: context.loc.createGame,
                          onTap: () async {
                            if ((formKey.currentState?.validate() ?? false) && state.game.validate) {
                              final isSuccessfullyCreated = await bloc.submitGame();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(isSuccessfullyCreated
                                    ? context.loc.successfullyCreatedTheGame
                                    : context.loc.couldNotCreateTheGame),
                                backgroundColor: isSuccessfullyCreated ? Colors.green : theme.colorScheme.error,
                              ));
                              Navigator.pushNamed(context, AppRoutes.initial.path);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController? _correctController(CreateGameMainParts part) => switch (part) {
        CreateGameMainParts.name => _nameController,
        CreateGameMainParts.description => _descriptionController,
        CreateGameMainParts.theme => _themeController,
        CreateGameMainParts.time => _timeController
      };
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({required this.question, required this.index});
  final QuestionModel question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GameCreationCubit bloc = BlocProvider.of<GameCreationCubit>(context);
    return Padding(
      padding: EdgeInsets.all(PaddingConst.small),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.highlightColor),
        ),
        title: Text(
          question.question,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(FeatherIcons.edit2),
              onPressed: () async {
                final newQuestion = await showDialog<QuestionModel?>(
                    context: context,
                    builder: (_) => CreateQuestionPage(
                          questionToEdit: question,
                        ));
                if (newQuestion != null) bloc.replaceQuestion(newQuestion, index);
              },
            ),
            Gap(PaddingConst.small),
            IconButton(
              onPressed: () {
                bloc.deleteQuestion(index);
              },
              icon: Icon(
                FeatherIcons.trash2,
                color: theme.colorScheme.error,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TopicNTextField extends StatelessWidget {
  const _TopicNTextField({required this.controller, required this.topic, required this.label});
  final TextEditingController controller;
  final String topic;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopicText(topic),
        topic == CreateGameMainParts.time.topic(context)
            ? LinNumberEditingField(
                controller: controller,
                label: label,
              )
            : LinTextField(
                controller: controller,
                label: label,
              ),
      ],
    );
  }
}

class _TopicText extends StatelessWidget {
  const _TopicText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.headlineMedium,
    );
  }
}

class _ThemeWidget extends StatelessWidget {
  const _ThemeWidget({required this.topic, required this.label, required this.themeController, required this.state});
  final String topic;
  final String label;
  final TextEditingController themeController;
  final GameCreationState state;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GameCreationCubit bloc = BlocProvider.of<GameCreationCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopicText(topic),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              dropdownColor: theme.colorScheme.secondaryContainer,
              value: (state.game.theme.isNotEmpty && GameTheme.values.map((e) => e.label).contains(state.game.theme))
                  ? state.game.theme
                  : GameTheme.custom.label,
              items: GameTheme.values.map((theme) {
                return DropdownMenuItem<String>(
                  value: theme.label,
                  child: Text(theme.label),
                );
              }).toList(),
              onChanged: (val) {
                bloc.setThemeDropdown(val);
              },
            ),
            if (state.customTheme) ...[
              SizedBox(width: PaddingConst.medium),
              Expanded(
                child: LinTextField(
                  controller: themeController,
                  label: context.loc.gameTheme,
                ),
              ),
            ]
          ],
        ),
      ],
    );
  }
}

class _ChooseLevel extends StatelessWidget {
  const _ChooseLevel({this.value, this.onChanged});
  final EnglishLevel? value;
  final void Function(EnglishLevel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopicText(context.loc.difficultyLevel),
          DropdownButton<EnglishLevel>(
            dropdownColor: theme.colorScheme.secondaryContainer,
            value: value,
            items: EnglishLevel.values.map((level) {
              return DropdownMenuItem<EnglishLevel>(
                value: level,
                child: Text('${level.levelName} (${level.name})'),
              );
            }).toList(),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}

class _GroupSelectionBox extends StatelessWidget {
  const _GroupSelectionBox(this.state);
  final GameCreationState state;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GameCreationCubit bloc = BlocProvider.of<GameCreationCubit>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.highlightColor),
      ),
      padding: EdgeInsets.all(PaddingConst.medium),
      child: Column(
        children: [
          Text(
            context.loc.chooseGroups,
            style: theme.textTheme.headlineSmall,
          ),
          if (state.availableGroups.isEmpty) Text(context.loc.noGroupsFound),
          for (final group in state.availableGroups)
            Padding(
              padding: EdgeInsets.all(PaddingConst.medium),
              child: CheckboxListTile(
                value: state.game.groups.contains(group.code),
                onChanged: (_) => bloc.selectGroups(group),
                title: Text(group.name),
              ),
            )
        ],
      ),
    );
  }
}
