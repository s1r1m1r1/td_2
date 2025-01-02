import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:td_2/game_core/unit/tower/explosion.dart';

import '../../tile/stage_map.dart';
import '../../mixin/movable.dart';
import '../../mixin/clash.dart';
import 'tower_sprite_sheet.dart';

class MissileDetail extends BulletDetail {
  MissileDetail({
    required super.position,
    required super.size,
    required super.speed,
    required super.effect,
    required super.target,
    required super.maxDistance,
    required super.explosion,
  }) : super(anim: TowerSpriteSheet.missile());
}

class BulletMGDetail extends BulletDetail {
  BulletMGDetail({
    required super.position,
    required super.size,
    required super.speed,
    required super.effect,
    required super.target,
    required super.maxDistance,
  }) : super(anim: TowerSpriteSheet.bulletMG());
}

// class Bullet1Detail extends _BulletDetail {
//   Bullet1Detail({
//     required super.position,
//     required super.size,
//   }) : super(anim: TowerSpriteSheet.bullet1());
// }

// class Bullet2Detail extends _BulletDetail {
//   Bullet2Detail({
//     required super.position,
//     required super.size,
//   }) : super(anim: TowerSpriteSheet.bullet2());
// }
typedef BulletBuilder = BulletDetail Function({
  required Vector2 position,
  required Vector2 size,
  required double speed,
  required dynamic effect,
  required Vector2 target,
  required double maxDistance,
  Vector2? explosion,
});

abstract class BulletDetail extends GameComponent
    with Movable, CanNotSeen, Clash, UseAssetsLoader, UseSpriteAnimation {
  SpriteAnimation? _anim;
  BulletDetail({
    required Vector2 position,
    required size,
    required Future<SpriteAnimation> anim,
    dynamic effect,
    required double speed,
    required this.target,
    required this.maxDistance,
    this.explosion,
  }) {
    this.position = position;
    this.size = size;
    this.speed = speed;
    // this.angle = angle;
    loader?.add(AssetToLoad(anim, (i) => _anim = i));
    this.effect = effect;
    // setupLighting(
    //   LightingConfig(
    //     radius: width * 8.0,
    //     color: Colors.transparent,
    //   ),
    // );
  }
  final Vector2 target;
  final Vector2? explosion;
  final double maxDistance;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    super.moveToByDistance(to: target, distance: maxDistance);
    setAnimation(_anim, size: size, autoPlay: true);
    // distExplosion = 300;
    onMoveFinish = outOfRange;
  }

  @override
  void clashAlert() {
    if (explosion != null) {
      debugPrint('ON ___ on EXplosion');
      gameRef.add(Explosion(position: position, size: explosion!));
    }
    // bulletExplosion(position);
    removeFromParent();
  }

  @override
  void update(double dt) {
    updateMovable(dt);
    super.update(dt);
  }

  void outOfRange() {
    removeFromParent();
  }

  void bulletExplosion(Vector2 pos) {
    gameRef.add(
      RectangleComponent(
        priority: 1000,
        position: pos,
        paint: Paint()..color = Colors.green.withAlpha(100),
        anchor: Anchor.center,
        size: Vector2.all(StageMap.tileSize),
      )..add(
          RemoveEffect(delay: 2),
        ),
    );
  }
}
