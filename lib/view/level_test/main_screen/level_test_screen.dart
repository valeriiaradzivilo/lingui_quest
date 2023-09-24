import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/view/level_test/main_screen/bloc/level_test_bloc.dart';

class LevelTestScreen extends StatelessWidget {
  const LevelTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LevelTestBloc bloc = BlocProvider.of<LevelTestBloc>(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(PaddingConst.medium),
        child: BlocConsumer<LevelTestBloc, LevelTestState>(
            bloc: bloc..getCurrentUser(),
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == LevelTestStatus.initial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state.currentUser.isTeacher) ...[
                      LinButton(
                          label: context.loc.createTestTask,
                          onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTestTask)),
                      const Text(
                        'This option is only for verified teachers, you can submit any task and it will appear in the test after it will be checked.',
                        textAlign: TextAlign.center,
                      )
                    ],
                    Padding(
                      padding: EdgeInsets.all(PaddingConst.large),
                      child: LinMainButton(
                          label: context.loc.startTest, onTap: () => Navigator.of(context).pushNamed(AppRoutes.test)),
                    )
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
    );
  }
}
