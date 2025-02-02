import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:flutter/material.dart' show ValueGetter;
import 'package:flutter/widgets.dart' show Curves;

import '../../other/math_ext.dart';
import 'tower_rotate_effect.dart';
import 'turret_detail.dart';

class BaseDetail extends PositionComponent {
  BaseDetail({
    required Vector2 position,
    required Vector2 size,
    required this.getSprite,
  }) {
    this.position = position;
    this.size = size;
  }

  final ValueGetter<Future<Sprite>> getSprite;

  double rotateSpeed = 6.0; /* radians/second */
  double fireInterval = 10.0;
  Vector2? _targetEnemy;
  late TurretDetail turret;

  void fire(Vector2 target) {
    _targetEnemy = target;
    final double radians = position.angleNearTo(target);
    final double rotatePeriod = turret.rotateTo(radians, _fireBullet);
    coolDown(rotatePeriod + fireInterval);
  }

  void _fireBullet() {
    if (_targetEnemy != null) {
      fireBullet(_targetEnemy!);
    }
    _targetEnemy = null;
  }

  void fireBullet(Vector2 target) {}

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

  bool radarOn = true;
  void coolDown(double period) {
    radarOn = false;
    add(TimerComponent(
        period: period,
        // repeat: false,
        removeOnFinish: true,
        onTick: () => radarOn = true));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final anim = await getSprite.call();
    final sprite = SpriteComponent(sprite: anim,size: size);
    add(sprite);
  }

  @override
  void onMount() {
    anchor = Anchor.center;
    super.onMount();
  }
}
