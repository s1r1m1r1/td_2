import 'dart:math' as math;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:td_2/unit/base/math_ext.dart';
import 'package:td_2/unit/tower/tower.dart';

import '../../render/priority.dart';
import '../../world/stage_map.dart';
import 'base_detail.dart';
import 'bullet_detail.dart';
import '../mixin/radar.dart';
import 'tower_sprite_sheet.dart';
import 'turret_detail.dart';

class MissileTower extends RotationTower {
  MissileTower({
    required super.position,
  }) : super(
          turretAnim: TowerSpriteSheet.gunSprite(),
          baseAnim: TowerSpriteSheet.tower(),
          scan: StageMap.tileSize * 2,
          bulletDistance: StageMap.tileSize * 3,
        );

  @override
  int get priority => Priority.tileTower;
}

class RocketTower extends RotationTower {
  RocketTower({
    required super.position,
  }) : super(
          turretAnim: TowerSpriteSheet.gunSprite(),
          baseAnim: TowerSpriteSheet.tower(),
          scan: StageMap.tileSize * 2,
          bulletDistance: StageMap.tileSize * 3,
        );
  @override
  int get priority => Priority.tileTower;
}

abstract class RotationTower extends TowerComponent with Radar, Lighting {
  RotationTower({
    required super.position,
    required Future<SpriteAnimation> baseAnim,
    required Future<SpriteAnimation> turretAnim,
    required double scan,
    required double bulletDistance,
  }) : super(
          size: Vector2.all(StageMap.tileSize * 0.9),
        ) {
    distScan = scan + (size.x / 2);
    _bulletDistance = bulletDistance + (size.x / 2);
    lightingEnabled = false;
    setupLighting(
      LightingConfig(
        radius: size.x * 2,
        color: Colors.yellow.withOpacity(.3),
      ),
    );
    baseDetail = BaseDetail(
      position: size / 2,
      size: size,
      sprite: baseAnim,
    );
    turretDetail = TurretDetail(
      position: size / 2,
      size: size,
      sprite: turretAnim,
    );

    addAll([
      baseDetail,
      turretDetail,
    ]);
    radarOn = true;
    radarScanAlert = onScan;
  }
  late BaseDetail baseDetail;
  late TurretDetail turretDetail;

  void onScan(GameComponent c) {
    fire(c.position + (c.size / 2));
  }

  late double _bulletDistance;
  double currentRadAngle = -1.55;
  double rotateSpeed = 2.0; /* radians per second */
  double fireInterval = 0.2;
  Vector2? _targetEnemy;

  void fire(Vector2 target) {
    _targetEnemy = target;
    final double radians = position.angleNearTo(target);
    final double rotatePeriod = turretDetail.rotateTo(radians, _fireBullet);
    coolDown(rotatePeriod + fireInterval, () => radarOn = true);
  }

  void _fireBullet() {
    if (_targetEnemy != null) {
      lightingEnabled = true;
      fireBullet(_targetEnemy!);
    }
    _targetEnemy = null;
  }

  void fireBullet(Vector2 target) {
    final bullet = BulletMGDetail(
      position: _bulletPosition(),
      size: Vector2.all(8),
    )
      // ..anchor = Anchor.center
      ..angle = 2.0
      ..effect = 100.0
      ..speed = 200;
    bullet.moveToByDistance(to: target, distance: _bulletDistance);
    gameRef.add(bullet);
  }

  void coolDown(double period, void Function() onTick) {
    radarOn = false;
    add(TimerComponent(
      period: period,
      // repeat: false,
      removeOnFinish: true,
      onTick: onTick,
    ));
  }

  @override
  Future<void> onLoad() async {
    add(CircleComponent(
        radius: distScan,
        position: size / 2,
        anchor: Anchor.center,
        paint: Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0));
    add(CircleComponent(
        radius: _bulletDistance,
        position: size / 2,
        anchor: Anchor.center,
        paint: Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0));
    await super.onLoad();
  }

  @override
  void onMount() {
    anchor = Anchor.topLeft;
    super.onMount();
  }

  Vector2 _bulletPosition() {
    Vector2 localPosition = Vector2(size.radius * math.sin(turretDetail.angle),
        -size.radius * math.cos(turretDetail.angle));
    localPosition += size / 2;
    return positionOf(localPosition);
  }
}
