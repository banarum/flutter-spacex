import 'package:flutter/cupertino.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/ui/common/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksView extends StatelessWidget {
  const LinksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;
    if (launchDetailState.body?.links != null) {
      return Padding(
          padding: defaultItemPadding,
          child: Row(
              children: launchDetailState.body!.links!
                  .map((item) => Padding(
                      padding: EdgeInsets.only(right: defaultMargin),
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                launch(item.link);
                              },
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(item.path))))))
                  .toList()));
    } else {
      return const CupertinoActivityIndicator();
    }
  }
}
