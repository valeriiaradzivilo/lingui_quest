import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hive/hive.dart';
import 'package:lingui_quest/data/firebase/firebase_options.dart';
import 'package:lingui_quest/start/di.dart';
import 'package:lingui_quest/start/gallery_option.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/start/start_page.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:lingui_quest/view/sign_in_page/sign_in_page.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:lingui_quest/view/sign_up_page/sign_up_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();
  Hive.init(null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (_) => serviceLocator<SignInCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => serviceLocator<SignUpCubit>()),
      ],
      child: ChangeNotifierProvider<ThemeModel>(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(builder: (_, model, __) {
          return Portal(
              child: MaterialApp(
            title: 'LinguiQuest',
            theme: GalleryOptionTheme.lightThemeData,
            darkTheme: GalleryOptionTheme.darkThemeData,
            themeMode: model.mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: '/',
            routes: _routes(model),
          ));
        }),
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> _routes(ThemeModel model) {
    return {
      AppRoutes.initial: (context) => StartPage(
            changeTheme: () {
              model.toggleMode();
            },
          ),
      AppRoutes.signIn: (context) => const SignInPage(),
      AppRoutes.signUp: (context) => const SignUpPage(),
    };
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
