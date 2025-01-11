import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../other/priority.dart';

// class XTile extends GameDecoration {
//   XTile({required super.position, required super.size});
//   @override
//   int get priority => Priority.tileOver;

//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(
//         size.toRect(),
//         paint
//           ..style = PaintingStyle.stroke
//           ..color = Colors.cyan);
//   }
// }

class XTile extends GameDecoration {
  XTile({required super.position, required super.size});
  @override
  int get priority => Priority.tileOver;
  Paint _paint = Paint()..color = Colors.red;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // canvas.drawPoints(
    //   PointMode.polygon,
    //   [
    //     Offset(size.x / 2, 0),
    //     Offset(size.x, size.y * 0.16),
    //     Offset(size.x / 2, size.y * 0.32),
    //     Offset(0, size.y * 0.16),
    //     Offset(size.x / 2, 0),
    //   ],
    //   _paint,
    // );
  }
}
