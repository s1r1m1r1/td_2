import 'dart:math';

import 'package:bonfire/bonfire.dart';

abstract class Vec2 {
  static final zero = Vector2.zero();
}

class StageMap {
  static double tileSize = 45;
  static const String wallBottom = 'tile/wall_bottom.png';
  static const String wall = 'tile/wall.png';
  static const String wallTop = 'tile/wall_top.png';
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallBottomLeft = 'tile/wall_bottom_left.png';
  static const String wallRight = 'tile/wall_right.png';
  static const String floor_1 = 'tile/floor_1.png';
  static const String floor_2 = 'tile/floor_2.png';
  static const String floor_3 = 'tile/floor_3.png';
  static const String floor_4 = 'tile/floor_4.png';

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
