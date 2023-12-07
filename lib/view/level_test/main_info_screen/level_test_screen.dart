import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_tutor_only_zone_container.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/view/level_test/main_info_screen/bloc/level_test_bloc.dart';

class LevelTestScreen extends StatelessWidget {
  const LevelTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LevelTestBloc bloc = BlocProvider.of<LevelTestBloc>(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(PaddingConst.medium),
          child: BlocConsumer<LevelTestBloc, LevelTestState>(
              bloc: bloc..getCurrentUser(),
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == LevelTestStatus.initial) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(context.loc.levelTestInfo),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(PaddingConst.large),
                          child: LinMainButton(
                              label: context.loc.startTest,
                              onTap: () => Navigator.of(context).pushNamed(AppRoutes.test.path)),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: context.loc.note,
                            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                            children: [TextSpan(text: context.loc.levelTestNote, style: theme.textTheme.labelMedium)]),
                      ),
                      SizedBox(height: PaddingConst.large),
                      if (state.currentUser.isTutor) const _CreateTestTask(),
                    ],
                  );
                } else if (state.status == LevelTestStatus.error) {
                  return const Text('Error');
                } else if (state.status == LevelTestStatus.notSignedIn) {
                  return const Text('In order to access this page you need to log in!');
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}

class _CreateTestTask extends StatelessWidget {
  const _CreateTestTask();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LinTutorOnlyZoneContainer(
      child: Row(
        children: [
          LinButton(
              label: context.loc.createTestTask,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTestTask.path)),
          Expanded(
            child: Text(
              'This option is only for verified teachers, you can submit any task and it will appear in the test after it will be checked.',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall,
            ),
          )
        ],
      ),
    );
  }
}
