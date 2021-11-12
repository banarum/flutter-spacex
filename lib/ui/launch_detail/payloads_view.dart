import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayloadsView extends StatelessWidget {

  const PayloadsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;

    if (launchDetailState.body?.payloads != null) {
      return Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text("Payloads")),
        Column(
            children: launchDetailState.body!.payloads!
                .map((item) => Padding(padding: EdgeInsets.only(bottom: 10), child: Column(children: [
              Text(item.title),
              Text(item.type),
              Text(item.mass),
            ])))
                .toList())
      ]);
    } else {
      return const SizedBox.shrink();
    }
  }
}