import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:logging/logging.dart';
import 'package:td_2/render/priority.dart';

class TileFXController extends GameComponent {
  TileFXController();
  static const loggerName = 'TileFXController';
  final _log = Logger(loggerName);
  PositionComponent? effect;

  void removeFX() {
    effect?.removeFromParent();
  }

  void setNotAllowedFX({
    required Vector2 pos,
    required Vector2 size,
  }) {
    effect?.removeFromParent();
    _log.info('set not');
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
    _log.info('set ok');
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
