import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/bloc/cubit/ticker/ticker_cubit.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/network/repository.dart';
import 'package:flutter_spacex/ui/launch_detail_view.dart';

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
          create: (_) => TickerCubit()..startTicker(),
          child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: const Text('SpaceX'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.refresh,
                    size: 25,
                  ),
                  onPressed: () =>
                      context.read<LaunchesCubit>().refreshLaunches(),
                ),
              ),
              child: const SafeArea(child: LaunchesListView())));
    });
  }
}

class LaunchesListView extends StatefulWidget {
  const LaunchesListView({Key? key}) : super(key: key);

  @override
  _LaunchesListState createState() => _LaunchesListState();
}

class _LaunchesListState extends State<LaunchesListView>
    with WidgetsBindingObserver {

  void gotoLaunch(LaunchModel launchModel) {

    Navigator.of(context)
        .pushNamed("/launch", arguments: LaunchArguments(launchModel)).then((value) => context.read<TickerCubit>().startTicker());
    context.read<TickerCubit>().stopTicker();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<TickerCubit>().startTicker();
        break;
      case AppLifecycleState.paused:
        context.read<TickerCubit>().stopTicker();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final launchesState = context.watch<LaunchesCubit>().state;
    final tickerState = context.watch<TickerCubit>().state;

    switch (launchesState.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return listContent(launchesState.upcomingLaunches!, tickerState.currentUnixTime);
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
              child: launchItem(launches[i], DateTime.now()),
            ));
  }

  Widget launchItem(LaunchModel launchModel, DateTime currentTime) {
    return Builder(builder: (context) {
      return Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                gotoLaunch(launchModel);
              },
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  //color: Colors.orange,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(launchModel.timeLeft(currentTime)),
                        Text("${launchModel.name}"),
                        Text("${launchModel.rocketData?.name}")
                      ]))));
    });
  }
}
