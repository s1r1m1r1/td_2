import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';
import 'package:td_2/game_core/mixin/clash.dart';
import 'package:td_2/game_core/mixin/radar.dart';

import '../../mixin/mixin_movable.dart';
import '../../other/priority.dart';
import '../../tile/stage_map.dart';
import '../../decoration/common_sprite_sheet.dart';
import 'enemy_id.dart';
import 'enemy_sprite_sheet.dart';
import 'enemy_unit.dart';

final _log = Logger(Goblin.loggerName);

class Goblin extends ScannableEnemy
    with
        UseLifeBar,
        MixinMovable,
        MixinClashTarget,
        MixinRadarTarget,
        Lighting {
  static const loggerName = 'Goblin';
  bool active = true;
  late final EnemyId id;
  Goblin(Vector2 position)
      : super(
          futureAnim: EnemySpriteSheet.runLeft,
          position: position,
          size: Vector2.all(StageMap.tileSize * 0.8),
          speed: StageMap.tileSize,
          life: 100,
        ) {
    setupLifeBar(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
    );
    id = EnemyId.newId();
    setupLighting(
        LightingConfig(radius: 100.0, color: Colors.yellow.withAlpha(10)));
  }
  @override
  Future<void> onLoad() {
    // gameRef.addAll([
    // ...List.generate(
    //     50,
    //     (i) => CircleComponent(
    //           paint: Paint()..color = Colors.red,
    //           position: position,
    //           radius: size.x,
    //         ))
    // ]);
    return super.onLoad();
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

  @override
  void onClash(dynamic value) {
    debugPrint('onClash i: ${value.runtimeType} ');
    if (isDead) return;
    if (value is double) {
      debugPrint('onClash ok');
      _removeLife(value);
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
      _log.info("Path from: $position to $to");
      super.moveFromTo(
          from: from, to: to, onFinish: pathNextMove, fixedAngle: 0.0);
    }
  }

  @override
  double health = 100;
}
