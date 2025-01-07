import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';

import '../../../game_dev.dart';
import '../../decoration/common_sprite_sheet.dart';
import '../../mixin/clash/mixin_clash_target.dart';
import '../../mixin/mixin_movable.dart';
import '../../mixin/radar/mixin_radar_target.dart';
import '../../mixin/unit/mixin_fx_damage.dart';
import '../../other/priority.dart';
import '../../tile/stage_map.dart';
import 'enemy_id.dart';
import 'enemy_sprite_sheet.dart';
import 'enemy_unit.dart';
import 'health.dart';
import 'life_bar.dart';

final _log = Logger(Goblin.loggerName);

final class Goblin extends ScannableEnemy
    with
        MixinClashTarget,
        MixinRadarTarget,
        MixinHealth,
        MixinMovable,
        UseHealthBar,
        MixinFxDamage,
        HasGameReference<GameDev> {
  static const loggerName = 'Goblin';
  bool active = true;
  late final EnemyId id;
  Goblin(Vector2 position)
      : super(
          futureAnim: EnemySpriteSheet.runLeft,
          position: position,
          size: Vector2.all(StageMap.tileSize * 0.8),
        ) {
    speed = StageMap.tileSize;
    id = EnemyId.newId();
  }

  @override
  void onMount() {
    super.setHealth(123);
    super.setupHealthBar();
    super.onMount();
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
    add(fxDamage(
      life,
      config: TextStyle(
        fontSize: width / 2,
        color: Colors.white,
      ),
    ));
    subtractHealth(life);
    if (isDead) onDie();
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

  void onDie() {
    game.add(
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
}
