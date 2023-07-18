import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
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
        anchor: const Aligned(
            follower: kIsWeb ? Alignment.topLeft : Alignment.bottomCenter,
            target: kIsWeb ? Alignment.bottomCenter : Alignment.topLeft,
            offset: Offset(0, -5)),
        portalFollower: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _child(state.isLoggedIn)),
        child: LinRoundPhoto(
          key: ValueKey(KeyConstants.avatarPortal),
          radius: kIsWeb ? 50 : 20,
          onTap: () {
            setState(() {
              _clikedOnAvatar = !_clikedOnAvatar;
            });
          },
        ),
      );
    });
  }

  Widget _child(bool isLoggedIn) {
    if (!isLoggedIn) {
      return LinButton(
        key: ValueKey(KeyConstants.signInButton),
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
