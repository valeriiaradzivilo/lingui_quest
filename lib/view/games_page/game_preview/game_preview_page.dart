import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/game_error_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/view/game_play_page/game_play_page.dart';
import 'package:lingui_quest/view/games_page/game_preview/bloc/game_preview_cubit.dart';

class GamePreviewPage extends StatelessWidget {
  const GamePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameId = ModalRoute.of(context)?.settings.name;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingConst.large),
          child: BlocBuilder<GamePreviewCubit, GamePreviewState>(
              bloc: BlocProvider.of<GamePreviewCubit>(context)..init(gameId),
              builder: (context, state) {
                if (state.status == GamePreviewStatus.initial) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Gap(PaddingConst.immense),
                        Text(
                          state.game.name,
                          style: theme.textTheme.displayMedium,
                        ),
                        Gap(PaddingConst.large),
                        Text('${context.loc.theme}: ${state.game.theme}'),
                        Gap(PaddingConst.medium),
                        Text('${context.loc.gameDescriptionLabel}: ${state.game.description}'),
                        Gap(PaddingConst.medium),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${context.loc.rate}: '),
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i <= (state.game.rate ?? -1) - 1 ? Icons.star_rate_rounded : Icons.star_outline_rounded,
                                color: i <= (state.game.rate ?? -1) - 1 ? Colors.orangeAccent : null,
                              )
                          ],
                        ),
                        if (state.currentUser == UserModel.empty()) ...[
                          Gap(PaddingConst.medium),
                          Text(
                            context.loc.gameNoteNotLoggedIn,
                            style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.error),
                          ),
                          Gap(PaddingConst.medium),
                        ],
                        LinMainButton(
                            label: context.loc.startGame,
                            onTap: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (_) => GamePlayPage(game: state.game)))),
                        if (state.game.creatorId == state.currentUser.userId) ...[
                          Gap(PaddingConst.immense),
                          Text(context.loc.youCreatedThisGame),
                          if (state.gameResults.isNotEmpty)
                            DataTable(dataRowMaxHeight: 200, headingRowHeight: 100, columns: [
                              DataColumn(label: Text(context.loc.student)),
                              DataColumn(label: Expanded(child: Text(context.loc.mark))),
                              DataColumn(label: Text(context.loc.mistakes)),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  context.loc.time,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                            ], rows: [
                              for (final result in state.gameResults)
                                DataRow(cells: [
                                  DataCell(Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 4),
                                    child: SelectableText('${result.user.firstName} ${result.user.lastName}'),
                                  )),
                                  DataCell(SelectableText(result.result
                                      .toString()
                                      .substring(0, result.result.toString().length > 4 ? 4 : null))),
                                  DataCell(result.errors.isNotEmpty
                                      ? TextButton(
                                          onPressed: () => showAdaptiveDialog(
                                            context: context,
                                            useSafeArea: true,
                                            builder: (context) => AlertDialog(
                                              content: Padding(
                                                padding: EdgeInsets.all(PaddingConst.immense),
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                    height: MediaQuery.of(context).size.height * 0.7,
                                                    child: ListView.separated(
                                                      itemBuilder: (context, index) =>
                                                          _MistakeWidget(result.errors[index]),
                                                      separatorBuilder: (context, index) => Divider(),
                                                      itemCount: result.errors.length,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          child: Text(context.loc.tapToSeeMistakes),
                                        )
                                      : SelectableText(context.loc.noMistakes)),
                                  DataCell(SelectableText(DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(DateTime.fromMillisecondsSinceEpoch(result.timeFinished))))
                                ]),
                            ]),
                        ]
                      ],
                    ),
                  );
                } else if (state.status == GamePreviewStatus.error) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.loc.error.toUpperCase()),
                        Text(
                          state.errorMessage ?? '',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class _MistakeWidget extends StatelessWidget {
  const _MistakeWidget(this.model);
  final GameErrorModel model;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Question: ${model.question.question}'),
          Text('Expected: ${model.question.correctAnswers.map((e) => model.question.options[e]).join(',')}'),
          Text(
              'Actual: ${model.actualResult.split(',').map((e) => model.question.options[int.tryParse(e) ?? 0]).join(',')}'),
        ],
      ),
    );
  }
}
