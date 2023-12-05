import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_info_section.dart';
import 'package:lingui_quest/view/groups/all_groups/bloc/groups_bloc.dart';

class ChosenGroupScreen extends StatelessWidget {
  const ChosenGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
        if (state.chosenGroup == null) {
          return Center(
            child: Text(context.loc.error),
          );
        }
        final group = state.chosenGroup!.group;
        final tutor = state.chosenGroup!.tutor;
        return Padding(
          padding: EdgeInsets.all(PaddingConst.medium),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.loc.group,
                          style: theme.textTheme.displaySmall,
                        ),
                        Text('${context.loc.groupName}: ${group.name}'),
                        Text('${context.loc.groupDescription}: ${group.description}'),
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
                                        children: [
                                          Text(
                                            context.loc.code,
                                            style: theme.textTheme.titleLarge,
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Expanded(child: Text(group.code)),
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
                  Flexible(child: LinTutorInfoSection(tutor: tutor))
                ],
              ),
              Gap(PaddingConst.medium),
              Text(
                context.loc.games.toUpperCase(),
                style: theme.textTheme.displaySmall,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (_, index) => SizedBox()),
              )
            ],
          ),
        );
      }),
    );
  }
}
