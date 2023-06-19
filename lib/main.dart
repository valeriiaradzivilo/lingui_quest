import 'package:flutter/material.dart';
import 'package:lingui_quest/start/gallery_option.dart';
import 'package:lingui_quest/start/start_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(builder: (_, model, __) {
        return MaterialApp(
          title: 'LinguiQuest',
          theme: GalleryOptionTheme.lightThemeData,
          darkTheme: GalleryOptionTheme.darkThemeData,
          themeMode: model.mode,
          home: StartPage(
            changeTheme: () {
              model.toggleMode();
            },
          ),
        );
      }),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.dark}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
