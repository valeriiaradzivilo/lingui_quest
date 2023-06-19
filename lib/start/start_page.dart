import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/widgets/lin_language_widget.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_round_photo.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  late final TabController tabController;
  int currentTab = 0;
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        FeatherIcons.home,
                      ),
                      onPressed: () {
                        goTo(0);
                      },
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
                    LinRoundPhoto(
                      onTap: () {},
                      radius: 40,
                    ),
                    const LinLanguage(),
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
      ),
    );
  }
}
