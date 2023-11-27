import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
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
                        Gap(PaddingConst.large),
                        LinMainButton(
                            label: context.loc.startGame,
                            onTap: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (_) => GamePlayPage(game: state.game))))
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
