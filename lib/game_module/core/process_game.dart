import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart' as flameExp;
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:logging/logging.dart' show Logger;

import '../../bloc/stage_stats_bloc.dart';
import '../../bloc/stage_treasury_bloc.dart';
import '../../domain/enums/enemy_type.dart';
import '../../domain/enums/tile_type.dart';
import '../../domain/stage_option.dart';
import '../../domain/weapon_option.dart';
import '../controller/astar_controller.dart';
import '../controller/game_event.dart';
import '../controller/timer_process.dart';
import '../mixin/clash/mixin_clash.dart';
import '../mixin/radar/mixin_radar.dart';
import '../other/priority.dart';
import '../other/stage_map.dart';
import '../tile/cursor/cursor.dart';
import '../tile/floor_component.dart';
import '../tile/floor_fx_controller.dart';
import '../unit/enemy/enemy.dart';
import '../unit/tower/towers.dart';
import 'base_game.dart';

final _log = Logger(ProcessGame.loggerName);

class ProcessGame extends BaseGame {
  ProcessGame({
    super.components,
    super.hudComponents,
    required this.weapons,
    super.background,
    super.debugMode,
    super.cameraConfig,
    required this.stage,
    required this.stageStatsBloc,
    required this.stageTreasuryBloc,
    required this.audioPlayer,
  });
  static const loggerName = 'GameInstruction';

  final StageStatsBloc stageStatsBloc;
  final StageTreasuryBloc stageTreasuryBloc;
  FloorFXController? floorFXController;

  final StageOption stage;
  final List<WeaponOption> weapons;

  CursorComponent? cursor;
  // HudCurrentFloor? currentFloor;
  AstarController? astar;
  final AudioPlayer audioPlayer;

  // HudCurrentFloor? get hudCurrentFloor => camera.viewport.children.query<HudCurrentFloor>().firstOrNull;
  StartGateFloorComponent? _start;
  StartGateFloorComponent? get startGate {
    _start = world.children.query<StartGateFloorComponent>().firstOrNull;
    return _start;
  }

  EndGateFloorComponent? _end;
  EndGateFloorComponent get endGate {
    _end ??= world.children.query<EndGateFloorComponent>().first;
    return _end!;
  }

  @override
  void onMount() {
    super.onMount();
    addEvent(const GameEvent.createStage());
    addEvent(const GameEvent.enemySpawn());
  }

  @override
  Future<void> onLoad() async {
    // astarController.test();
    await super.onLoad();
    instructQ.clear();

    camera.moveTo(Vector2.all(200));
  }

  Future<void> _processInstruction() async {
    Flame.images.prefix = '';
    while (instructQ.isNotEmpty) {
      final event = instructQ.removeLast();
      switch (event) {
        case CreateStageGameEvent():
          _log.info('CreateStageGameEvent');
          world.add(FloorFXController(position: StageMap.toRelative(0, 0)));
          astarController.init(stage.layer.width, stage.layer.height);
          for (final tileOption in stage.layer.tiles) {
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
            tile.add(SpriteComponent.fromImage(image, size: tile.size, priority: Priority.tileOver));

            world.add(tile);
            camera.setBounds(flameExp.Rectangle.fromRect(Rect.fromLTWH(
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
            debugPrint('START GATE $startGate');
              if (startGate == null) break;
              final goblin = Enemy(
                position: StageMap.toRelative(0, 0),
              );
              world.add(goblin);
              addEvent(GameEvent.enemyGo(goblin));
          }
        case EnemySpawnGameEvent():
          int count = stage.waves.length;

          addAll([
            WaveSpawnController(
                interval: const Duration(seconds: 10).inSeconds.toDouble(),
                index: 0,
                max: count)
          ]);

        case NextWaveGameEvent():
          if (event.index > (stage.waves.length - 1)) break;
          final wave = stage.waves[event.index];

          add(EnemySpawnController(
              type: wave.enemyType,
              count: wave.count,
              interval: wave.unitInterval.inSeconds.toDouble()));

          _log.info('EnemySpawnGameEvent');

        case EnemyGoGameEvent():
          _log.info('EnemyGoGameEvent');
          final start = StageMap.toAstarPos(event.enemy.position);
          final barriers = world.children.query<FoundationFloorComponent>();
          astarController.clearBarriers();
          astarController
              .addAllBarrier(barriers.map((i) => i.gridPos).toList());
          try {
            final path = await astarController.findPath(
                start: start, end: endGate.gridPos);
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
          final localPos = camera.globalToLocal(event.position);
          final grids = world.children.query<FloorComponent>();
          FloorComponent? item;
          // firstWhere
          for (final i in grids) {
            final isCover = i.isCover(localPos);
            if (!isCover) continue;
            item = i;
            break;
          }
          final fx = world.children.query<FloorFXController>().firstOrNull;
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
          final localPos = camera.globalToLocal(event.position);
          final fx = world.children.query<FloorFXController>().firstOrNull;
          debugPrint('FINISH $localPos ${fx}');
          fx?.removeFX();
          final grids = world.children.query<FoundationFloorComponent>();

          debugPrint('FINISH grids  ${grids.length}');
          FoundationFloorComponent? item;
          // firstWhere
          for (final i in grids) {
            final isCover = i.isCover(localPos);
            if (!isCover) continue;
            item = i;
            break;
          }
          debugPrint('FINISH item  ${item}');
          if (item == null) break;

          if (item.hasTower) {
            break;
          }
          final towerOption =
              weapons.firstWhere((w) => w.id == event.id, orElse: () {
            return weapons.first;
          });
          final tower = switch (towerOption) {
            $CannonWeaponOption() => CannonTower(position: item.position,),
            $MissileWeaponOption() => MissileTower(position: item.position),
          };
          debugPrint('SetDraggableGameEvent: SET ${event.position}');
          item.setTower(tower);
        case LabGameEvent():
          break;
        case OnTapDownGE():
          // TODO: Handle this case.
          throw UnimplementedError();
        case OnTapUpGE():
          // TODO: Handle this case.
          throw UnimplementedError();
        case OnDragUpdateGE():
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }
  }

  @override
  void update(double dt) {
    _processInstruction();
    _processRadarScan();
    _processTimers(dt);
    super.update(dt);
  }

  void _processTimers(double dt) {
    /// add other controller as children
    /// i think it's good
    final timers = children.whereType<TimerProcess>();
    for (var t in timers) {
      t.process(dt);
    }
  }

  void _processRadarScan() {
    final radars = world.children.query<MixinRadar>();
    final scans = world.children.query<Enemy>().toList();

    for (final r in radars) {
      r.radarScan(scans);
    }
    final clashes = world.children.query<MixinClash>();
    for (final c in clashes) {
      c.clashScan(scans);
    }
  }
}
