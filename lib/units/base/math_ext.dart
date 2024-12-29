import 'dart:math';

import 'package:bonfire/bonfire.dart';

extension ExtVector2 on Vector2 {
  double angleNearTo(Vector2 target) {
    final double distance = distanceTo(target);
    if (distance == 0) {
      return 0;
    }
    double radians = acos((-target.y + y) / distance);
    if (target.x < x) {
      radians = pi * 2 - radians;
    }
    return radians;
  }

  double get radius => (x + y) / 2 / 2;
}

extension DoubleExt on double {
  /// Converts degrees to radians.
  double degreesToRadians() {
    return this * (pi / 180);
  }

  /// Converts radians to degrees.
  double radiansToDegrees() {
    return this * (180 / pi);
  }
}
