import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_round_photo.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/routes.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget({super.key});

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  bool _clikedOnAvatar = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<StartCubit, StartState>(builder: (context, state) {
      return PortalTarget(
        visible: _clikedOnAvatar,
        anchor: const Aligned(follower: Alignment.topLeft, target: Alignment.bottomCenter, offset: Offset(0, -5)),
        portalFollower: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _child(state.isLoggedIn)),
        child: LinRoundPhoto(
          onTap: () {
            setState(() {
              _clikedOnAvatar = !_clikedOnAvatar;
            });
          },
          radius: 40,
        ),
      );
    });
  }

  Widget _child(bool isLoggedIn) {
    if (!isLoggedIn) {
      return LinButton(
        label: context.loc.signIn,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.signIn),
      );
    } else {
      return Column(
        children: [
          LinButton(
            label: context.loc.profile,
            onTap: () {},
          ),
          const Divider(),
          LinButton(
            label: context.loc.signOut,
            onTap: () {},
          ),
        ],
      );
    }
  }
}
