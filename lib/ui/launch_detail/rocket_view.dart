import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RocketView extends StatelessWidget {
  const RocketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;
    if (launchDetailState.body?.rocket != null) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(launchDetailState.body!.rocket!.title),
          ),
          SizedBox(
              child: launchDetailState.body?.rocket?.imageUrl != null
                  ? Image.network(launchDetailState.body!.rocket!.imageUrl!,
                      fit: BoxFit.cover)
                  : const SizedBox.shrink()),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(launchDetailState.body!.rocket!.description),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
