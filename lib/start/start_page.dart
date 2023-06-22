import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_round_photo.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key, required this.changeTheme});
  final Function() changeTheme;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late final TabController tabController;
  int currentTab = 0;
  bool _clikedOnAvatar = false;
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  void goTo(int index) {
    tabController.animateTo(index);
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              padding: EdgeInsets.all(PaddingConst.medium),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
              child: Wrap(
                spacing: PaddingConst.large,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  // IconButton(
                  //   icon: const Icon(
                  //     FeatherIcons.home,
                  //     size: 40,
                  //   ),
                  //   onPressed: () {
                  //     goTo(0);
                  //   },
                  // ),
                  InkWell(
                    onTap: () {
                      goTo(0);
                    },
                    child: Image.asset(
                      "assets/logo/logo.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                  LinMainButton(
                    label: 'ROADMAP',
                    onTap: () {
                      goTo(1);
                    },
                  ),
                  LinMainButton(
                    label: 'GAMES',
                    onTap: () {
                      goTo(2);
                    },
                  ),
                  LinMainButton(
                    label: 'PLANNER',
                    onTap: () {
                      goTo(3);
                    },
                  ),
                  LinMainButton(
                    label: 'LEVEL TEST',
                    onTap: () {
                      goTo(3);
                    },
                  ),
                  PortalTarget(
                    visible: _clikedOnAvatar,
                    anchor: const Aligned(
                        follower: Alignment.topLeft, target: Alignment.bottomCenter, offset: Offset(0, -5)),
                    portalFollower: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: LinButton(
                        label: 'Sign in',
                        onTap: () {},
                      ),
                    ),
                    child: LinRoundPhoto(
                      onTap: () {
                        setState(() {
                          _clikedOnAvatar = !_clikedOnAvatar;
                        });
                      },
                      radius: 40,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDarkMode ? FeatherIcons.sun : FeatherIcons.moon,
                      size: 40,
                    ),
                    onPressed: widget.changeTheme,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const <Widget>[
                  HomePage(),
                  Placeholder(),
                  Placeholder(),
                  Placeholder(),
                  Placeholder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
