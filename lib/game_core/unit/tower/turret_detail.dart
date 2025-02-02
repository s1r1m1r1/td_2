import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'tower_rotate_effect.dart';

class TurretDetail extends GameComponent
    with UseSpriteAnimation, UseAssetsLoader {
  SpriteAnimation? _anim;
  TurretDetail({
    required Vector2 position,
    required Vector2 size,
    required Future<SpriteAnimation> sprite,
  }) {
    this.position = position;
    this.size = size;
    loader?.add(AssetToLoad(sprite, (i) => _anim = i));
  }
  double rotateSpeed = 6.0; /* radians/second */
  double range = 60;
  double rotateTo(double radians, VoidCallback onComplete) {
    final double duration = (radians - angle).abs() / rotateSpeed;
    if (duration <= 0) {
      onComplete.call();
      return 0;
    }
    add(
      TowerRotateEffect(
        radians,
        EffectController(
          duration: duration,
          curve: Curves.easeOut,
          // infinite: false,
        ),
        onComplete,
      ),
    );

    return duration;
  }

  @override
  void onMount() {
    anchor = Anchor.center;
    super.onMount();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setAnimation(_anim);
  }

  @override
  void render(Canvas canvas) {
    if (!buildDone) {
      final Color? color = buildAllowed ? Colors.green[200] : Colors.red[200];
      /*build indicator */
      // canvas.drawRect(size.toRect(), Paint()..color = color!.withOpacity(0.3));
      canvas.drawCircle(
          (size / 2).toOffset(),
          range,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = Colors.red);
    }
    super.render(canvas);
  }

  bool buildDone = true;
  bool buildAllowed = true;
}
