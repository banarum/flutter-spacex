import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spacex/ui/common/styles.dart';

Widget itemIconView({required double size, required Widget? icon}) {
  return SizedBox(
      width: size,
      height: size,
      child: icon ?? Container(
        decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle),
      ));
}

Widget failMessageView(
    {required String message, required void Function() onRefresh}) {
  return Padding(
      padding: const EdgeInsets.all(defaultMargin),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(children: [
          Text(message),
          CupertinoButton(
              child: const Icon(CupertinoIcons.refresh),
              onPressed: onRefresh)
        ]),
      ));
}