import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/game_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/start/app_routes.dart';

class GameBox extends StatelessWidget {
  const GameBox({required this.game});
  final GameModel game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('${AppRoutes.game.path}=${game.id}'),
      child: Padding(
          padding: EdgeInsets.all(PaddingConst.medium),
          child: Container(
            padding: EdgeInsets.all(PaddingConst.medium),
            decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.colorScheme.onBackground)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                game.name,
                style: theme.textTheme.headlineMedium,
              ),
              MaxGap(20),
              Text(
                '${context.loc.gameTheme}: ${game.theme}',
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [for (int i = 0; i < 5; i++) Icon(FeatherIcons.star)],
              ),
            ]),
          )),
    );
  }
}
