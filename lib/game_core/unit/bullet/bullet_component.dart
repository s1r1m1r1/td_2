// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:td_2/game_core/mixin/mixin_future_loader.dart';
import 'package:td_2/game_core/unit/enemy/enemy_unit.dart';

import '../../mixin/clash/mixin_clash.dart';
import '../../mixin/clash/mixin_clash_config.dart';
import '../../mixin/mixin_movable.dart';
import '../../mixin/mixin_sprite_animation.dart';
import '../tower/tower_sprite_sheet.dart';

class MissileComponent extends BulletComponent {
  MissileComponent({
    required super.position,
    required super.config,
  }) : super(anim: TowerSpriteSheet.missile());

  @override
  late MixinClashConfig clashConfig =
      MixinClashConfig(mode: ClashMode.collision, effect: config.effect);
}

class BulletMGComponent extends BulletComponent {
  BulletMGComponent({
    required super.position,
    required super.config,
  }) : super(anim: TowerSpriteSheet.bulletMG());

  @override
  late MixinClashConfig clashConfig =
      MixinClashConfig(mode: ClashMode.collision, effect: config.effect);
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

abstract class BulletComponent extends PositionComponent
    with MixinMovable, MixinClash, MixinFutureLoader, MixinSpriteAnimation {
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
    size = config.size;
    speed = config.speed;
    // this.angle = angle;
    loader?.add(FutureToLoad(anim, (i) => _anim = i));
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
  late final effect = config.effect;

  @override
  int get priority => 10000;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    super.moveToByDistance(to: config.target, distance: config.maxDistance);
    add(RectangleComponent(
        size: size,
        paint: Paint()
          ..color = const Color.fromARGB(255, 59, 64, 226)
          ..blendMode = BlendMode.srcIn));
    // setAnimation(_anim, size: size, autoPlay: true);
    // distExplosion = 300;
    onMoveFinish = outOfRange;
  }

  @override
  void clashAlert() {
    if (config.explosion != null) {
      // gameRef.add(ExplosionComponent(
      //   position: position,
      //   size: config.explosion!,
      //   anchor: Anchor.center,
      // ));
    }
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
}
