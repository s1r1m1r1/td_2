import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../render/priority.dart';

class XTile extends GameDecoration {
  XTile({required super.position, required super.size});
 @override
  int get priority => Priority.tileOver; 

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
