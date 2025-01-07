import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../decoration/chest.dart';

class DraggableButtonArena extends PositionComponent with HasVisibility {
  DraggableButtonArena(Vector2 position) {
    this.position = position;
    _textConfig = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: width / 2),
    );
  }
  TextComponent? staticText;
  PositionComponent? staticImage;
  String text = 'Drag here';
  late TextPaint _textConfig;
  get textSize => _textConfig.getLineMetrics(text).size;

  @override
  FutureOr<void> onLoad() {
    staticImage = Chest(position);
    staticText = TextComponent(
      text: text,
      position: Vector2(0, 32),
      textRenderer: _textConfig,
    );
    add(staticImage!);
    add(staticText!);
    return super.onLoad();
  }
}
