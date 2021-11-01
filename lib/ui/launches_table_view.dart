import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/bloc/cubit/ticker/ticker_cubit.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';

class LaunchTableView extends StatelessWidget {
  const LaunchTableView({Key? key}) : super(key: key);

  // Inject Bloc here
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LaunchesCubit(repository: context.read<Repository>())
          ..refreshLaunches(),
        child: screenContent());
  }

  // Let's put screen content here so Bloc could be properly initialized by this point
  Widget screenContent() {
    return Builder(builder: (context) {
      return BlocProvider(
          create: (_) => TickerCubit()
        ..startTicker(),
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('SpaceX'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.refresh,
                size: 25,
              ),
              onPressed: () => context.read<LaunchesCubit>().refreshLaunches(),
            ),
          ),
          child: const LaunchesListView()));
    });
  }
}

class LaunchesListView extends StatelessWidget {
  const LaunchesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchesState = context.watch<LaunchesCubit>().state;
    final tickerState = context.watch<TickerCubit>().state;

    switch (launchesState.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return listContent(launchesState.items, tickerState.currentUnixTime);
      default:
        return const Center(
          child: CupertinoActivityIndicator(),
        );
    }
  }

  Widget listContent(List<LaunchModel> launches, int currentUnixTime) {
    return ListView.builder(
        itemCount: launches.length,
        itemBuilder: (context, i) => Container(
              child: launchItem(launches[i], currentUnixTime),
            ));
  }

  Widget launchItem(LaunchModel launchModel, int currentUnixTime) {
    return Builder(builder: (context) {
      return Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                context.read<TickerCubit>().startTicker();
              },
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  //color: Colors.orange,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(launchModel.timeLeft(currentUnixTime)),
                        Text("${launchModel.name}"),
                        Text("${launchModel.rocketData?.name}")
                      ]))));
    });
  }
}
