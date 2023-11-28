import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<GroupsBloc>(context);
    return BlocBuilder<GroupsBloc, GroupsState>(
        bloc: cubit..getCurrentUser(),
        builder: (context, state) {
          if (state.currentUser != UserModel.empty()) {
            return Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.center,
                  spacing: PaddingConst.medium,
                  children: [
                    Text(
                      context.loc.myGroups,
                      style: theme.textTheme.displayLarge,
                    ),
                    if (state.currentUser.isTutor)
                      LinMainButton(
                        label: context.loc.createGroup,
                        onTap: () {},
                        icon: FeatherIcons.filePlus,
                      ),
                    LinMainButton(
                      label: context.loc.joinGroup,
                      onTap: () {},
                      icon: FeatherIcons.userPlus,
                    )
                  ],
                ),
                SizedBox(height: PaddingConst.large),
                Expanded(
                    child: SingleChildScrollView(
                  child: Wrap(children: [
                    for (int index = 0; index < state.allGroups.length; index++)
                      _GroupBoxWidget(
                        group: state.allGroups[index],
                        isCreator: state.allGroups[index].creatorId == state.currentUser.userId,
                      ),
                  ]),
                )),
              ],
            );
          } else {
            return Center(child: Text(context.loc.notLoggedIn));
          }
        });
  }
}

class _GroupBoxWidget extends StatelessWidget {
  const _GroupBoxWidget({required this.group, required this.isCreator});
  final GroupModel group;
  final bool isCreator;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(PaddingConst.small),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), border: Border.all(color: theme.colorScheme.onBackground)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: isCreator
                ? Container(
                    padding: EdgeInsets.all(PaddingConst.extraSmall),
                    color: theme.colorScheme.errorContainer,
                    child: Text(context.loc.tutor),
                  )
                : Container(
                    padding: EdgeInsets.all(PaddingConst.extraSmall),
                    color: Colors.cyan[900],
                    child: Text(context.loc.student),
                  ),
          ),
          Gap(PaddingConst.medium),
          Flexible(
            child: Column(
              children: [
                Text(
                  group.name,
                ),
                Text(
                  group.description,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Gap(PaddingConst.medium),
          IconButton(
            icon: Icon(FeatherIcons.arrowRight),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
