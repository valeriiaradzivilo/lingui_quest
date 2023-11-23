import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_only_zone_container.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:rx_widgets/rx_widgets.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GamesListBloc>(context);
    return BlocBuilder<GamesListBloc, GamesListState>(
      bloc: bloc
        ..add(FindCurrentUser())
        ..add(FindAllGames()),
      builder: (_, state) => Column(
        children: [
          if (state.currentUser.isTeacher)
            LinTutorOnlyZoneContainer(
              child: Row(
                children: [
                  Expanded(child: Text(context.loc.tutorOnlyZone)),
                  Gap(PaddingConst.small),
                  LinMainButton(
                    label: context.loc.createGame,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.createGame),
                  ),
                ],
              ),
            ),
          Expanded(
              child: ReactiveWidget(
            stream: state.gamesList,
            widget: (list) => GridView.builder(
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
                itemBuilder: (_, index) => _GamePreview(game: list[index])),
          ))
        ],
      ),
    );
  }
}

class _GamePreview extends StatelessWidget {
  const _GamePreview({required this.game});
  final GameModel game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.all(PaddingConst.medium),
        child: Container(
          padding: EdgeInsets.all(PaddingConst.medium),
          decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.onBackground)),
          child: Column(children: [
            Text(
              game.name,
              style: theme.textTheme.headlineMedium,
            ),
            MaxGap(20),
            Row(
              children: [
                Text('${context.loc.gameTheme}: '),
                Text(game.theme),
              ],
            ),
            Spacer(),
            Row(
              children: [for (int i = 0; i < 5; i++) Icon(FeatherIcons.star)],
            ),
          ]),
        ));
  }
}
