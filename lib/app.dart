

import 'package:flutter/material.dart';
import 'package:sofico_task/res/app_theme.dart';
import 'package:sofico_task/routes/router.dart';

class App extends StatelessWidget {
  final AppRouter router;
  const App({Key? key , required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      onGenerateRoute: router.generateRoute,
      // routes: routes,
    );
  }
}