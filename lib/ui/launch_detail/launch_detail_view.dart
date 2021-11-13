import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';

import 'content_view.dart';

class LaunchDetailView extends StatelessWidget {
  final LaunchHeaderViewModel args;

  const LaunchDetailView({Key? key, required this.args}) : super(key: key);

  Widget screenContent() {
    return Builder(builder: (context) {
      final launchDetailState = context.watch<LaunchDetailCubit>().state;
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(launchDetailState.header.title),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              launchDetailState.header.starred ? Icons.star : Icons.star_border,
              size: 25,
            ),
            onPressed: () => context.read<LaunchDetailCubit>().starLaunch(!launchDetailState.header.starred),
          ),
        ),
        child: const SafeArea(
            child: SingleChildScrollView(child: LaunchDetailContentView())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LaunchDetailCubit(
            repository: context.read<Repository>(), header: args)
          ..getLaunchDetails(),
        child: screenContent());
  }
}
