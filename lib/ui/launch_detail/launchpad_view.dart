import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchpadView extends StatelessWidget {
  const LaunchpadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;
    if (launchDetailState.body?.launchpad != null) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(launchDetailState.body!.launchpad!.title),
          ),
          SizedBox(
              child: launchDetailState.body?.launchpad?.imageUrl != null
                  ? Image.network(launchDetailState.body!.launchpad!.imageUrl!,
                  fit: BoxFit.cover)
                  : const SizedBox.shrink())
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
