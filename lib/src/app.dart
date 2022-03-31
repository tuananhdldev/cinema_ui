import 'package:flutter/material.dart';
import 'package:move_app/src/pages/movie_page.dart';
import 'core/constants/app_theme.dart';
import 'core/constants/constants.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.light,
      home: const MoviePages(),
    );
  }
}
