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

extension RectExt on Rect {
  Vector2 get positionVector2 => Vector2(left, top);
  Vector2 get sizeVector2 => Vector2(width, height);

  Rectangle getRectangleByTileSize(double tileSize) {
    final maxSize = max(this.width, this.height);
    final left = (this.left / tileSize).floorToDouble();
    final top = (this.top / tileSize).floorToDouble();
    final width = (maxSize / tileSize).ceilToDouble();
    final height = (maxSize / tileSize).ceilToDouble();

    return Rectangle(
      left,
      top,
      width,
      height,
    );
  }

  bool overlapComponent(PositionComponent c) {
    final left = c.position.x;
    final top = c.position.y;
    final right = c.position.x + c.size.x;
    final bottom = c.position.y + c.size.y;
    if (this.right <= left || right <= this.left) {
      return false;
    }
    if (this.bottom <= top || bottom <= this.top) {
      return false;
    }
    return true;
  }

  /// Returns a new rectangle with edges moved outwards by the given delta.
  Rect inflatexy(double deltaX, double deltaY) {
    return Rect.fromLTRB(
      left - deltaX,
      top - deltaY,
      right + deltaX,
      bottom + deltaY,
    );
  }

  /// Returns a new rectangle with edges moved inwards by the given delta.
  Rect deflatexy(double deltaX, double deltaY) => inflatexy(-deltaX, -deltaY);

  Vector2 get centerVector2 => Vector2(left + width / 2.0, top + height / 2.0);
}
