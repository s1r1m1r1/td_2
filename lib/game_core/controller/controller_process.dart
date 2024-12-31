import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:td_2/bloc/stage_bloc.dart';
import 'package:td_2/domain/wave_option.dart';
import 'package:td_2/game_core/controller/astar_controller.dart';
import 'package:td_2/game_core/controller/timer_process.dart';
import 'package:td_2/game_core/controller/game_controller.dart';
import 'package:td_2/domain/enums/enemy_type.dart';
import 'package:td_2/game_core/tile/file_fx_controller.dart';
import '../tile/stage_map.dart';
import '../unit/enemy/goblin.dart';
import 'game_event.dart';
import '../tile/tile_component.dart';

final _log = Logger(GameInstruction.loggerName);

abstract class GameInstruction {
  static const loggerName = 'GameInstruction';

  static FutureOr<void> process(
      GameEvent event, GameController controller) async {
    var continueEvent = event;
    switch (event) {
      // Todo , with setting level
      case CreateStageGameEvent():
        _log.info('CreateStageGameEvent');
        controller.game.add(TileFXController());
        astarController.init(10, 10);
        final grounds = <Tile>[];
        List.generate(10, (y) {
          return List.generate(10, (x) {
            final TileComponent tile = switch ((x, y)) {
              _ when x == 1 && y == 0 => StartGateTileComponent(
                  size: Vector2.all(StageMap.tileSize),
                  position: StageMap.toRelative(x, y),
                  gridPos: Point(x, y),
                ),
              _ when x == 6 && y == 9 => EndGateTileComponent(
                  size: Vector2.all(StageMap.tileSize),
                  position: StageMap.toRelative(x, y),
                  gridPos: Point(x, y)),
              _ when x.isEven || y.isOdd => RoadTileComponent(
                  position: StageMap.toRelative(x, y),
                  size: Vector2.all(StageMap.tileSize),
                  gridPos: Point(x, y)),
              _ => FoundationTileComponent(
                  position: StageMap.toRelative(x, y),
                  size: Vector2.all(StageMap.tileSize),
                  gridPos: Point(x, y)),
            };
            grounds.add(
              Tile(
                sprite: TileSprite(path: StageMap.floor_1),
                x: x.toDouble(),
                y: y.toDouble(),
                width: StageMap.tileSize,
                height: StageMap.tileSize,
              ),
            );
            // final unit = switch ((x, y)) {
            //   (int x, int y) when x > 1 && x < 9 && y > 1 && y < 9 =>
            //     Goblin(tile.position),
            //   _ => null
            // };

            controller.game.add(tile);
            final towerType = switch ((x, y)) {
              (3, 6) || (5, 5) => TowerType.missile,
              _ => null
            };
            if (towerType != null && tile is FoundationTileComponent) {
              tile.setTower(towerType);
            }

            // if (unit != null) {
            //   game.add(unit);
            // }
          });
        });
        _log.warning('add Layer ${grounds.length}');
      // controller.game.map.refreshMap();
      // addLayer(Layer(id: 1, tiles: grounds));

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
        debugPrint('SPAWn  EVETnt');
        int count = controller.stage.waves.length;

        controller.addAll([
          WaveSpawnController(
              interval: const Duration(seconds: 10).inSeconds.toDouble(),
              index: 0,
              max: count)
        ]);

        _log.info('EnemySpawnGameEvent');
      case NextWaveGameEvent():
        debugPrint('NEXT WAVE EVETnt');
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
        item.setTower(TowerType.missile);
    }
  }
}
