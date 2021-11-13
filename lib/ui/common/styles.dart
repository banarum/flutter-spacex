import 'package:flutter/material.dart';

const double defaultMargin = 16;

const defaultItemPadding = EdgeInsets.only(
    left: defaultMargin,
    right: defaultMargin,
    top: defaultMargin / 2,
    bottom: defaultMargin / 2);

class TextStyles {
  static const TextStyle common = TextStyle();
  static const TextStyle itemTitle = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle title = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle itemSubtitle = TextStyle(fontWeight: FontWeight.w500);
}
