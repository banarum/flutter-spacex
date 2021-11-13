import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';
import 'package:flutter_spacex/ui/common/elements.dart';
import 'package:flutter_spacex/ui/common/styles.dart';

const double itemIconSize = 50;
const double iconSize = 24;
const double itemVerticalPadding = defaultMargin / 2;

class LaunchItemView extends StatelessWidget {
  const LaunchItemView(
      {Key? key, required this.launch, required this.onItemTouched})
      : super(key: key);

  final LaunchItemViewState launch;
  final void Function(LaunchItemViewState) onItemTouched;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              onItemTouched(launch);
            },
            child: Container(
                padding: const EdgeInsets.only(
                    top: itemVerticalPadding, bottom: itemVerticalPadding),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: defaultMargin, right: defaultMargin),
                    child: Stack(children: [
                      itemIconView(
                          size: itemIconSize,
                          icon: (launch.patchUrl != null
                              ? Image.network(launch.patchUrl!)
                              : null)),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: itemIconSize + defaultMargin, right: iconSize),
                          child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(launch.title,
                                    style: TextStyles.itemTitle,
                                    textAlign: TextAlign.start),
                                Text(launch.rocketName,
                                    style: TextStyles.itemSubtitle,
                                    textAlign: TextAlign.start),
                                Text(
                                  launch.timeLabel,
                                  textAlign: TextAlign.start,
                                  style: TextStyles.common,
                                ),
                              ])),
                      Align(
                        child: Icon(
                            launch.starred ? Icons.star : Icons.star_border,
                            size: iconSize),
                        alignment: Alignment.centerRight,
                      )
                    ])))));
  }
}
