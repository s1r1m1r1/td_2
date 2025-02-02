import 'dart:math';

import 'package:flutter/material.dart';

abstract class ScreenUtil {
  // Help you to calculate zoom by max tiles can be visible
 static double getZoomFromMaxVisibleTile(
    BuildContext context,
    double tileSize,
    int maxTile, {
    Orientation? orientation,
  }) {
    final screenSize = MediaQuery.of(context).size;
    if (screenSize == Size.zero || screenSize == Size.infinite) {
      return 1;
    }
    var maxSize = 0.0;
    switch (orientation) {
      case Orientation.portrait:
        maxSize = screenSize.height;
      case Orientation.landscape:
        maxSize = screenSize.width;
      default:
        maxSize = max(screenSize.width, screenSize.height);
    }
    return maxSize / (tileSize * maxTile);
  }
}
