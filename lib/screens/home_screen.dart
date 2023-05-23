import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_tracker_app/api/client_index.dart';
import 'package:state_tracker_app/blocs/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(api: context.read<StateTracker>())..add(HomeRefresh(0, 10)),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state case HomeError e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => switch (state) {
                HomeLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                HomeData(amendments: final a) => ListView(
                    children: a
                        .map((e) => ListTile(
                              title: Text(e.uid),
                            ))
                        .toList(),
                  ),
                HomeState() => const Center(
                    child: Text("Home"),
                  ),
              }),
    );
  }
}
