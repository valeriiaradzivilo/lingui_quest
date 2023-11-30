import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/groups/all_groups/bloc/groups_bloc.dart';

class CreateGroupAlert extends StatefulWidget {
  const CreateGroupAlert({super.key});

  @override
  State<CreateGroupAlert> createState() => _CreateGroupAlertState();
}

class _CreateGroupAlertState extends State<CreateGroupAlert> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GroupsBloc>(context);
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(context.loc.createGroup),
      content: Column(
        children: [
          LinTextField(
            controller: _nameController,
            label: context.loc.groupName,
          ),
          Gap(PaddingConst.medium),
          LinTextField(
            controller: _descriptionController,
            label: context.loc.groupDescription,
          ),
          Gap(PaddingConst.medium),
          Text(context.loc.createGroupInfo),
        ],
      ),
      actions: [
        LinButton(
          label: context.loc.cancel,
          onTap: () => Navigator.of(context).pop(),
          isTransparentBack: true,
        ),
        LinButton(
          label: context.loc.createGroup,
          onTap: () async {
            final groupCreationRes = await cubit.createGroup(_nameController.text, _descriptionController.text);
            if (!groupCreationRes) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.loc.groupWasNotCreated),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.loc.groupWasCreatedSuccessfully),
                  backgroundColor: Colors.cyan[800],
                ),
              );
            }
            Navigator.of(context).pop();
          },
          isEnabled: _nameController.text.isNotEmpty && _descriptionController.text.isNotEmpty,
        ),
      ],
    );
  }
}
