import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:logging/logging.dart';
import 'package:td_2/game_core/other/priority.dart';

  final _log = Logger(TileFXController.loggerName);
class TileFXController extends GameComponent {
  TileFXController();
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
        paint: Paint()..color = Colors.red.withAlpha(100));
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
        paint: Paint()..color = Colors.green.withAlpha(100));
    parent?.add(effect!);
  }

  @override
  void onRemove() {
    effect?.removeFromParent();
    effect = null;
    super.onRemove();
  }
}
