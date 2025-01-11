import 'dart:ui';

import 'package:flame/components.dart';
import 'package:logging/logging.dart';
import '../other/priority.dart';

final _log = Logger(FloorFXController.loggerName);

class FloorFXController extends PositionComponent {
  FloorFXController();
  static const loggerName = 'TileFXController';
  PositionComponent? effect;

  void removeFX() {
    effect?.removeFromParent();
  }

  void setNotAllowedFX({
    required Vector2 pos,
    required Vector2 size,
  }) {
    effect?.removeFromParent();
    effect = PolygonComponent([
      Vector2(size.x / 2, 0),
      Vector2(size.x, size.y * 0.16),
      Vector2(size.x / 2, size.y * 0.32),
      Vector2(0, size.y * 0.16),
      Vector2(size.x / 2, 0),
    ],
        position: pos,
        priority: Priority.overAll,
        size: size,
        paint: Paint()
          ..color = const Color.fromARGB(255, 182, 41, 31).withAlpha(100));
    parent?.add(effect!);
  }

  void setAllowedFX({
    required Vector2 pos,
    required Vector2 size,
  }) {
    effect?.removeFromParent();
    effect = PolygonComponent(
      [
        Vector2(size.x / 2, 0),
        Vector2(size.x, size.y * 0.16),
        Vector2(size.x / 2, size.y * 0.32),
        Vector2(0, size.y * 0.16),
        Vector2(size.x / 2, 0),
      ],
      position: pos,
      priority: Priority.overAll,
      size: size,
      paint: Paint()
        ..color = const Color.fromARGB(255, 63, 218, 68).withAlpha(100),
    );

    parent?.add(effect!);
  }

  @override
  void onRemove() {
    effect?.removeFromParent();
    effect = null;
    super.onRemove();
  }
}
