import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:td_2/controller/astar_mixin.dart';
import 'package:td_2/tile/file_fx_controller.dart';
import '../unit/base/goblin.dart';
import '../tile/stage_map.dart';
import 'game_event.dart';
import '../tile/tile_component.dart';

mixin GameInstruction on GameComponent {
  static const loggerName = 'GameInstruction';
  final _log = Logger(loggerName);
  FutureOr<void> process(GameEvent event) async {
    switch (event) {
      // Todo , with setting level
      case CreateStageGameEvent():
        _log.info('CreateStageGameEvent');
        final game = gameRef;
        game.add(TileFXController());
        astarController.init(10, 10);
        List.generate(10, (y) {
          return List.generate(10, (x) {
            final TileComponent tile = switch ((x, y)) {
              _ when x == 1 && y == 0 => StartGateTileComponent(
                  size: size,
                  position: StageMap.toRelative(x, y),
                  gridPos: Point(x, y),
                ),
              _ when x == 6 && y == 9 => EndGateTileComponent(
                  size: size,
                  position: StageMap.toRelative(x, y),
                  gridPos: Point(x, y)),
              _ when y < 1 => RoadTileComponent(
                  position: StageMap.toRelative(x, y),
                  size: Vector2.all(StageMap.tileSize),
                  gridPos: Point(x, y)),
              _ => FoundationTileComponent(
                  position: StageMap.toRelative(x, y),
                  size: Vector2.all(StageMap.tileSize),
                  gridPos: Point(x, y)),
            };
            // final unit = switch ((x, y)) {
            //   (int x, int y) when x > 1 && x < 9 && y > 1 && y < 9 =>
            //     Goblin(tile.position),
            //   _ => null
            // };

            game.add(tile);
            // if (unit != null) {
            //   game.add(unit);
            // }
          });
        });
      case EnemyGoGameEvent():
        final enemies = gameRef.query<Goblin>();
        final endGate = gameRef.query<EndGateTileComponent>().firstOrNull;
        if (endGate == null) break;
        for (final enemy in enemies) {
          final start = StageMap.toAstarPos(enemy.position);
          _log.warning("START $start G: ${endGate.gridPos}");
          try {
            final path = await astarController.findPath(
                start: start, end: endGate.gridPos);
            _log.warning("path $path:");
            enemy.moveSmart(path);
          } catch (error, stack) {
            _log.warning("What?",null,stack);
          }
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
      case EnemySpawnGameEvent():
        _log.info('EnemySpawnGameEvent');
      case EnemyMissedGameEvent():
        _log.info('EnemyMissedGameEvent');
      case EnemyKilledGameEvent():
        _log.info('EnemyKilledGameEvent ${event.mineValue}');
      // _log.info('EnemyKilledGameEvent');
      case EnemyNextWaveGameEvent():
        _log.info('EnemyKilledGameEvent');
      case MoveDragButtonGameEvent():
        _log.info('MoveDragButtonGameEvent');
        final grids = gameRef.query<TileComponent>();
        TileComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(event.position);
          _log.info('MoveDraggableGameEvent: isCover $isCover');
          if (!isCover) continue;
          item = i;
          _log.info('MoveDraggableGameEvent: isCover OK');
          break;
        }
        final fx = gameRef.query<TileFXController>().firstOrNull;
        if (item == null) {
          fx?.removeFX();
          break;
        }
        if (item case FoundationTileComponent() when !item.hasTower) {
          fx?.setAllowedFX(pos: item.position, size: item.size);
        } else {
          fx?.setNotAllowedFX(pos: item.position, size: item.size);
        }
      case FinishDragButtonGameEvent():
        debugPrint('FinishDragButtonGameEvent: pos ${event.position}');
        final fx = gameRef.query<TileFXController>().firstOrNull;
        fx?.removeFX();
        final grids = gameRef.query<FoundationTileComponent>();
        FoundationTileComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(event.position);
          // _log.info('SetDraggableGameEvent: isCover $isCover');
          if (!isCover) continue;
          item = i;
          // _log.info('SetDraggableGameEvent: isCover OK');
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
