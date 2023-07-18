import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/components/user_widget.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';

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
    tabController = TabController(
        initialIndex: 0, length: TabBarOption.values.length, vsync: this);
  }

  void goTo(TabBarOption option) {
    tabController.animateTo(option.index);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final StartCubit bloc = BlocProvider.of<StartCubit>(context);
    return BlocBuilder<StartCubit, StartState>(
        bloc: bloc..checkIfUserLoggedIn(),
        builder: (context, state) {
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
                    width: kIsWeb ? 100 : 50,
                    height: kIsWeb ? 100 : 50,
                  ),
                ),
              ),
              actions: [
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
            body: Center(
              child: Column(
                children: [
                  if (kIsWeb)
                    Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width),
                      padding: EdgeInsets.all(PaddingConst.medium),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Wrap(
                        spacing:
                            isDesktop ? PaddingConst.large : PaddingConst.small,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: [
                          for (TabBarOption tab in TabBarOption.values)
                            _buildTabButton(tab),
                          const UserAvatarWidget()
                        ],
                      ),
                    ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        for (TabBarOption option in TabBarOption.values)
                          _buildCurrentTab(option)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: !kIsWeb
                ? BottomAppBar(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (TabBarOption tab in TabBarOption.values)
                          _buildTabButton(tab),
                        const UserAvatarWidget()
                      ],
                    ),
                  )
                : null,
          );
        });
  }

  Widget _buildCurrentTab(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.games:
        return const Placeholder();
      case TabBarOption.level:
        return const Placeholder();
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

  Widget _buildTabButton(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.roadmap:
        return LinMainButton(
          icon: FeatherIcons.map,
          label: context.loc.roadmap.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.planner:
        return LinMainButton(
          icon: FeatherIcons.calendar,
          label: context.loc.planner.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.games:
        return LinMainButton(
          icon: FeatherIcons.target,
          label: context.loc.games.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.level:
        return LinMainButton(
          icon: FeatherIcons.star,
          label: context.loc.levelTest.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );

      default:
        return const SizedBox();
    }
  }
}
