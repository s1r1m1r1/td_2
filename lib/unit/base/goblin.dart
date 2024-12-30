import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';
import 'package:td_2/unit/base/movable.dart';

import '../../render/priority.dart';
import '../../tile/stage_map.dart';
import '../../decoration/common_sprite_sheet.dart';
import 'enemy_sprite_sheet.dart';
import 'enemy_unit.dart';

final _log = Logger(Goblin.loggerName);

class Goblin extends ScannableEnemy with UseLifeBar, Movable {
  static const loggerName = 'Goblin';
  bool active = true;
  Goblin(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(StageMap.tileSize * 0.8),
          speed: StageMap.tileSize,
          life: 10000,
        ) {
    setupLifeBar(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
    );
  }

  @override
  int get priority => Priority.enemies;

  void _removeLife(double life) {
    _log.info('remove life');
    showDamage(
      life,
      config: TextStyle(
        fontSize: width / 2,
        color: Colors.white,
      ),
    );
    super.removeLife(life);
  }

  void onClash(dynamic d) {
    _log.info('onClash i: ${d.runtimeType} ');
    if (isDead) return;
    if (d is double) {
      _log.info('onClash ok');
      _removeLife(d);
    }
  }

  @override
  void update(double dt) {
    super.updateMovable(dt);
    super.update(dt);
  }

  @override
  void onDie() {
    super.onDie();
    gameRef.add(
      AnimatedGameObject(
        animation: CommonSpriteSheet.smokeExplosion,
        position: position,
        size: Vector2.all(StageMap.tileSize * 0.3),
        loop: false,
      ),
    );
    removeFromParent();
  }

  void execAttackRange(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    // simpleAttackRange(
    //   animationRight: CommonSpriteSheet.fireBallRight,
    //   animationDestroy: CommonSpriteSheet.explosionAnimation,
    //   id: 35,
    //   size: Vector2.all(width * 0.9),
    //   damage: damage,
    //   speed: StageMap.tileSize * 3,
    //   collision: RectangleHitbox(
    //     size: Vector2.all(width / 2),
    //     position: Vector2(width * 0.25, width * 0.25),
    //   ),
    //   lightingConfig: LightingConfig(
    //     radius: width / 2,
    //     blurBorder: width,
    //     color: Colors.orange.withOpacity(0.3),
    //   ),
    // );
  }

  var _path = <Point<int>>[];
  Future<void> moveSmart(List<Point<int>> path) async {
    _path = path;
    pathNextMove();
  }

  void pathNextMove() {
    if (_path.isNotEmpty) {
      _log.info("Path no empty");
      final next = _path.removeLast();
      final from = position;
      final to = StageMap.toRelative(next.x, next.y);
      _log.info("Path from: ${position} to ${to}");
      super.moveFromTo(
          from: from, to: to, onFinish: pathNextMove, fixedAngle: 0.0);
    }
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(
          StageMap.tileSize * 0.4,
          StageMap.tileSize * 0.4,
        ),
        position: Vector2(
          StageMap.tileSize * 0.2,
          StageMap.tileSize * 0.2,
        ),
      ),
    );
    return super.onLoad();
  }
}
