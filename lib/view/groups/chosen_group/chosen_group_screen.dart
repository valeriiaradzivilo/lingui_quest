import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_info_section.dart';
import 'package:lingui_quest/view/games_page/games_list/components/game_box.dart';
import 'package:lingui_quest/view/groups/bloc/groups_bloc.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ChosenGroupScreen extends StatelessWidget {
  const ChosenGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.of<GroupsBloc>(context);
    final groupCode = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      body: BlocBuilder<GroupsBloc, GroupsState>(
          bloc: bloc..findChosenGroupByCode(groupCode ?? ''),
          builder: (context, state) {
            if (state.status != GroupsStatus.initial && state.status != GroupsStatus.error) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == GroupsStatus.error || state.chosenGroup.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(context.loc.error), Text(state.errorMessage ?? '')],
                ),
              );
            }
            final group = state.chosenGroup.group;
            final tutor = state.chosenGroup.tutor;
            final students = state.chosenGroup.students;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(PaddingConst.medium),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(PaddingConst.medium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(context.loc.group, style: theme.textTheme.displaySmall),
                                Gap(PaddingConst.medium),
                                Text('${context.loc.groupName}: ${group.name}'),
                                Gap(PaddingConst.medium),
                                Text('${context.loc.groupDescription}: ${group.description}'),
                                Gap(PaddingConst.medium),
                                LinMainButton(
                                    label: context.loc.showCode,
                                    onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: theme.cardColor,
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(color: theme.highlightColor),
                                              ),
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              padding: EdgeInsets.all(PaddingConst.medium),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    context.loc.code,
                                                    style: theme.textTheme.titleLarge,
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Flexible(child: Text(group.code)),
                                                      IconButton(
                                                        icon: Icon(FeatherIcons.copy),
                                                        onPressed: () async {
                                                          await Clipboard.setData(ClipboardData(text: group.code));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            child: LinTutorInfoSection(
                          tutor: tutor,
                          user: state.chosenGroup.tutorUserData,
                        ))
                      ],
                    ),
                    Gap(PaddingConst.medium),
                    Text(
                      context.loc.games.toUpperCase(),
                      style: theme.textTheme.displaySmall,
                    ),
                    ReactiveWidget(
                      stream: state.chosenGroup.games,
                      widget: (games) => games.isNotEmpty
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.onBackground)),
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
                                itemBuilder: (_, index) => GameBox(game: games[index]),
                                itemCount: games.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            )
                          : Text(context.loc.noResults),
                    ),
                    Gap(PaddingConst.large),
                    if (group.creatorId == state.currentUser.userId) ...[
                      Text(
                        context.loc.students.toUpperCase(),
                        style: theme.textTheme.displaySmall,
                      ),
                      if (students.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.onBackground)),
                          padding: EdgeInsets.all(PaddingConst.medium),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${index + 1}. '),
                                Flexible(
                                    child: Text(
                                  '${students[index].firstName} ${students[index].lastName}',
                                  overflow: TextOverflow.ellipsis,
                                )),
                                Gap(PaddingConst.medium),
                                IconButton(
                                    onPressed: () async {
                                      final deletedUser = await bloc.deleteStudentFromGroup(students[index].userId);
                                      if (deletedUser) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: deletedUser
                                                ? Text(context.loc.deletedStudentSuccessfully)
                                                : Text(context.loc.couldNotDeleteStudent),
                                            backgroundColor:
                                                deletedUser ? theme.colorScheme.primary : theme.colorScheme.error,
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      FeatherIcons.trash,
                                      color: theme.colorScheme.error,
                                    ))
                              ],
                            ),
                            itemCount: students.length,
                          ),
                        )
                      else
                        Text(context.loc.noResults)
                    ]
                  ],
                ),
              ),
            );
          }),
    );
  }
}
