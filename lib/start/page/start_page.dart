import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/components/home_icon_button.dart';
import 'package:lingui_quest/start/components/join_requests_alert_dialog.dart';
import 'package:lingui_quest/start/components/tab_bar.dart';
import 'package:lingui_quest/start/components/user_widget.dart';
import 'package:lingui_quest/view/games_page/games_list/games_list_page.dart';
import 'package:lingui_quest/view/groups/all_groups/groups_screen.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';
import 'package:lingui_quest/view/level_test/main_info_screen/level_test_screen.dart';
import 'package:rx_widgets/rx_widgets.dart';

enum TabBarOption {
  // roadmap,
  games,
  groups,
  level,
  // searchTutor,
}

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
    tabController = TabController(initialIndex: 0, length: TabBarOption.values.length + 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final StartCubit bloc = BlocProvider.of<StartCubit>(context);
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return DefaultTabController(
        length: TabBarOption.values.length + 1,
        child: BlocConsumer<StartCubit, StartState>(
            bloc: bloc..init(),
            listener: (context, state) {
              if (state.status == StartStatus.initial) {
                tabController.animateTo(state.currentTab.index);
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 60,
                  leading: HomeIconButton(onTap: () => tabController.animateTo(TabBarOption.values.length)),
                  actions: [
                    if (state.currentUser.isTutor)
                      Padding(
                        padding: EdgeInsets.all(PaddingConst.medium),
                        child: ReactiveWidget(
                          stream: state.joinRequests,
                          widget: (requests) => Badge.count(
                            count: requests.length,
                            offset: Offset(-10, 0),
                            isLabelVisible: requests.isNotEmpty,
                            child: Padding(
                                padding: EdgeInsets.only(right: PaddingConst.medium),
                                child: IconButton(
                                  icon: Icon(FeatherIcons.bell),
                                  onPressed: () => showDialog(
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => JoinRequestsAlertDialog(
                                            requests: requests,
                                          )),
                                )),
                          ),
                        ),
                      ),
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
                  ],
                ),
                body: SafeArea(
                  minimum: EdgeInsets.all(PaddingConst.medium),
                  child: Center(
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (state.status == StartStatus.initial) {
                        if (kIsWeb && isDesktop) {
                          return Row(
                            children: [
                              PreferredSize(
                                preferredSize: Size.fromHeight(size.height - 100),
                                child: RotatedBox(
                                    quarterTurns: 3,
                                    child: RallyTabBar(tabs: _buildListTabButtons(), tabController: tabController)),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  children: _buildTabViews(),
                                ),
                              ),
                            ],
                          );
                        }
                        // else if (kIsWeb) {
                        //   return Column(
                        //     children: [
                        //       Expanded(
                        //         child: TabBarView(
                        //           controller: tabController,
                        //           children: _buildTabViews(),
                        //         ),
                        //       ),
                        //       PreferredSize(
                        //         preferredSize: Size.fromHeight(size.width - 100),
                        //         child: RallyTabBar(tabs: _buildListTabButtons(), tabController: tabController),
                        //       ),
                        //     ],
                        //   );
                        // }
                        else {
                          return TabBarView(
                            controller: tabController,
                            children: _buildTabViews(),
                          );
                        }
                      } else if (state.status == StartStatus.error) {
                        return const Text('Error');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                  ),
                ),
                bottomNavigationBar: !isDesktop
                    ? BottomAppBar(
                        elevation: PaddingConst.immense,
                        color: Theme.of(context).cardColor,
                        child: Center(child: RallyTabBar(tabs: _buildListTabButtons(), tabController: tabController)),
                      )
                    : null,
              );
            }));
  }

  List<Widget> _buildTabViews() {
    final List<Widget> list = [];
    for (TabBarOption i in TabBarOption.values) {
      list.add(_buildCurrentTab(i));
    }
    list.add(const HomePage());
    return list;
  }

  Widget _buildCurrentTab(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.games:
        return const GamesListScreen();
      case TabBarOption.level:
        return const LevelTestScreen();
      case TabBarOption.groups:
        return const GroupsScreen();
      // case TabBarOption.roadmap:
      //   return const Placeholder();
      // case TabBarOption.searchTutor:
      //   return const TutorSearch();
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
    list.add(const SizedBox());
    return list;
  }

  Widget _buildTabButton(TabBarOption tab) {
    ThemeData theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 600;
    switch (tab) {
      // case TabBarOption.roadmap:
      //   return RallyTab(
      //     theme: theme,
      //     iconData: FeatherIcons.map,
      //     tabIndex: tab.index,
      //     title: context.loc.roadmap.toUpperCase(),
      //     isVertical: isDesktop,
      //     tabController: tabController,
      //   );
      case TabBarOption.groups:
        return RallyTab(
            theme: theme,
            iconData: FeatherIcons.users,
            title: context.loc.groups.toUpperCase(),
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

      // case TabBarOption.searchTutor:
      //   return RallyTab(
      //       theme: theme,
      //       iconData: FeatherIcons.search,
      //       title: context.loc.searchTutor.toUpperCase(),
      //       tabIndex: tab.index,
      //       tabController: tabController,
      //       isVertical: isDesktop);
    }
  }
}
