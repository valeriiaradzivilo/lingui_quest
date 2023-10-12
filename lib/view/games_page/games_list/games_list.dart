import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/view/games_page/games_list/bloc/games_bloc.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GameBloc>(context);
    return SingleChildScrollView(
      child: Column(
        children: [LinMainButton(label: context.loc.createGame, onTap: () => bloc.add(AddNewGame()))],
      ),
    );
  }
}
