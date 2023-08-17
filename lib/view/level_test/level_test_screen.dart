import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/view/level_test/bloc/level_test_bloc.dart';

import '../../logic/level_test_logic/level_test_tree.dart';

class LevelTestScreen extends StatelessWidget {
  const LevelTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LevelTestBloc bloc = BlocProvider.of<LevelTestBloc>(context);
    return BlocConsumer<LevelTestBloc, LevelTestState>(
        bloc: bloc..add(ReadAllTasks()),
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == LevelTestStatus.initial) {
            return Column(
              children: [
                LinMainButton(
                    label: context.loc.createTestTask,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.createTestTask)),
                StreamBuilder(
                    stream: state.testsData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          startTree(snapshot.data!);
                        }
                        return Column(
                          children: [
                            Text('Current amount of tasks: ${snapshot.data?.length}'),
                            for (final EnglishLevel level in EnglishLevel.values)
                              Text(
                                  '${level.name}: ${snapshot.data?.where((element) => element.level.toUpperCase() == level.name.toUpperCase()).length}'),
                          ],
                        );
                      }
                      return const SizedBox();
                    })
              ],
            );
          } else if (state.status == LevelTestStatus.error) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
