import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_only_zone_container.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';
import 'package:lingui_quest/view/games_page/games_list/components/game_box.dart';
import 'package:lingui_quest/view/games_page/games_list/components/game_search.dart';
import 'package:rx_widgets/rx_widgets.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GamesListBloc>(context);
    return SingleChildScrollView(
      child: BlocBuilder<GamesListBloc, GamesListState>(
          bloc: bloc..add(FindCurrentUser()),
          builder: (_, state) {
            if (state.status == GamesUploadStatus.initial || state.status == GamesUploadStatus.search) {
              return Column(
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
                  GameSearch(),
                  state.status == GamesUploadStatus.initial
                      ? ReactiveWidget(stream: state.gamesList, widget: (list) => _GridGames(list: list))
                      : _GridGames(list: state.searchResult),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.page != 0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(PaddingConst.small),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child: Icon(FeatherIcons.arrowLeft),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(PaddingConst.small),
                            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                            child: Icon(FeatherIcons.arrowRight),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else if (state.status == GamesUploadStatus.progress) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Text(context.loc.error),
                  if (state.errorMessage != null) Text(state.errorMessage!),
                ],
              );
            }
          }),
    );
  }
}

class _GridGames extends StatelessWidget {
  const _GridGames({required this.list});
  final List<GameModel> list;

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
            itemBuilder: (_, index) => GameBox(game: list[index]))
        : Center(child: Text(context.loc.noResults));
  }
}
