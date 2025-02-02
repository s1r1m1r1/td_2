import 'dart:ui';

import 'package:flame/components.dart';
import 'package:logging/logging.dart';
import '../other/priority.dart';

final _log = Logger(FloorFXController.loggerName);

class FloorFXController extends PositionComponent {
  FloorFXController({super.position} );
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
    effect = RectangleComponent(
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
    effect = RectangleComponent(
        priority: Priority.overAll,
        position: pos,
        size: size,
        paint: Paint()
          ..color = const Color.fromARGB(255, 63, 218, 68).withAlpha(100));
    parent?.add(effect!);
  }

  @override
  void onRemove() {
    effect?.removeFromParent();
    effect = null;
    super.onRemove();
  }
}
