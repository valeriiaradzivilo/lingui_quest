import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:lingui_quest/data/firebase_options.dart';
import 'package:lingui_quest/l10n/app_localizations.dart';
import 'package:lingui_quest/start/gallery_option.dart';
import 'package:lingui_quest/start/start_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(builder: (_, model, __) {
        return Portal(
            child: MaterialApp(
          title: 'LinguiQuest',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: GalleryOptionTheme.lightThemeData,
          darkTheme: GalleryOptionTheme.darkThemeData,
          themeMode: model.mode,
          home: StartPage(
            changeTheme: () {
              model.toggleMode();
            },
          ),
        ));
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
