// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'package:td_2/game_core/unit/bullet/explosion_component.dart';

import '../../mixin/clash.dart';
import '../../mixin/movable.dart';
import '../../tile/stage_map.dart';
import '../tower/tower_sprite_sheet.dart';

class MissileComponent extends BulletComponent {
  MissileComponent({
    required super.position,
    required super.config,
  }) : super(anim: TowerSpriteSheet.missile());
}

class BulletMGComponent extends BulletComponent {
  BulletMGComponent({
    required super.position,
    required super.config,
  }) : super(anim: TowerSpriteSheet.bulletMG());
}

// class Bullet1Component extends _BulletComponent {
//   Bullet1Component({
//     required super.position,
//     required super.size,
//   }) : super(anim: TowerSpriteSheet.bullet1());
// }

// class Bullet2Component extends _BulletComponent {
//   Bullet2Component({
//     required super.position,
//     required super.size,
//   }) : super(anim: TowerSpriteSheet.bullet2());
// }
typedef BulletBuilder = BulletComponent Function(
    Vector2 position, BulletComponentConfig config);

class BulletComponentConfig {
  final Vector2 size;
  final double speed;
  final dynamic effect;
  final Vector2 target;
  final double maxDistance;
  final Vector2? explosion;
  BulletComponentConfig({
    required this.size,
    required this.speed,
    required this.effect,
    required this.target,
    required this.maxDistance,
    this.explosion,
  });
}

abstract class BulletComponent extends GameComponent
    with Movable, CanNotSeen, Clash, UseAssetsLoader, UseSpriteAnimation {
  SpriteAnimation? _anim;

  BulletComponent({
    required Vector2 position,
    required this.config,
    // required size,
    required Future<SpriteAnimation> anim,
    // dynamic effect,
    // required this.target,
    // required this.maxDistance,
    // this.explosion,
  }) {
    this.position = position;
    this.size = config.size;
    this.speed = config.speed;
    // this.angle = angle;
    loader?.add(AssetToLoad(anim, (i) => _anim = i));
    this.effect = config.effect;
    // setupLighting(
    //   LightingConfig(
    //     radius: width * 8.0,
    //     color: Colors.transparent,
    //   ),
    // );
  }
  final BulletComponentConfig config;
  // final Vector2 target;
  // final Vector2? explosion;
  // final double maxDistance;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    super.moveToByDistance(to: config.target, distance: config.maxDistance);
    setAnimation(_anim, size: size, autoPlay: true);
    // distExplosion = 300;
    onMoveFinish = outOfRange;
  }

  @override
  void clashAlert() {
    if (config.explosion != null) {
      gameRef.add(ExplosionComponent(position: position, size: config.explosion!));
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
