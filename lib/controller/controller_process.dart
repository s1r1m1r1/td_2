import 'dart:math';

import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:td_2/tile/file_fx_controller.dart';
import '../unit/base/goblin.dart';
import '../tile/stage_map.dart';
import 'game_event.dart';
import '../tile/tile_component.dart';

mixin GameInstruction on GameComponent {
  static const loggerName = 'GameInstruction';
  final _log = Logger(loggerName);
  void process(GameEvent event) {
    switch (event) {
      // Todo , with setting level
      case CreateStageGameEvent():
        _log.info('CreateStageGameEvent');
        final game = gameRef;
        game.add(TileFXController());
        List.generate(10, (y) {
          return List.generate(10, (x) {
            final TileComponent tile = switch ((x, y)) {
              _ when x == 0 && y == 0 => StartGateTileComponent(
                  size: size,
                  position: StageMap.toRelative(x, y),
                  gridPos: Point(x, y),
                ),
              _ when x == 9 && y == 1 => EndGateTileComponent(
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
            final unit = switch ((x, y)) {
              (int x, int y) when x > 1 && x < 9 && y > 1 && y < 9 =>
                Goblin(tile.position),
              _ => null
            };

            game.add(tile);
            if (unit != null) {
              game.add(unit);
            }
          });
        });

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

// class GameInstruction {
//   GameEvent event;

//   GameInstruction(this.event);

//   Future<void> process(GameEvent event,GameController controller) async {
//     switch (event) {
//       case StartedGameEvent():
//         // controller.gameRef.started;
//         break;
//       case ResumedGameEvent():
//         controller.gameRef.resumeEngine();
//       case PausedGameEvent():
//         controller.gameRef.pauseEngine();
//       case WeaponBuildingGameEvent(:final component):
//         debugPrint('WEAPON BUILDING');
//         // hide
//         controller.repository.setSelectedWeapon(null);
//         // controller.gameRef.read<InventoryBloc>().add();
//         final weapon = WeaponComponent.create(
//             component.position, controller.repository.weaponTypeNotifier.value);
//         controller.add(weapon);
//         controller.buildingWeapon?.removeFromParent();
//         controller.buildingWeapon = weapon;
//         weapon.blockMap = weapon.collision(controller.gateStart) ||
//             weapon.collision(controller.gateEnd) ||
//             (await controller.gameRef.tileGridPlant
//                 .isBlockPath(weapon.position));
//       case WeaponSelectedGameEvent():
//         debugPrint('WEAPON SELECTED');
//         // hide
//         controller.repository.setSelectedWeapon(null);

//         // WeaponViewWidget.hide();
//         // controller.gameRef.weaponFactory.select(source as SingleWeaponView);
//         if (controller.buildingWeapon != null) {
//           controller.send(
//               GameEvent.weaponBuilding(component: controller.buildingWeapon!));
//         }
//       case WeaponUnSelectedGameEvent():
//         debugPrint('WEAPON UNSELECTED');
//         // hide
//         controller.repository.setSelectedWeapon(null);

//       case WeaponBuildDoneGameEvent(:final weapon):
//         debugPrint('WEAPON BUILDING DONE');
//         // controller.buildingWeapon.buildDone = true;
//         controller.onBuildDone(weapon);
//         controller.gameRef.tileGridPlant
//             .addBarrier(pos: weapon.position, tileSize: gameSetting.tileSize);
//         controller.buildingWeapon = null;
//         controller.processEnemySmartMove();
//       case WeaponBlockedGameEvent():
//         debugPrint('WEAPON BLOCKED');
//       case WeaponDestroyedGameEvent():
//         debugPrint('WEAPON DESTROYED');
//         // hide
//         final weapon = controller.repository.selectedWeaponSubject.value;
//         if (weapon == null) {
//           return;
//         }
//         debugPrint('WEAPON DESTROYED 2');
//         weapon.removeFromParent();
//         controller.onDestroy(weapon);
//         controller.repository.setSelectedWeapon(null);

//         controller.gameRef.tileGridPlant.removeBarrier(
//             pos: weapon.position, tileSize: gameSetting.tileSize);
//         controller.processEnemySmartMove();
//       case EnemySpawnGameEvent():
//         debugPrint('ENEMY SPAWN');
//         controller.enemyPlant.start();
//       case EnemyMissedGameEvent():
//         controller.repository.incrementMissed();

//       case EnemyKilledGameEvent(:final mineValue):
//         debugPrint('ENEMY KILLED');
//         controller.repository.incrementKilled();
//         controller.repository.addMinerals(mineValue);

//       case EnemyNextWaveGameEvent():
//         debugPrint('ENEMY NEXT WAVE');
//         controller.repository.incrementWave();

//       case WeaponShowActionGameEvent(:final weapon):
//         debugPrint('WEAPON SHOW ACTION');
//         // weapon.gameRef.camera.moveTo(weapon.position);
//         if (weapon.showed) {
//           return;
//         }
//         controller.repository.setSelectedWeapon(null);
//         controller.repository.setSelectedWeapon(weapon);
//         weapon.showMenu(
//             controller.repository, weapon.size, weapon.absolutePosition);
//       default:
//     }
//   }
// }
