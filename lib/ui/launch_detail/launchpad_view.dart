import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/ui/common/styles.dart';

class LaunchpadView extends StatelessWidget {
  const LaunchpadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;
    if (launchDetailState.body?.launchpad != null) {
      return Padding(
          padding: defaultItemPadding,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: defaultMargin),
                child: Text(launchDetailState.body!.launchpad!.title,
                    style: TextStyles.title),
              ),
              SizedBox(
                  child: launchDetailState.body?.launchpad?.imageUrl != null
                      ? Image.network(
                          launchDetailState.body!.launchpad!.imageUrl!,
                          fit: BoxFit.cover)
                      : const SizedBox.shrink())
            ],
          ));
    } else {
      return const SizedBox.shrink();
    }
  }
}
