import 'package:flutter/widgets.dart';
import 'package:kartal/kartal.dart';

class CustomSizedBox {
  static SizedBox getSmall0005Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.005),
    );
  }

  static SizedBox getSmall01Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.01),
    );
  }

  static SizedBox getSmall015Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.015),
    );
  }

  static SizedBox getSmall025Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.025),
    );
  }

  static SizedBox getMedium05Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.05),
    );
  }

  static SizedBox getHigh075Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.075),
    );
  }

  static SizedBox getHigh1Seperator(BuildContext context) {
    return SizedBox(
      // width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.1),
    );
  }

  static SizedBox getSmall001HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.01));
  }

  static SizedBox getSmall0015HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.015));
  }

  static SizedBox getSmall0020HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.02));
  }

  static SizedBox getSmall0025HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.025));
  }

  static SizedBox getSmall005HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.05));
  }

  static SizedBox getSmall01HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.1));
  }

  static SizedBox getSmall025HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.25));
  }

  static SizedBox getMedium05HorizontalSeperator(BuildContext context) {
    return SizedBox(width: context.sized.dynamicWidth(0.5));
  }
}
