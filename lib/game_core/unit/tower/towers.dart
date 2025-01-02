import 'dart:math' as math;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:td_2/game_core/other/math_ext.dart';

import '../../mixin/radar.dart';
import '../../other/priority.dart';
import '../../tile/stage_map.dart';
import 'i_tower.dart';
import 'base_detail.dart';
import '../bullet/bullet_component.dart';
import 'tower_sprite_sheet.dart';
import 'turret_detail.dart';

class MissileTower extends RotationTower {
  MissileTower({
    required super.position,
  }) : super(
          turretAnim: TowerSpriteSheet.missileSprite(),
          baseAnim: TowerSpriteSheet.tower(),
          scan: StageMap.tileSize * 2,
          bulletDistance: StageMap.tileSize * 3,
          explosion: Vector2.all(StageMap.tileSize * 4),
          fireInterval: 2.0,
          rotateSpeed: 1.5,
          bulletBuilder: (position, config) => MissileComponent(
            position: position,
            config: config,
          ),
        );

  @override
  int get priority => Priority.tileTower;
}

class CannonTower extends RotationTower {
  CannonTower({
    required super.position,
  }) : super(
          turretAnim: TowerSpriteSheet.cannonSprite(),
          baseAnim: TowerSpriteSheet.tower(),
          scan: StageMap.tileSize * 2,
          bulletDistance: StageMap.tileSize * 3,
          fireInterval: 0.2,
          rotateSpeed: 4.0,
          bulletBuilder: (position, config) => BulletMGComponent(
            position: position,
            config: config,
          ),

          // bulletBuilder: (dynamic effect,double maxDistance,Vector2 position,Vector2 size,double speed,Vector2 target) => BulletMGComponent(position: position, size: size, speed: speed, effect: effect, target: target, maxDistance: maxDistance);,
        );
  @override
  int get priority => Priority.tileTower;
}

class RotationTower extends ITowerComponent with Radar, Lighting {
  RotationTower({
    required super.position,
    required Future<SpriteAnimation> baseAnim,
    required Future<SpriteAnimation> turretAnim,
    required double scan,
    required double bulletDistance,
    this.explosion,
    required this.bulletBuilder,
    required this.fireInterval,
    required this.rotateSpeed,
  }) : super(
          size: Vector2.all(StageMap.tileSize * 0.9),
        ) {
    distScan = scan + (size.x / 2);
    _bulletDistance = bulletDistance + (size.x / 2);
    lightingEnabled = true;
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
  }
  final BulletBuilder bulletBuilder;
  late BaseDetail baseDetail;
  late TurretDetail turretDetail;
  final Vector2? explosion;

  @override
  void onRadar(RadarTarget component) {
    fire(component.position + (component.size / 2));
  }

  late double _bulletDistance;
  double currentRadAngle = -1.55;
  final double rotateSpeed; /* radians per second */
  final double fireInterval;
  Vector2? _targetEnemy;

  void fire(Vector2 target) {
    _targetEnemy = target;
    final double radians = position.angleNearTo(target);
    final double rotatePeriod = turretDetail.rotateTo(radians, _fireBullet);
    coolDown(rotatePeriod + fireInterval, () => radarOn = true);
  }

  void _fireBullet() {
    if (_targetEnemy != null) {
      fireBullet(_targetEnemy!);
    }
    _targetEnemy = null;
  }

  void fireBullet(Vector2 target) {
    final bullet = bulletBuilder(
        _bulletPosition(),
        BulletComponentConfig(
            size: Vector2.all(8),
            speed: 100,
            effect: 25,
            maxDistance: _bulletDistance,
            target: target,
            explosion: explosion));

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
