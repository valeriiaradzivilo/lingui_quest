import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/view/groups/all_groups/bloc/groups_bloc.dart';
import 'package:lingui_quest/view/groups/all_groups/components/create_group_alert.dart';
import 'package:lingui_quest/view/groups/all_groups/components/group_box.dart';
import 'package:lingui_quest/view/groups/all_groups/components/join_group_alert.dart';
import 'package:rx_widgets/rx_widgets.dart';

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
                        onTap: () => showDialog(context: context, builder: (_) => CreateGroupAlert()),
                        icon: FeatherIcons.filePlus,
                      ),
                    LinMainButton(
                      label: context.loc.joinGroup,
                      onTap: () => showDialog(context: context, builder: (_) => JoinGroupAlert()),
                      icon: FeatherIcons.userPlus,
                    )
                  ],
                ),
                SizedBox(height: PaddingConst.large),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(PaddingConst.medium),
                    width: double.infinity,
                    child: ReactiveWidget(
                      stream: state.allGroups,
                      widget: (groups) => Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          spacing: PaddingConst.medium,
                          runSpacing: PaddingConst.medium,
                          children: [
                            for (int index = 0; index < groups.length; index++)
                              GroupBoxWidget(
                                group: groups[index],
                                isCreator: groups[index].creatorId == state.currentUser.userId,
                              ),
                          ]),
                    ),
                  ),
                )),
              ],
            );
          } else {
            return Center(child: Text(context.loc.notLoggedIn));
          }
        });
  }
}
