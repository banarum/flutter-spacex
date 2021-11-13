import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/ui/common/styles.dart';

class RocketView extends StatelessWidget {
  const RocketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;
    if (launchDetailState.body?.rocket != null) {
      return Padding(padding: defaultItemPadding, child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultMargin),
            child: Text(launchDetailState.body!.rocket!.title, style: TextStyles.title),
          ),
          SizedBox(
              child: launchDetailState.body?.rocket?.imageUrl != null
                  ? Image.network(launchDetailState.body!.rocket!.imageUrl!,
                      fit: BoxFit.cover)
                  : const SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.only(top: defaultMargin),
            child: Text(launchDetailState.body!.rocket!.description, style: TextStyles.common),
          ),
        ],
      ));
    } else {
      return const SizedBox.shrink();
    }
  }
}
