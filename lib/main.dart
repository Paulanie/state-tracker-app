import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:state_tracker_app/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, mode, __) => MaterialApp.router(
              title: 'State Tracker',
              theme: FlexThemeData.light(scheme: FlexScheme.blueM3),
              darkTheme: FlexThemeData.dark(scheme: FlexScheme.blueM3),
              themeMode: mode,
              routerConfig: router,
            ));
  }
}
