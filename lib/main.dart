import 'package:flutter/material.dart';
import 'package:lingui_quest/start/gallery_option.dart';
import 'package:lingui_quest/start/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: GalleryOptionTheme.lightThemeData,
      darkTheme: GalleryOptionTheme.darkThemeData,
      home: const StartPage(),
    );
  }
}
