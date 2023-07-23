import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/start/components/tab_bar.dart';
import 'package:lingui_quest/start/components/user_widget.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';
import 'package:lingui_quest/view/level_test/level_test_screen.dart';

enum TabBarOption { logo, roadmap, games, planner, level }

class StartPage extends StatefulWidget {
  const StartPage({super.key, required this.changeTheme});
  final Function() changeTheme;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: TabBarOption.values.length, vsync: this);
  }

  void goTo(TabBarOption option) {
    tabController.animateTo(option.index);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: Padding(
          padding: EdgeInsets.all(PaddingConst.small),
          child: InkWell(
            onTap: () => goTo(TabBarOption.logo),
            child: SvgPicture.asset(
              allowDrawingOutsideViewBox: true,
              "assets/logo/logo.svg",
              width: kIsWeb ? 200 : 50,
              height: kIsWeb ? 200 : 50,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: PaddingConst.medium),
            child: const UserAvatarWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(right: PaddingConst.medium),
            child: IconButton(
              icon: Icon(
                isDarkMode ? FeatherIcons.sun : FeatherIcons.moon,
                size: 40,
              ),
              onPressed: widget.changeTheme,
            ),
          ),
          //TODO: Add languages here
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(PaddingConst.medium),
        child: Center(
          child: Row(
            children: [
              if (kIsWeb)
                PreferredSize(
                  preferredSize: Size.fromHeight(size.height - 100),
                  child: RotatedBox(
                      quarterTurns: 3, child: RallyTabBar(tabs: _buildListTabButtons(), tabController: tabController)),
                ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: _buildTabViews(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: !kIsWeb
          ? BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (TabBarOption tab in TabBarOption.values) _buildTabButton(tab),
                  const UserAvatarWidget()
                ],
              ),
            )
          : null,
    );
  }

  List<Widget> _buildTabViews() {
    final List<Widget> list = [];
    for (TabBarOption i in TabBarOption.values) {
      list.add(_buildCurrentTab(i));
    }
    return list;
  }

  Widget _buildCurrentTab(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.games:
        return const Placeholder();
      case TabBarOption.level:
        return const LevelTestScreen();
      case TabBarOption.planner:
        return const Placeholder();
      case TabBarOption.roadmap:
        return const Placeholder();
      case TabBarOption.logo:
        return const HomePage();

      default:
        return const Placeholder();
    }
  }

  List<Widget> _buildListTabButtons() {
    final List<Widget> list = [];
    for (TabBarOption i in TabBarOption.values) {
      list.add(Padding(
        padding: EdgeInsets.all(PaddingConst.medium),
        child: _buildTabButton(i),
      ));
    }
    return list;
  }

  Widget _buildTabButton(TabBarOption tab) {
    ThemeData theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 900;
    switch (tab) {
      case TabBarOption.roadmap:
        return RallyTab(
          theme: theme,
          iconData: FeatherIcons.map,
          tabIndex: tab.index,
          title: context.loc.roadmap.toUpperCase(),
          isVertical: isDesktop,
          tabController: tabController,
        );
      case TabBarOption.planner:
        return RallyTab(
            theme: theme,
            iconData: FeatherIcons.calendar,
            title: context.loc.planner.toUpperCase(),
            tabIndex: tab.index,
            tabController: tabController,
            isVertical: isDesktop);
      case TabBarOption.games:
        return RallyTab(
            theme: theme,
            iconData: FeatherIcons.target,
            title: context.loc.games.toUpperCase(),
            tabIndex: tab.index,
            tabController: tabController,
            isVertical: isDesktop);
      case TabBarOption.level:
        return RallyTab(
            theme: theme,
            iconData: FeatherIcons.star,
            title: context.loc.levelTest.toUpperCase(),
            tabIndex: tab.index,
            tabController: tabController,
            isVertical: isDesktop);

      default:
        return const SizedBox();
    }
  }
}
