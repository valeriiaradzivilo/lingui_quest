import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/groups/all_groups/bloc/groups_bloc.dart';

class JoinGroupAlert extends StatefulWidget {
  const JoinGroupAlert({super.key});

  @override
  State<JoinGroupAlert> createState() => _JoinGroupAlertState();
}

class _JoinGroupAlertState extends State<JoinGroupAlert> {
  final TextEditingController _codeFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GroupsBloc>(context);
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(context.loc.joinGroup),
      content: LinTextField(
        controller: _codeFieldController,
        label: context.loc.code,
      ),
      actions: [
        LinButton(
          label: context.loc.cancel,
          onTap: () => Navigator.of(context).pop(),
          isTransparentBack: true,
        ),
        LinButton(
            label: context.loc.findGroup,
            onTap: () async {
              final searchResult = await cubit.findGroupByCode(_codeFieldController.text);
              if (!searchResult) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.loc.couldNotFindGroup),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
                return;
              }
              Navigator.of(context).pop();
              showDialog(context: context, builder: (_) => _ConfirmGroupSearch());
            }),
      ],
    );
  }
}

class _ConfirmGroupSearch extends StatelessWidget {
  const _ConfirmGroupSearch();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.isItCorrectGroup),
      content: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
        if (state.searchResultGroup != null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${context.loc.groupName}:${state.searchResultGroup!.name}'),
              Gap(PaddingConst.medium),
              Text('${context.loc.groupDescription}:${state.searchResultGroup!.description}')
            ],
          );
        }
        return Center(child: Text(context.loc.error));
      }),
      actions: [
        LinButton(
          label: context.loc.cancel,
          onTap: () => Navigator.of(context).pop(),
          isTransparentBack: true,
        ),
        LinButton(label: context.loc.confirm, onTap: () {})
      ],
    );
  }
}
