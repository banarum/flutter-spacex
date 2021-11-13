import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/network/repository.dart';
import 'package:flutter_spacex/ui/common/elements.dart';
import 'package:flutter_spacex/ui/launch_detail/launchpad_view.dart';
import 'package:flutter_spacex/ui/launch_detail/links_view.dart';
import 'package:flutter_spacex/ui/launch_detail/payloads_view.dart';
import 'package:flutter_spacex/ui/launch_detail/rocket_view.dart';

class LaunchDetailContentView extends StatelessWidget {

  const LaunchDetailContentView({Key? key}) : super(key: key);

  Widget launchItemScreen() {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      children: const [
        PayloadsView(),
        LaunchpadView(),
        RocketView(),
        LinksView(),
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    final launchesState = context.watch<LaunchDetailCubit>().state;

    switch (launchesState.status) {
      case ScreenStatus.failure:
        return failMessageView(
            message: 'Oops something went wrong!',
            onRefresh: () => context.read<LaunchDetailCubit>().getLaunchDetails());
      case ScreenStatus.success:
        return launchItemScreen();
      default:
        return const Center(
          child: CupertinoActivityIndicator(),
        );
    }
  }
}
