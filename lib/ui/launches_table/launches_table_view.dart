import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/network/repository.dart';

import 'list_view.dart';

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
      final launchesState = context.watch<LaunchesCubit>().state;
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('SpaceX'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                launchesState.filter == FilterType.star
                    ? Icons.star
                    : Icons.star_border,
                size: 25,
              ),
              onPressed: () => context.read<LaunchesCubit>().setFilter(
                  launchesState.filter == FilterType.star
                      ? FilterType.none
                      : FilterType.star),
            ),
          ),
          child: const SafeArea(
            child: LaunchesListView(),
            bottom: false,
          ));
    });
  }
}
