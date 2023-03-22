import 'package:flutter/material.dart';

class ScrollGlowRemove extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
