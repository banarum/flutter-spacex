import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/bloc/cubit/launches/launches_cubit.dart';

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
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Stack(children: [
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: launch.patchUrl != null
                              ? Image.network(launch.patchUrl!)
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                )),
                      Padding(
                          padding: EdgeInsets.only(left: 50 + 10),
                          child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(launch.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start),
                                Text(launch.rocketName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start),
                                Text(launch.timeLabel,
                                    textAlign: TextAlign.start),
                              ])),
                      Align(
                        child: Icon(
                            launch.starred ? Icons.star : Icons.star_border,
                            size: 24),
                        alignment: Alignment.centerRight,
                      )
                    ])))));
  }
}
