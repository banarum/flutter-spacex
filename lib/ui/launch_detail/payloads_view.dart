import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launch_detail/detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spacex/ui/common/elements.dart';
import 'package:flutter_spacex/ui/common/styles.dart';

const double itemIconSize = 50;
const double itemVerticalPadding = defaultMargin / 2;

class PayloadsView extends StatelessWidget {
  const PayloadsView({Key? key}) : super(key: key);

  Widget payloadItem(PayloadViewModel payload) {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: itemVerticalPadding, top: itemVerticalPadding),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              itemIconView(
                  size: itemIconSize,
                  icon: Image.asset("assets/images/satellite-icon.png")),
              Padding(
                  padding:
                      const EdgeInsets.only(left: itemIconSize + defaultMargin),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(payload.title, style: TextStyles.itemTitle),
                        Text(payload.type, style: TextStyles.itemSubtitle),
                        Text(payload.mass, style: TextStyles.common),
                      ]))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    final launchDetailState = context.watch<LaunchDetailCubit>().state;

    if (launchDetailState.body?.payloads != null) {
      return Padding(
          padding: const EdgeInsets.only(
              top: defaultMargin, right: defaultMargin, left: defaultMargin),
          child: Column(
              children: launchDetailState.body!.payloads!
                  .map((item) => payloadItem(item))
                  .toList()));
    } else {
      return const SizedBox.shrink();
    }
  }
}
