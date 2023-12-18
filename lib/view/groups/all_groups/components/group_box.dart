import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';

class GroupBoxWidget extends StatelessWidget {
  const GroupBoxWidget({required this.group, required this.isCreator});
  final GroupModel group;
  final bool isCreator;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<GroupsBloc>(context);
    return InkWell(
      onTap: () async {
        await cubit.chosenGroup(group);
        Navigator.pushNamed(context, AppRoutes.group.path + group.code);
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.onBackground)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: PaddingConst.medium),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: isCreator
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(PaddingConst.extraSmall),
                          color: theme.colorScheme.errorContainer,
                          child: Center(child: Text(context.loc.tutor)),
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(PaddingConst.extraSmall),
                          color: Colors.cyan[800],
                          child: Center(child: Text(context.loc.student)),
                        ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      group.name,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineMedium,
                    ),
                    Gap(PaddingConst.small),
                    Text(
                      '${context.loc.groupDescription}: ${group.description}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(FeatherIcons.arrowRight),
                onPressed: () async {
                  await cubit.chosenGroup(group);
                  Navigator.pushNamed(context, AppRoutes.group.path + group.code);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
