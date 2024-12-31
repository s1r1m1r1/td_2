import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:td_2/bloc/stage_bloc.dart';
import 'package:td_2/bloc/stage_stats_bloc.dart';
import 'package:td_2/bloc/stage_treasury_bloc.dart';
import 'package:td_2/controller/controller_process.dart';
import 'package:td_2/controller/enemy_spawn_mixin.dart';
import 'package:td_2/controller/game_event.dart';
import 'package:td_2/tile/tile_component.dart';

import '../unit/base/goblin.dart';
import '../unit/mixin/clash.dart';
import '../unit/mixin/radar.dart';
// import 'move_camera_mixin.dart';

class GameController extends GameComponent with EnemySpawnMixin {
  GameController({
    required this.stageBloc,
    required this.stageStatsBloc,
    required this.stageTreasuryBloc,
  }) {
    stageBloc.add(const StageEvent.read());
  }

  late final game = gameRef;
  StartGateTileComponent? _start;
  StartGateTileComponent get startGate {
    _start ??= game.query<StartGateTileComponent>().first;
    return _start!;
  }

  EndGateTileComponent? _end;
  EndGateTileComponent get endGate {
    _end ??= game.query<EndGateTileComponent>().first;
    return _end!;
  }

  final StageBloc stageBloc;
  final StageStatsBloc stageStatsBloc;
  final StageTreasuryBloc stageTreasuryBloc;

  static final _instructQ = <GameEvent>[];
  static void event(GameEvent event) {
    _instructQ.add(event);
  }

  @override
  void onMount() {
    // astarController.test();
    event(const GameEvent.createStage());
    event(const GameEvent.enemySpawn());
    gameRef.camera
      ..moveTo(Vector2.all(200))
      ..moveOnlyMapArea = true;
    super.onMount();
  }

  void _processInstruction() {
    while (_instructQ.isNotEmpty) {
      final event = _instructQ.removeLast();
      GameInstruction.process(event, this);
    }
  }

  @override
  void update(double dt) {
    _processInstruction();
    _processRadarScan();
    processEnemySpawn(dt);
    // if (checkInterval('check_living_enemies', 500, dt)) {
    //   if (game.query<Goblin>().length < 3) {
    //     _addEnemyInWorld();
    //     // event(const GameEvent.enemyGo());
    //   }
    // }
    super.update(dt);
  }

  void _addEnemyInWorld() {
    final tiles = gameRef.query<StartGateTileComponent>();
    if (tiles.isNotEmpty) {
      final goblin = Goblin(position);
      game.addAll([Goblin(tiles.first.position)]);
      event(GameEvent.enemyGo(goblin));
    }
  }

  void _processRadarScan() {
    final radars = game.query<Radar>();
    final scans = game.query<Goblin>();

    for (final r in radars) {
      r.radarScan(scans);
    }
    final clashes = gameRef.query<Clash>();
    for (final c in clashes) {
      c.radarScan(scans);
    }
  }
}
