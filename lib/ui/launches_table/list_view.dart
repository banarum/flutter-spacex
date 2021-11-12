import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/ui/launch_detail/launch_detail_view.dart';
import 'package:flutter_spacex/ui/launches_table/launch_item_view.dart';

class LaunchesListView extends StatefulWidget {
  const LaunchesListView({Key? key}) : super(key: key);

  @override
  _LaunchesListState createState() => _LaunchesListState();
}

class _LaunchesListState extends State<LaunchesListView>
    with WidgetsBindingObserver {
  void gotoLaunch(LaunchItemViewState launch) {
    Navigator.of(context)
        .pushNamed("/launch",
            arguments: LaunchHeaderViewModel(
                title: launch.title,
                launchId: launch.launchId,
                starred: launch.starred))
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
                    ? LaunchItemView(
                        launch: launchesState.launches![i],
                        onItemTouched: gotoLaunch)
                    : const CupertinoActivityIndicator(),
              ));
    });
  }
}
