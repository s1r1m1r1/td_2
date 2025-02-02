import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

abstract class Vec2 {
  static final zero = Vector2.zero();
}

mixin MixinGameSize on FlameGame {
  late double tileSize = 128.0;
  late Vector2 floorSize = Vector2(128, 156);
  late Vector2 hexSize = Vector2(128, 96);
  double _stepX = 0;
  double _stepY = 0;

  calculateMapSize(int rows, int cols) {
    _stepX = 64;
    _stepY = 68;

    final rightBottom = toIsometricPoint(rows, cols);
    final topLeftPadding = Vector2(canvasSize.x * 0.4, canvasSize.y * 0.1);
    final bottomRightPadding = Vector2(-canvasSize.x * 0.4, 0);

    camera.setBounds(
      Rectangle.fromPoints(
        Vector2(0, 0) + topLeftPadding,
        Vector2(rightBottom.x, rightBottom.y) + bottomRightPadding,
      ),
    );
  }

  toRelative(int x, int y) {
    return Vector2(x * tileSize, y * tileSize);
  }

  // Point<int> toAstarPos(Vector2 position) {
  //   return Point(position.x ~/ tileSize, position.y ~/ tileSize);
  // }

  Vector2 toIsometricPoint(int x, int y) {
    // ~ 0.5, play with value for settings
    return Vector2(128 * x + (_stepX * y), _stepY * y);
  }
}
