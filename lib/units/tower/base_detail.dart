import 'package:bonfire/bonfire.dart';
import 'package:flutter/animation.dart';
import 'package:td_2/units/base/math_ext.dart';

import 'tower_rotate_effect.dart';
import 'turret_detail.dart';

class BaseDetail extends GameComponent
    with UseSpriteAnimation, UseAssetsLoader {
  SpriteAnimation? _anim;
  BaseDetail({
    required Vector2 position,
    required Vector2 size,
    required Future<SpriteAnimation> sprite,
  }) {
    this.position = position;
    this.size = size;
    loader?.add(AssetToLoad(sprite, (i) => _anim = i));
  }

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
    setAnimation(_anim);
  }

  @override
  void onMount() {
    anchor = Anchor.center;
    super.onMount();
  }
}
