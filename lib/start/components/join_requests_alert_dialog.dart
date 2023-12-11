import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';

class JoinRequestsAlertDialog extends StatefulWidget {
  const JoinRequestsAlertDialog({super.key});

  @override
  State<JoinRequestsAlertDialog> createState() => _JoinRequestsAlertDialogState();
}

class _JoinRequestsAlertDialogState extends State<JoinRequestsAlertDialog> {
  late final StartCubit bloc;
  // @override
  // void dispose() {
  //   bloc.closeStream();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartCubit, StartState>(
      builder: (context, state) => AlertDialog(
          title: Text(context.loc.joinRequests),
          content: SingleChildScrollView(
            child: StreamBuilder<List<JoinRequestFullModel>?>(
                stream: state.joinRequests,
                builder: (context, joinRequestsSnapshot) {
                  if (joinRequestsSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (joinRequestsSnapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final request in joinRequestsSnapshot.data!) ...[
                          _JoinRequestTile(request),
                          Gap(PaddingConst.medium),
                        ]
                      ],
                    );
                  } else {
                    return Text(context.loc.noRequestsFound);
                  }
                }),
          )),
    );
  }
}

class _JoinRequestTile extends StatelessWidget {
  const _JoinRequestTile(this.model);
  final JoinRequestFullModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.of<StartCubit>(context);
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
                  onTap: () => bloc.declineJoinRequest(model),
                  isTransparentBack: true,
                ),
                LinButton(
                  label: context.loc.accept,
                  onTap: () => bloc.acceptJoinRequest(model),
                  icon: FeatherIcons.check,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
