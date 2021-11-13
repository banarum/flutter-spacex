import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/ui/common/elements.dart';
import 'package:flutter_spacex/ui/common/styles.dart';
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
        return failMessageView(
            message: 'Oops something went wrong!',
            onRefresh: () => context.read<LaunchesCubit>().refreshLaunches());
      case ListStatus.success:
        return RefreshIndicator(
            onRefresh: () => context.read<LaunchesCubit>().refreshLaunches(),
            child: listContent());
      default:
        return RefreshIndicator(
            onRefresh: () => context.read<LaunchesCubit>().refreshLaunches(),
            child: Container(
                height: MediaQuery.of(context).size.width,
                width: 400,
                child: const CupertinoActivityIndicator()));
    }
  }

  Widget listContent() {
    return Builder(builder: (context) {
      final launchesState = context.watch<LaunchesCubit>().state;
      return ListView.builder(
          padding: EdgeInsets.only(
              bottom:
                  defaultMargin / 2 + MediaQuery.of(context).padding.bottom),
          itemCount: launchesState.launches!.length,
          itemBuilder: (context, i) => LaunchItemView(
              launch: launchesState.launches![i], onItemTouched: gotoLaunch));
    });
  }
}
