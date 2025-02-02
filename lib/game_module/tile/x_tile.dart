import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../other/priority.dart';

class XTile extends PositionComponent {
  XTile({ super.position, required super.size});
  @override
  int get priority => Priority.tileOver;

  final paint = Paint();

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
        size.toRect(),
        paint
          ..style = PaintingStyle.stroke
          ..color = Colors.cyan);
  }
}
