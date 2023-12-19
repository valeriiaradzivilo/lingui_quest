import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/page/start_page.dart';

const int tabCount = 5;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class RallyTabBar extends StatelessWidget {
  const RallyTabBar({super.key, required this.tabs, required this.tabController});

  final List<Widget> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StartCubit>(context);
    return TabBar(
      // Setting isScrollable to true prevents the tabs from being
      // wrapped in [Expanded] widgets, which allows for more
      // flexible sizes and size animations among tabs.
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      tabs: tabs,
      controller: tabController,
      tabAlignment: TabAlignment.center,
      // This hides the tab indicator.
      indicatorColor: Colors.transparent,
      onTap: (value) {
        bloc.setTabOption(TabBarOption.values[value]);
      },
    );
  }
}

class RallyTab extends StatelessWidget {
  RallyTab({
    super.key,
    required ThemeData theme,
    required IconData iconData,
    required String title,
    required int tabIndex,
    required TabController tabController,
    required this.isVertical,
  })  : titleText = Text(title, style: theme.textTheme.labelLarge),
        isExpanded = tabController.index == tabIndex,
        icon = Icon(iconData, semanticLabel: title);

  final Text titleText;
  final Icon icon;
  final bool isExpanded;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return RotatedBox(
        quarterTurns: 1,
        child: Column(
          children: [
            icon,
            SizedBox(
              height: PaddingConst.medium,
            ),
            titleText,
          ],
        ),
      );
    } else {
      final width = MediaQuery.of(context).size.width;
      const expandedTitleWidthMultiplier = 2;
      final unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

      return ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: unitWidth,
              child: icon,
            ),
          ],
        ),
      );
    }
  }
}
