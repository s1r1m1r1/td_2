import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';

import '../../render/priority.dart';
import '../../tile/stage_map.dart';
import '../../decoration/common_sprite_sheet.dart';
import 'enemy_sprite_sheet.dart';
import 'enemy_unit.dart';


class Goblin extends ScannableEnemy with UseLifeBar {
static const loggerName = 'Goblin';
static final _log = Logger(loggerName);
  bool active = true;
  Goblin(Vector2 position)
      : super(
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          position: position,
          size: Vector2.all(StageMap.tileSize * 0.8),
          speed: StageMap.tileSize,
          life: 100,
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
    super.update(dt);
    if (!gameRef.sceneBuilderStatus.isRunning) {
      // seeAndMoveToPlayer(
      //   radiusVision: StageMap.tileSize,
      //   closePlayer: (p) {
      //     execAttack(attack);
      //   },
      //   notObserved: () {
      //     seeAndMoveToAttackRange(
      //       minDistanceFromPlayer: StageMap.tileSize * 2,
      //       useDiagonal: false,
      //       positioned: (p) {
      //         execAttackRange(attack);
      //       },
      //       radiusVision: StageMap.tileSize * 3,
      //       notObserved: () {
      //         runRandomMovement(
      //           dt,
      //           speed: speed / 2,
      //           maxDistance: (StageMap.tileSize * 3),
      //         );
      //         return false;
      //       },
      //     );
      //     return false;
      //   },
      // );
    }
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

  void execAttack(double damage) {
    if (gameRef.player != null && gameRef.player?.isDead == true) return;
    // simpleAttackMelee(
    //   size: Vector2.all(width),
    //   damage: damage / 2,
    //   interval: 400,
    //   sizePush: StageMap.tileSize / 2,
    //   animationRight: CommonSpriteSheet.blackAttackEffectRight,
    // );
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
