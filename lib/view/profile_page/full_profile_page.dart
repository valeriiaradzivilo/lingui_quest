import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/data/models/user_model.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';
import 'package:lingui_quest/shared/widgets/lin_round_photo.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';

class FullProfilePage extends StatelessWidget {
  const FullProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<StartCubit, StartState>(builder: (context, state) {
          if (state.currentUser != UserModel.empty()) {
            return Padding(
              padding: EdgeInsets.all(PaddingConst.large),
              child: Container(
                padding: EdgeInsets.all(PaddingConst.medium),
                decoration: BoxDecoration(
                    border: Border.all(color: theme.highlightColor), borderRadius: BorderRadius.circular(20)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    LinRoundPhoto(
                        onTap: null,
                        child: Text(
                          state.currentUser.firstName.substring(0, 1).toUpperCase() +
                              state.currentUser.lastName.substring(0, 1).toUpperCase(),
                        )),
                    Text('Username: ${state.currentUser.username}'),
                    Text('Email: ${state.currentUser.email}'),
                    Text('Level: ${state.currentUser.level.levelName} (${state.currentUser.level.name})'),
                  ],
                ),
              ),
            );
          } else {
            return const Text('You are not logged in');
          }
        }),
      ),
    );
  }
}
