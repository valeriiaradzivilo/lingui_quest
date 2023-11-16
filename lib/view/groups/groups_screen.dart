import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.loc.myGroups,
              style: theme.textTheme.displayLarge,
            ),
            LinMainButton(label: context.loc.joinGroup, onTap: () {})
          ],
        ),
        SizedBox(height: PaddingConst.large),
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
              SliverGrid.builder(
                itemBuilder: (_, index) => Container(
                  color: Colors.red,
                  width: 100,
                  height: 200,
                ),
                // separatorBuilder: (_, __) => const VerticalDivider(),
                itemCount: 100,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  // childAspectRatio: 4.0,
                ),
              )
            ],
            body: const SizedBox(),
            // child: Column(
            //   children: [
            //     Row(
            //       children: [Text(context.loc.myGroups), LinMainButton(label: context.loc.joinGroup, onTap: () {})],
            //     ),

            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}
