import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';

class JoinRequestsAlertDialog extends StatelessWidget {
  const JoinRequestsAlertDialog({super.key, required this.joinRequests});
  final List<JoinRequestFullModel> joinRequests;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(context.loc.joinRequests),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final request in joinRequests) ...[
                _JoinRequestTile(request),
                Gap(PaddingConst.medium),
              ]
            ],
          ),
        ));
  }
}

class _JoinRequestTile extends StatelessWidget {
  const _JoinRequestTile(this.model);
  final JoinRequestFullModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(PaddingConst.medium),
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(20)),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '${model.user.firstName} ${model.user.lastName} ${context.loc.wantsToJoinTheGroup} : ${model.group.name}',
                style: theme.textTheme.titleLarge,
                overflow: TextOverflow.visible,
              ),
            ),
            Gap(PaddingConst.small),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LinButton(
                  label: context.loc.decline,
                  onTap: () {},
                  isTransparentBack: true,
                ),
                LinButton(label: context.loc.accept, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
