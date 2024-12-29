import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'game_event.dart';
import '../world/grid_component.dart';

final _log = Logger('GameInstruction');

mixin GameInstruction on GameComponent {
  void process(GameEvent event) {
    switch (event) {
      case StartedGameEvent():
        _log.info('StartedGameEvent');
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
      case SetDraggableGameEvent():
        debugPrint('SetDraggableGameEvent: pos ${event.position}');
        final grids = gameRef.query<GridTileComponent>();
        GridTileComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(event.position);
          _log.info('SetDraggableGameEvent: isCover $isCover');
          if (!isCover) continue;
          item = i;
          _log.info('SetDraggableGameEvent: isCover OK');
          break;
        }
        if (item == null) break;
        if(item.hasTower){
          item.removeTower();
          break;
        }
        debugPrint('SetDraggableGameEvent: SET ${event.position}');
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
