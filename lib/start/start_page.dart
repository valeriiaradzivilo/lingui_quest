import 'package:feather_icons/feather_icons.dart';
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
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
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
                  Container(
                    constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                    padding: EdgeInsets.all(PaddingConst.medium),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
                    child: Wrap(
                      spacing: isDesktop ? PaddingConst.large : PaddingConst.small,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        for (TabBarOption tab in TabBarOption.values) _buildTabButton(tab),
                        const UserAvatarWidget()
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[for (TabBarOption option in TabBarOption.values) _buildCurrentTab(option)],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildCurrentTab(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.logo:
        return const HomePage();
      case TabBarOption.games:
        return const Placeholder();
      case TabBarOption.level:
        return const Placeholder();
      case TabBarOption.planner:
        return const Placeholder();
      case TabBarOption.roadmap:
        return const Placeholder();

      default:
        return const Placeholder();
    }
  }

  Widget _buildTabButton(TabBarOption tab) {
    switch (tab) {
      case TabBarOption.logo:
        return InkWell(
          onTap: () {
            goTo(tab);
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: SvgPicture.asset(
              allowDrawingOutsideViewBox: true,
              "assets/logo/logo.svg",
              width: 100,
              height: 100,
            ),
          ),
        );
      case TabBarOption.roadmap:
        return LinMainButton(
          label: context.loc.roadmap.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.planner:
        return LinMainButton(
          label: context.loc.planner.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.games:
        return LinMainButton(
          label: context.loc.games.toUpperCase(),
          onTap: () {
            goTo(tab);
          },
        );
      case TabBarOption.level:
        return LinMainButton(
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
