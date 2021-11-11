import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
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
          ..refreshLaunches()
          ..startTicker(),
        child: screenContent());
  }

  // Let's put screen content here so Bloc could be properly initialized by this point
  Widget screenContent() {
    return Builder(builder: (context) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('SpaceX'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.refresh,
                size: 25,
              ),
              onPressed: () => context.read<LaunchesCubit>()
                ..refreshLaunches()
                ..startTicker(),
            ),
          ),
          child: const SafeArea(child: LaunchesListView()));
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
  void gotoLaunch(LaunchItemViewState launch) {
    Navigator.of(context)
        .pushNamed("/launch", arguments: LaunchArguments(title: launch.title, launchId: launch.launchId))
        .then((value) => context.read<LaunchesCubit>().startTicker());
    context.read<LaunchesCubit>().stopTicker();
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _controller = ScrollController()..addListener(_scrollListener);
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
        context.read<LaunchesCubit>().startTicker();
        break;
      case AppLifecycleState.paused:
        context.read<LaunchesCubit>().stopTicker();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final launchesState = context.watch<LaunchesCubit>().state;

    switch (launchesState.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return listContent();
      default:
        return const Center(
          child: CupertinoActivityIndicator(),
        );
    }
  }

  void _scrollListener() {
    if (_controller.position.extentAfter < 100) {
      context.read<LaunchesCubit>().lazyLoadMoreLaunches();
    }
  }

  Widget listContent() {
    return Builder(builder: (context) {
      final launchesState = context.watch<LaunchesCubit>().state;
      return ListView.builder(
          itemCount: launchesState.launches!.length +
              (launchesState.isLazyLoading ? 1 : 0),
          controller: _controller,
          itemBuilder: (context, i) => Container(
                child: i < launchesState.launches!.length
                    ? launchItem(launchesState.launches![i])
                    : const CupertinoActivityIndicator(),
              ));
    });
  }

  Widget launchItem(LaunchItemViewState launch) {
    return Builder(builder: (context) {
      return Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                gotoLaunch(launch);
              },
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  //color: Colors.orange,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(launch.timeLabel),
                        Text(launch.title),
                        Text(launch.rocketName)
                      ]))));
    });
  }
}
