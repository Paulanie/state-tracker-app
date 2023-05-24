import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:state_tracker_app/api/client_index.dart';
import 'package:state_tracker_app/blocs/theme/theme_cubit.dart';
import 'package:state_tracker_app/main.dart';
import 'package:state_tracker_app/screens/home_screen.dart';
import 'package:state_tracker_app/screens/settings_screen.dart';

class RouteEntry {}

final routes = {
  "/": (
    "Home",
    Icons.home,
    (BuildContext context, GoRouterState state) => HomeScreen(
          key: state.pageKey,
        )
  ),
  "/settings": (
    "Settings",
    Icons.settings,
    (context, state) => SettingsScreen(
          key: state.pageKey,
        )
  )
};

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// GoRouter configuration
final router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: "/", routes: [
  ShellRoute(
    builder: (context, state, child) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        RepositoryProvider(
            create: (context) => StateTracker.create(
                baseUrl: Uri(host: "57.128.113.152", scheme: "http")))
      ],
      child: NavigatorScaffold(child: child),
    ),
    routes: routes.entries
        .map((e) => GoRoute(path: e.key, builder: e.value.$3, name: e.value.$1))
        .toList(),
  )
]);

class NavigatorScaffold extends StatelessWidget {
  final Widget child;

  const NavigatorScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
                value: context.read<ThemeCubit>().state,
                onChanged: (value) {
                  MyApp.themeNotifier.value =
                      value ? ThemeMode.light : ThemeMode.dark;
                  context.read<ThemeCubit>().toggle(value);
                })
          ],
          title: Text("StateTracker"),
          elevation: 10,
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: IntrinsicWidth(
                      child: Wrap(
                        spacing: 20.0,
                        children: routes.entries
                            .mapIndexed(
                                (index, e) => _buildMenuTile(context, index, e))
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ));
  }

  ListTile _buildMenuTile(BuildContext context, int index, element) {
    return ListTile(
      title: Text(element.value.$1),
      leading: Icon(element.value.$2),
      selected: GoRouter.of(context).location == element.key,
      selectedTileColor: Theme.of(context).secondaryHeaderColor,
      hoverColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      onTap: () {
        context.go(element.key);
      },
    );
  }
}
