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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      game.name,
                      style: theme.textTheme.headlineSmall,
                      overflow: TextOverflow.visible,
                      maxLines: 3,
                    ),
                  ),
                  Gap(PaddingConst.small),
                  Flexible(
                    child: Text(
                      '${context.loc.gameTheme}: ${game.theme}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            i <= (game.rate ?? -1) - 1 ? Icons.star_rate_rounded : Icons.star_outline_rounded,
                            color: i <= (game.rate ?? -1) - 1 ? Colors.orangeAccent : null,
                          )
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }
}
