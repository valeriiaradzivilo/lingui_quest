import 'package:feather_icons/feather_icons.dart';
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
  bool _clickedOnAvatar = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final StartCubit bloc = BlocProvider.of<StartCubit>(context);
    return BlocBuilder<StartCubit, StartState>(builder: (context, state) {
      return PortalTarget(
          visible: _clickedOnAvatar,
          anchor: const Aligned(
            follower: kIsWeb ? Alignment.topCenter : Alignment.bottomCenter,
            target: kIsWeb ? Alignment.bottomCenter : Alignment.topLeft,
          ),
          portalFollower: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _child(state.isLoggedIn)),
          child: _icon(state.isLoggedIn, state.currentUser.email, bloc));
    });
  }

  Widget _icon(bool isLoggedIn, String? initials, StartCubit bloc) {
    final ThemeData theme = Theme.of(context);
    return LinRoundPhoto(
      key: ValueKey(KeyConstants.avatarPortal),
      radius: kIsWeb ? 50 : 20,
      onTap: () {
        bloc.checkLoggedIn();
        setState(() {
          _clickedOnAvatar = !_clickedOnAvatar;
        });
      },
      child: !isLoggedIn || initials == null || initials.isEmpty
          ? const Icon(FeatherIcons.user)
          : Text(
              initials.substring(0, 1).toUpperCase(),
              style: theme.textTheme.displayMedium,
            ),
    );
  }

  Widget _child(bool isLoggedIn) {
    if (!isLoggedIn) {
      return LinButton(
        isTransparentBack: true,
        key: ValueKey(KeyConstants.signInButton),
        label: context.loc.signIn,
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.signIn),
      );
    } else {
      return Container(
        constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
        child: Column(
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
        ),
      );
    }
  }
}
