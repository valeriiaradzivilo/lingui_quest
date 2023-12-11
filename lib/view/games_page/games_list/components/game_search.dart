import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/enums/game_theme_enum.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_list_bloc.dart';

class GameSearch extends StatefulWidget {
  const GameSearch({super.key});

  @override
  State<GameSearch> createState() => _GameSearchState();
}

class _GameSearchState extends State<GameSearch> {
  final TextEditingController _controller = TextEditingController();
  final MenuController _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final bloc = BlocProvider.of<GamesListBloc>(context);
    return BlocBuilder<GamesListBloc, GamesListState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(vertical: PaddingConst.large, horizontal: PaddingConst.medium),
        child: Row(
          children: [
            Flexible(
                child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(label: Text(context.loc.search)),
              maxLines: 1,
              onChanged: (value) => bloc.add(ChangeSearchText(text: value)),
            )),
            Gap(PaddingConst.small),
            IconButton(onPressed: () => bloc.add(FindGames()), icon: Icon(FeatherIcons.search)),
            Gap(PaddingConst.small),
            MenuBar(
              controller: _menuController,
              children: [
                SubmenuButton(
                  menuChildren: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(PaddingConst.medium),
                          child: Column(
                            children: [
                              Text(context.loc.difficultyLevel),
                              for (final level in EnglishLevel.values)
                                Padding(
                                  padding: EdgeInsets.all(PaddingConst.small),
                                  child: CheckboxListTile(
                                    value: state.searchModel.level?.contains(level),
                                    onChanged: (_) => bloc.add(ChangeLevel(level: level)),
                                    title: Text(level.levelName),
                                  ),
                                ),
                              Gap(PaddingConst.small),
                              Text(context.loc.theme),
                              Gap(PaddingConst.small),
                              for (final theme in GameTheme.values)
                                if (theme != GameTheme.custom)
                                  Padding(
                                    padding: EdgeInsets.all(PaddingConst.small),
                                    child: CheckboxListTile(
                                      value: state.searchModel.theme?.contains(theme.label),
                                      onChanged: (_) => bloc.add(ChangeTheme(theme: theme)),
                                      title: Text(theme.label),
                                    ),
                                  ),
                              Gap(PaddingConst.medium),
                              OutlinedButton(
                                  onPressed: () => bloc.add(FindGames()), child: Text(context.loc.applyFilters))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  child: Icon(FeatherIcons.filter),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
