import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
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
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverGrid.builder(
                        itemBuilder: (_, index) => Container(
                          color: Colors.red,
                          width: 100,
                          height: 200,
                        ),
                        // separatorBuilder: (_, __) => const VerticalDivider(),
                        itemCount: 10,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          // childAspectRatio: 4.0,
                        ),
                      )
                    ],
                    body: const SizedBox(),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       children: [Text(context.loc.myGroups), LinMainButton(label: context.loc.joinGroup, onTap: () {})],
                    //     ),

                    //   ],
                    // ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text(context.loc.notLoggedIn));
          }
        });
  }
}
