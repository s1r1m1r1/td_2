import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart' as flameExp;
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:logging/logging.dart';

import '../../domain/enums/enemy_type.dart';
import '../../domain/enums/tile_type.dart';
import '../../domain/weapon_option.dart';
import '../decoration/common_sprite_sheet.dart';
import '../other/priority.dart';
import '../other/stage_map.dart';
import '../tile/floor_component.dart';
import '../tile/floor_fx_controller.dart';
import '../unit/enemy/enemy.dart';
import '../unit/tower/towers.dart';
import 'astar_controller.dart';
import 'game_controller.dart';
import 'game_event.dart';
import 'timer_process.dart';

final _log = Logger(GameInstruction.loggerName);

abstract class GameInstruction {
  static const loggerName = 'GameInstruction';

  static FutureOr<void> process(
      GameEvent event, GameController controller) async {
    // var continueEvent = event;
    switch (event) {
      // case CreateStageGameEvent():
      //   final sprite = await CommonSpriteSheet.isoTile1;
      //   List.generate(10, (x) {
      //     List.generate(8, (y) {
      //       controller.game.world.add(SpriteComponent(
      //         position: Vector2(16.0 * x + (-16.0 * y), 8.0 * x + (8.0 * y)),
      //         size: Vector2(32, 48),
      //         sprite: sprite,
      //       ));
      //     });
      //   });
      case CreateStageGameEvent():
        _log.info('CreateStageGameEvent');
        controller.game.add(FloorFXController());
        astarController.init(
            controller.stage.layer.width, controller.stage.layer.height);
        for (final tileOption in controller.stage.layer.tiles) {
          late final FloorComponent tile;
          final image = await Flame.images.load(tileOption.assetPath);
          switch (tileOption.type) {
            case TileType.start:
              tile = StartGateFloorComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              );
            case TileType.end:
              tile = EndGateFloorComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              );
            case TileType.road:
              tile = RoadFloorComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              );
            case TileType.foundation:
              tile = FoundationFloorComponent(
                size: Vector2.all(StageMap.tileSize),
                position: StageMap.toRelative(tileOption.x, tileOption.y),
                gridPos: Point(tileOption.x, tileOption.y),
              );
          }
          tile.add(SpriteComponent.fromImage(image,
              size: tile.size, priority: Priority.tileOver));
          controller
            ..game.add(tile)
            ..game.world;

          final canvasSize = controller.game.canvasSize;
          controller.game.camera
              .setBounds(flameExp.Rectangle.fromRect(Rect.fromLTWH(
            0 + (canvasSize.x / 2),
            0 + (canvasSize.y / 2),
            -(canvasSize.x / 2),
            -(canvasSize.y / 2),
          )));
        }
      case EnemyGetDamagedGameEvent():
        _log.info('EnemyGetDamagedGameEvent');
      case SpawnOneGameEvent():
        _log.info('SpawnOneGameEvent');
        switch (event.type) {
          case EnemyType.goblin:
          case EnemyType.goblin2:
            if (controller.startGate == null) break;
            final goblin = Enemy(controller.startGate!.position);
            controller.game.world.add(goblin);
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
        final barriers = controller.game.query<FoundationFloorComponent>();
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
      case EnemyNextWaveGameEvent():
        _log.info('EnemyKilledGameEvent');
      case MovePointerGlobalGameEvent():
        final localPos = controller.game.camera.globalToLocal(event.position);
        final grids = controller.game.query<FloorComponent>();
        FloorComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(localPos);
          if (!isCover) continue;
          item = i;
          break;
        }
        final fx = controller.game.query<FloorFXController>().firstOrNull;
        if (item == null) {
          fx?.removeFX();
          break;
        }
        if (item case FoundationFloorComponent() when !item.hasTower) {
          fx?.setAllowedFX(pos: item.position, size: item.size);
        } else {
          fx?.setNotAllowedFX(pos: item.position, size: item.size);
        }
      case FinishPointerGlobalGameEvent():
        final localPos = controller.game.camera.globalToLocal(event.position);
        final fx = controller.game.query<FloorFXController>().firstOrNull;
        fx?.removeFX();
        final grids = controller.game.query<FoundationFloorComponent>();
        FoundationFloorComponent? item;
        // firstWhere
        for (final i in grids) {
          final isCover = i.isCover(localPos);
          if (!isCover) continue;
          item = i;
          break;
        }
        if (item == null) break;
        if (item.hasTower) {
          break;
        }
        final towerOption =
            controller.weapons.firstWhere((w) => w.id == event.id, orElse: () {
          return controller.weapons.first;
        });
        final tower = switch (towerOption) {
          $CannonWeaponOption() => CannonTower(position: item.position),
          $MissileWeaponOption() => MissileTower(position: item.position),
        };
        // debugPrint('SetDraggableGameEvent: SET ${event.position}');
        item.setTower(tower);
      case LabGameEvent():
      // final grids = controller.gameRef.query<FloorComponent>();
      // List.generate(
      //   1000,
      //   (i) {
      //     final tile = grids.elementAt(Random().nextInt(grids.length));
      //     tile.add(MissileTower(position: Vector2.zero()));
      //   },
      // );
    }
  }
}
