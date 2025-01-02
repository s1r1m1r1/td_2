import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:logging/logging.dart';
import 'package:td_2/domain/enums/tile_type.dart';
import 'package:td_2/game_core/controller/astar_controller.dart';
import 'package:td_2/game_core/controller/timer_process.dart';
import 'package:td_2/game_core/controller/game_controller.dart';
import 'package:td_2/domain/enums/enemy_type.dart';
import 'package:td_2/game_core/tile/file_fx_controller.dart';
import '../tile/stage_map.dart';
import '../unit/enemy/goblin.dart';
import '../unit/tower/towers.dart';
import 'game_event.dart';
import '../tile/tile_component.dart';

final _log = Logger(GameInstruction.loggerName);

abstract class GameInstruction {
  static const loggerName = 'GameInstruction';

  static FutureOr<void> process(
      GameEvent event, GameController controller) async {
    // var continueEvent = event;
    switch (event) {
      case CreateStageGameEvent():
        _log.info('CreateStageGameEvent');
        controller.game.add(TileFXController());
        astarController.init(
            controller.stage.layer.width, controller.stage.layer.height);
        for (final tileOption in controller.stage.layer.tiles) {
          switch (tileOption.type) {
            case TileType.start:
              controller.game.add(StartGateTileComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              ));
            case TileType.end:
              controller.game.add(EndGateTileComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              ));
            case TileType.road:
              controller.game.add(RoadTileComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              ));
            case TileType.foundation:
              controller.game.add(FoundationTileComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              ));
          }
        }
      case EnemyGetDamagedGameEvent():
        _log.info('EnemyGetDamagedGameEvent');
      case SpawnOneGameEvent():
        _log.info('SpawnOneGameEvent');
        switch (event.type) {
          case EnemyType.goblin:
          case EnemyType.goblin2:
            final goblin = Goblin(controller.startGate.position);
            controller.game.add(goblin);
            GameController.event(GameEvent.enemyGo(goblin));
        }
      case EnemySpawnGameEvent():
        int count = controller.stage.waves.length;

        controller.addAll([
          WaveSpawnController(
              interval: const Duration(seconds: 10).inSeconds.toDouble(),
              index: 0,
              max: count)
        ]);

      case NextWaveGameEvent():
        if (event.index > (controller.stage.waves.length - 1)) break;
        final wave = controller.stage.waves[event.index];

        controller.add(EnemySpawnController(
            type: wave.enemyType,
            count: wave.count,
            interval: wave.unitInterval.inSeconds.toDouble()));

        _log.info('EnemySpawnGameEvent');

      case EnemyGoGameEvent():
        _log.info('EnemyGoGameEvent');
        final start = StageMap.toAstarPos(event.enemy.position);
        final barriers = controller.game.query<FoundationTileComponent>();
        astarController.clearBarriers();
        astarController.addAllBarrier(barriers.map((i) => i.gridPos).toList());
        try {
          final path = await astarController.findPath(
              start: start, end: controller.endGate.gridPos);
          _log.warning("path $path:");
          event.enemy.moveSmart(path);
        } catch (error, stack) {
          _log.warning("What?", null, stack);
        }
      case PausedGameEvent():
        _log.info('PausedGameEvent');
      case ResumedGameEvent():
        _log.info('ResumeGameEvent');
      case WeaponBuildingGameEvent():
        _log.info('WeaponBuildingGameEvent');
      case WeaponSelectedGameEvent():
        _log.info('WeaponSelectedGameEvent');
      case WeaponUnSelectedGameEvent():
        _log.info('WeaponUnSelectedGameEvent');
      case WeaponBuildDoneGameEvent():
        _log.info('WeaponBuildDoneGameEvent');
      case WeaponDestroyedGameEvent():
        _log.info('WeaponDestroyedGameEvent');
      case WeaponBlockedGameEvent():
        _log.info('WeaponBlockedGameEvent');
      case WeaponShowActionGameEvent():
        _log.info('WeaponShowActionGameEvent');
      case WeaponShowProfileGameEvent():
        _log.info('WeaponShowProfileGameEvent');

      case EnemyMissedGameEvent():
        _log.info('EnemyMissedGameEvent');
      case EnemyKilledGameEvent():
        _log.info('EnemyKilledGameEvent ${event.mineValue}');
      // _log.info('EnemyKilledGameEvent');
      case EnemyNextWaveGameEvent():
        _log.info('EnemyKilledGameEvent');
      case MovePointerGlobalGameEvent():
        final localPos = controller.game.camera.globalToLocal(event.position);
        final grids = controller.gameRef.query<TileComponent>();
        TileComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(localPos);
          if (!isCover) continue;
          item = i;
          break;
        }
        final fx = controller.gameRef.query<TileFXController>().firstOrNull;
        if (item == null) {
          fx?.removeFX();
          break;
        }
        if (item case FoundationTileComponent() when !item.hasTower) {
          fx?.setAllowedFX(pos: item.position, size: item.size);
        } else {
          fx?.setNotAllowedFX(pos: item.position, size: item.size);
        }
      case FinishPointerGlobalGameEvent():
        final localPos = controller.game.camera.globalToLocal(event.position);
        final fx = controller.gameRef.query<TileFXController>().firstOrNull;
        fx?.removeFX();
        final grids = controller.gameRef.query<FoundationTileComponent>();
        FoundationTileComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(localPos);
          if (!isCover) continue;
          item = i;
          break;
        }
        if (item == null) break;
        if (item.hasTower) {
          item.removeTower();
          break;
        }
        // debugPrint('SetDraggableGameEvent: SET ${event.position}');
        item.setTower(MissileTower(position: Vec2.zero));
    }
  }
}
