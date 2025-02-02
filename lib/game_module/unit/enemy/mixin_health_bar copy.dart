// import 'package:bonfire/bonfire.dart';
// import 'package:bonfire/mixins/attackable.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'mixin_health.dart';

enum BarHealthAlignment { top, bottom, left, right }

 mixin MixinHealthBar on MixinHealth, PositionComponent {
  BarHealthComponent? barComponent;
  Vector2? _barPosition;
  Vector2? _barSize;
  Color _backgroundColor = const Color(0xFF000000);
  Color _borderColor = const Color(0xFFFFFFFF);
  double _borderWidth = 2;
  List<Color>? _colors;
  BorderRadius _borderRadius = BorderRadius.zero;

  void setupHealthBar({
    // Vector2? size,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 2,
    List<Color>? colors,
    BorderRadius? borderRadius,
    BarHealthAlignment barhealthDrawPosition = BarHealthAlignment.top,
    Vector2? textOffset,
    TextStyle? textStyle,
    bool showhealthText = true,
  }) {
    const barHeight = 8.0;
    _barPosition = switch (barhealthDrawPosition) {
      BarHealthAlignment.top => Vector2(0, -barHeight),
      BarHealthAlignment.bottom => position,
      BarHealthAlignment.left => position,
      BarHealthAlignment.right => position,
    };
    // _barhealthSize = size;
    _barSize = Vector2(size.x, barHeight);
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _borderColor = borderColor ?? _borderColor;
    _borderWidth = borderWidth;
    _colors = colors;
    _borderRadius = borderRadius ?? _borderRadius;
  }

  @override
  void onMount() {
    add(
      barComponent = BarHealthComponent(
        position: _barPosition,
        size: _barSize,
        backgroundColor: _backgroundColor,
        borderColor: _borderColor,
        borderWidth: _borderWidth,
        colors: _colors,
        borderRadius: _borderRadius,
      ),
    );
    super.onMount();
  }

  @override
  void setHealth(double value) {
    super.setHealth(value);
    barComponent?.setHealth(health);
    barComponent?.setMAXhealth(health);
  }

  @override
  void addHealth(double value) {
    super.addHealth(value);

    barComponent?.setHealth(health);
  }

  @override
  void subtractHealth(double value) {
    super.subtractHealth(value);
    barComponent?.setHealth(health);
  }
}
//----------------------------------------

typedef BarhealthTextBuilder = String Function(double life, double maxLife);

class BarHealthComponent extends PositionComponent {
  final Paint _barBgPaint = Paint();
  final Paint _barPaint = Paint()..style = PaintingStyle.fill;
  final Paint _barBorderPaint = Paint();

  final List<Color>? colors;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;
  double _health = 100;
  double _maxHealth = 100;

  bool show = true;

  BarHealthComponent({
    required super.size,
    super.position,
    this.colors,
    this.backgroundColor = const Color(0xFF000000),
    this.borderRadius = BorderRadius.zero,
    this.borderWidth = 2,
    this.borderColor = const Color(0xFFFFFFFF),
  }) {
    _barBorderPaint
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    _barBgPaint
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    if (borderWidth > 0) {
      final borderRect = borderRadius.toRRect(
        Rect.fromLTWH(position.x, position.y, size.x, size.y),
      );

      canvas.drawRRect(borderRect, _barBorderPaint);
    }

    _drawRectHealth(1, canvas);

    super.render(canvas);
  }

  void setHealth(double value) {
    _health = value;
  }

  void setMAXhealth(double value) {
    _maxHealth = value;
  }

  void _drawRectHealth(int count, Canvas canvas) {
    final bgRect = borderRadius.toRRect(
      Rect.fromLTWH(position.x, position.y, size.x, size.y),
    );

    canvas.drawRRect(bgRect, _barBgPaint);

    final barHealthWidth = size.x - 4;
    _barPaint.color = Colors.green;
    for (var i = 0; i < count; i++) {
      final rect = borderRadius.toRRect(
        Rect.fromLTWH(
          position.x + 1 + 2 + ((barHealthWidth / count) * i),
          position.y + 2,
          (barHealthWidth / count) - 2,
          size.y - 4,
        ),
      );
      // _barPaint.color = const Color.fromARGB(255, 53, 204, 58);
      canvas.drawRRect(rect, _barPaint);
    }
  }

  void _drawZigzagHealth(int count, Canvas canvas) {
    // // final p = position;
    // final romb = Vector2(8, 8);
    // final path = Path();
    // int module3 = 0;
    // path.moveTo(0, 0);
    // int count = 1;
    // for (var i = 0; count < 1; i++) {
    //   final p = Vector2(
    //     position.x + (i * romb.x + (romb.x)),
    //     position.y + (i.isOdd ? 0 : romb.y),
    //   );

    //   module3 = i % 3;
    //   if (module3 == 0) {
    //     path.lineTo(p.x + romb.x, p.y + romb.y);
    //     if (i == 0) path.lineTo(p.x + (romb.x * 2), p.y);
    //     // third
    //   } else if (module3 == 1) {
    //     path.lineTo(p.x + romb.x, p.y + romb.y);
    //     path.lineTo(p.x + (romb.x * 2), p.y);
    //     path.lineTo(p.x + romb.x, p.y - romb.y);
    //   }
    //   if (module3 == 2) {
    //     path.lineTo(p.x + romb.x, p.y - romb.y);
    //   }

    //   // path.lineTo(p.x + romb.x, p.y - romb.y);
    //   // path.lineTo(p.x, p.y);
    // }
    // // for (var i = 0; i >= 0; i--) {
    // //   module3 = i % 3;
    // //   final p = Vector2(position.x + (i * romb.x + (romb.x)), position.y);
    // //   if (module3 != 1) {
    // //     path.lineTo(p.x + romb.x, p.y - romb.y);
    // //     path.lineTo(p.x, p.y);
    // //     // third
    // //   }
    // // }

    // canvas.drawPath(path, _barPaint);

    // for (var i = 0; i < 10; i++) {
    //   final p = Vector2(
    //     position.x + (i * romb.x + (romb.x)),
    //     position.y + (i.isOdd ? 0 : romb.y),
    //   );
    //   final path = Path();
    //   path.moveTo(p.x, p.y);
    //   path.lineTo(p.x + romb.x, p.y + romb.y);
    //   path.lineTo(p.x + (romb.x * 2), p.y);
    //   path.lineTo(p.x + romb.x, p.y - romb.y);
    //   path.lineTo(p.x, p.y);
    //   // path.moveTo(p.x + fxSize.x / 2, n.y + 0);
    //   // path.lineTo(n.x + fxSize.x, n.y + fxSize.x * 0.5);
    //   // path.lineTo(n.x + fxSize.x / 2, n.y + fxSize.x * 1);
    //   // path.lineTo(n.x + 0, n.y + fxSize.x * 0.5);
    //   // path.close();
    //   canvas.drawPath(path, _barPaint);
    //   // // // final rect = borderRadius.toRRect(
    //   // // //   Rect.fromLTWH(
    //   // // //     position.x + 1 + 2 + ((barHealthWidth / 5) * i),
    //   // // //     position.y + 2,
    //   // // //     (barHealthWidth / 5) - 2,
    //   // // //     size.y - 4,
    //   // // //   ),
    //   // // // );
    //   // // _barPaint.color = const Color.fromARGB(255, 53, 204, 58);
    //   // canvas.drawRRect(rect, _barPaint);
    // }
  }
}
