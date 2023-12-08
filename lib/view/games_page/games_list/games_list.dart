import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_only_zone_container.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:lingui_quest/view/games_page/games_list/components/game_box.dart';
import 'package:rx_widgets/rx_widgets.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GamesListBloc>(context);
    return BlocBuilder<GamesListBloc, GamesListState>(
      bloc: bloc..add(FindCurrentUser()),
      builder: (_, state) => Column(
        children: [
          if (state.currentUser.isTutor)
            LinTutorOnlyZoneContainer(
              child: Row(
                children: [
                  Expanded(child: Text(context.loc.tutorOnlyZone)),
                  Gap(PaddingConst.small),
                  LinMainButton(
                    label: context.loc.createGame,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.createGame.path),
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
                itemBuilder: (_, index) => GameBox(game: list[index])),
          ))
        ],
      ),
    );
  }
}
