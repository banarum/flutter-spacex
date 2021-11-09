import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/network/models.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';

class LaunchDetailView extends StatelessWidget {
  final LaunchArguments args;

  const LaunchDetailView({Key? key, required this.args}) : super(key: key);

  Widget launchpadColumn(LaunchpadModel launchpad) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(launchpad.locality),
        ),
        Image.network(launchpad.images.large![0]),
      ],
    );
  }

  Widget linksRow(LinksModel linksData) {
    final List<LinkButton> links = [];

    if (linksData.reddit?.campaign != null) {
      links.add(LinkButton(
          linksData.reddit!.campaign!, "assets/images/reddit-logo.png"));
    }

    if (linksData.wikipedia != null) {
      links.add(
          LinkButton(linksData.wikipedia!, "assets/images/wikipedia-logo.png"));
    }

    return Row(
        children: links
            .map((item) => Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                      print(item.link);
                    },
                    child: Container(
                        width: 50, height: 50, child: Image.asset(item.path)))))
            .toList());
  }

  Widget launchItemScreen(LaunchModel launchModel) {
    return Center(
        child: Column(
      children: [
        launchpadColumn(launchModel.launchpadData!),
        linksRow(launchModel.links)
      ],
    ));
  }

  Widget screenContent() {
    return Builder(builder: (context) {
      final launchesState = context.watch<LaunchesCubit>().state;

      switch (launchesState.status) {
        case ListStatus.failure:
          return const Center(child: Text('Oops something went wrong!'));
        case ListStatus.success:
          final detailedLaunchModel = launchesState.detailedLaunchModel!;
          return launchItemScreen(detailedLaunchModel);
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
        create: (_) => LaunchesCubit(repository: context.read<Repository>())
          ..getLaunchDetails(args.launchModel.id),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(args.launchModel.name ?? ""),
          ),
          child: SafeArea(child: screenContent()),
        ));
  }
}

class LaunchArguments {
  final LaunchModel launchModel;

  LaunchArguments(this.launchModel);
}

class LinkButton {
  final String link;
  final String path;

  LinkButton(this.link, this.path);
}
