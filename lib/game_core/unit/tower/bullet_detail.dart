import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../../tile/stage_map.dart';
import '../../mixin/movable.dart';
import '../../mixin/clash.dart';
import 'tower_sprite_sheet.dart';

class MissileDetail extends _BulletDetail {
  MissileDetail({
    required super.position,
    required super.size,
  }) : super(anim: TowerSpriteSheet.missile());
}

class BulletMGDetail extends _BulletDetail {
  BulletMGDetail({
    required super.position,
    required super.size,
  }) : super(anim: TowerSpriteSheet.bulletMG());
}

class Bullet1Detail extends _BulletDetail {
  Bullet1Detail({
    required super.position,
    required super.size,
  }) : super(anim: TowerSpriteSheet.bullet1());
}

class Bullet2Detail extends _BulletDetail {
  Bullet2Detail({
    required super.position,
    required super.size,
  }) : super(anim: TowerSpriteSheet.bullet2());
}

class _BulletDetail<T> extends GameComponent
    with Movable, CanNotSeen, Clash<T>, UseAssetsLoader, UseSpriteAnimation {
  SpriteAnimation? _anim;
  _BulletDetail({
    required Vector2 position,
    required Vector2 size,
    required Future<SpriteAnimation> anim,
    T? effect,
  }) {
    this.position = position;
    this.size = size;
    loader?.add(AssetToLoad(anim, (i) => _anim = i));
    this.effect = effect;
    // setupLighting(
    //   LightingConfig(
    //     radius: width * 8.0,
    //     color: Colors.transparent,
    //   ),
    // );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setAnimation(_anim, size: size, autoPlay: true);
    clashAlert = done;
    // distExplosion = 300;
    onMoveFinish = outOfRange;
  }

  void done() {
    bulletExplosion(position);
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