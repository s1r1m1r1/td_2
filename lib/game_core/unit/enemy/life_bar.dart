// import 'package:bonfire/bonfire.dart';
// import 'package:bonfire/mixins/attackable.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'health.dart';

enum BarHealthAlignment { top, bottom, left, right }

base mixin UseHealthBar on MixinHealth, PositionComponent {
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
    const barHeight = 6.0;
    _barPosition = switch (barhealthDrawPosition) {
      BarHealthAlignment.top => Vector2(
          0,
          -barHeight,
        ),
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
  Paint _barhealthBgPaint = Paint();
  final Paint _barhealthPaint = Paint()..style = PaintingStyle.fill;
  Paint _barhealthBorderPaint = Paint();

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
    _barhealthBorderPaint = _barhealthBorderPaint
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    _barhealthBgPaint = _barhealthBgPaint
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    final currentBarhealth = (_health * width) / _maxHealth;

    if (borderWidth > 0) {
      final borderRect = borderRadius.toRRect(
        Rect.fromLTWH(
          position.x,
          position.y,
          size.x,
          size.y,
        ),
      );

      canvas.drawRRect(
        borderRect,
        _barhealthBorderPaint,
      );
    }

    final bgRect = borderRadius.toRRect(
      Rect.fromLTWH(
        position.x,
        position.y,
        size.x,
        size.y,
      ),
    );

    canvas.drawRRect(
      bgRect,
      _barhealthBgPaint,
    );

    final healthRect = borderRadius.toRRect(
      Rect.fromLTWH(
        position.x,
        position.y,
        currentBarhealth,
        size.y,
      ),
    );

    canvas.drawRRect(
      healthRect,
      _barhealthPaint
        ..color = _getColorhealth(
          currentBarhealth,
          width,
          colors ??
              [
                const Color(0xFFF44336),
                const Color(0xFFFFEB3B),
                const Color(0xFF4CAF50),
              ],
        ),
    );

    super.render(canvas);
  }

  Color _getColorhealth(
    double currentBarhealth,
    double maxWidth,
    List<Color> colors,
  ) {
    final parts = maxWidth / colors.length;
    final index = (currentBarhealth / parts).ceil() - 1;
    if (index < 0) {
      return colors[0];
    }
    if (index > colors.length - 1) {
      return colors.last;
    }
    return colors[index];
  }

  void setHealth(double value) {
    _health = value;
  }

  void setMAXhealth(double value) {
    _maxHealth = value;
  }
}
