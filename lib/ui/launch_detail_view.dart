import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';

class LaunchDetailView extends StatelessWidget {
  final LaunchArguments args;

  const LaunchDetailView({Key? key, required this.args}) : super(key: key);

  Widget launchpadColumn() {
    return Builder(builder: (context) {
      final launchDetailState = context.watch<LaunchDetailCubit>().state;
      if (launchDetailState.launchpad != null) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(launchDetailState.launchpad!.title),
            ),
            Image.network(launchDetailState.launchpad!.url),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget linksRow() {
    return Builder(builder: (context) {
      final launchDetailState = context.watch<LaunchDetailCubit>().state;
      if (launchDetailState.links != null) {
        return Row(
            children: launchDetailState.links!
                .map((item) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          print(item.link);
                        },
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(item.path)))))
                .toList());
      } else {
        return const CupertinoActivityIndicator();
      }
    });
  }

  Widget launchItemScreen() {
    return Center(
        child: Column(
      children: [launchpadColumn(), linksRow()],
    ));
  }

  Widget screenContent() {
    return Builder(builder: (context) {
      final launchesState = context.watch<LaunchDetailCubit>().state;

      switch (launchesState.status) {
        case ScreenStatus.failure:
          return const Center(child: Text('Oops something went wrong!'));
        case ScreenStatus.success:
          return launchItemScreen();
        default:
          return const Center(
            child: CupertinoActivityIndicator(),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LaunchDetailCubit(repository: context.read<Repository>())
          ..getLaunchDetails(args.launchId),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(args.title),
          ),
          child: SafeArea(child: screenContent()),
        ));
  }
}

class LaunchArguments {
  final String title;
  final String launchId;

  LaunchArguments({required this.title, required this.launchId});
}
