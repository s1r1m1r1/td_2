import 'dart:math';

import 'package:flame/components.dart';

abstract class Vec2 {
  static final zero = Vector2.zero();
}

class StageMap {
  static double tileSize = 45;
  static const String wallBottom = 'assets/images/tile/wall_bottom.png';
  static const String wall = 'assets/images/tile/wall.png';
  static const String wallTop = 'assets/images/tile/wall_top.png';
  static const String wallLeft = 'assets/images/tile/wall_left.png';
  static const String wallBottomLeft = 'assets/images/tile/wall_bottom_left.png';
  static const String wallRight = 'assets/images/tile/wall_right.png';
  static const String floor_1 = 'assets/images/tile/floor_1.png';
  static const String floor_2 = 'assets/images/tile/floor_2.png';
  static const String floor_3 = 'assets/images/tile/floor_3.png';
  static const String floor_4 = 'assets/images/tile/floor_4.png';

  static Vector2 toRelative(int x, int y) {
    return Vector2(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }

  static Point<int> toAstarPos(Vector2 position) {
    return Point(
      position.x ~/ tileSize,
      position.y ~/ tileSize,
    );
  }
}
