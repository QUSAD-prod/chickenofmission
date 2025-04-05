import 'package:chickenofmission/core/const/colors.dart';
import 'package:chickenofmission/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter();
    GetIt.I.registerSingleton(_appRouter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '2048',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Araside',
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
