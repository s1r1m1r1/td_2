import 'dart:ui';

import 'package:bonfire/util/sprite_animation_render.dart'
    show SpriteAnimationRender;
import 'package:flame/components.dart';

mixin MixinSpriteAnimation on PositionComponent {
  Paint? _spritePaint;
  Paint? _strokePaint;
  double _strokeWidth = 0;
  Vector2 _strokeSize = Vector2.zero();
  Vector2 _strokePosition = Vector2.zero();
  Vector2? spriteAnimationOffset;

  /// set Animation that will be drawn on the screen.
  void setAnimation(
    SpriteAnimation? animation, {
    Vector2? size,
    bool loop = true,
    bool autoPlay = true,
    VoidCallback? onFinish,
    VoidCallback? onStart,
  }) {
    _spritePaint = Paint();
    _animationRender = SpriteAnimationRender(
      animation: animation,
      size: size ?? this.size,
      loop: loop,
      onFinish: onFinish,
      onStart: onStart,
      autoPlay: autoPlay,
    );
  }

  SpriteAnimationRender? _animationRender;
  SpriteAnimationRender? get _animationR => _animationRender;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isRemoving) return;
    if (_strokePaint != null) {
      _animationR?.render(
        canvas,
        position: _strokePosition + (spriteAnimationOffset ?? Vector2.zero()),
        size: _strokeSize,
        overridePaint: _strokePaint,
      );
    }
    _animationR?.render(
      canvas,
      position: spriteAnimationOffset,
      overridePaint: _spritePaint,
      size: size,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _animationR?.update(dt);
    if (_strokeSize.isZero()) {
      _strokeSize = Vector2(
        size.x + _strokeWidth * 2,
        size.y + _strokeWidth * 2,
      );
    }
  }

  void pauseAnimation() {
    _animationR?.pause();
  }

  void playAnimation() {
    _animationR?.play();
  }

  bool get isAnimationLastFrame => _animationR?.isLastFrame ?? false;
  int get animationCurrentIndex => _animationR?.currentIndex ?? 0;
  bool get isPaused => _animationR?.isPaused ?? false;

  void showAnimationStroke(Color color, double width, {Vector2? offset}) {
    if (_strokePaint != null &&
        _strokeWidth == width &&
        _strokePaint?.color == color) {
      return;
    }
    _strokeWidth = width;
    _strokePosition = Vector2.all(-_strokeWidth);
    if (offset != null) {
      _strokePosition += offset;
    }
    _strokeSize = Vector2.zero();
    _strokePaint = Paint()
      ..color = color
      ..colorFilter = ColorFilter.mode(
        color,
        BlendMode.srcATop,
      );
  }

  void hideAnimationStroke() {
    _strokePaint = null;
  }
}
