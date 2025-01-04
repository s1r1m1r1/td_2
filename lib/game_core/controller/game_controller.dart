import 'package:bonfire/bonfire.dart' hide TileComponent;
import 'package:td_2/bloc/stage_stats_bloc.dart';
import 'package:td_2/bloc/stage_treasury_bloc.dart';
import 'package:td_2/domain/weapon_option.dart';
import 'package:td_2/game_core/controller/controller_process.dart';
import 'package:td_2/game_core/controller/timer_process.dart';
import 'package:td_2/game_core/controller/game_event.dart';
import 'package:td_2/game_core/decoration/common_sprite_sheet.dart';
import 'package:td_2/game_core/tile/tile_component.dart';

import '../../domain/stage_option.dart';
import '../mixin/clash.dart';
import '../mixin/radar.dart';
import '../unit/enemy/goblin.dart';
// import 'move_camera_mixin.dart';

class GameController extends GameComponent {
  GameController({
    required this.stage,
    required this.weapons,
    required this.stageStatsBloc,
    required this.stageTreasuryBloc,
  });

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

  final StageOption stage;
  final List<WeaponOption> weapons;
  final StageStatsBloc stageStatsBloc;
  final StageTreasuryBloc stageTreasuryBloc;

  static final _instructQ = <GameEvent>[];
  static void event(GameEvent event) {
    _instructQ.add(event);
  }

  @override
  Future<void> onLoad() async {
    // astarController.test();
    _instructQ.clear();
    game.add(
      FpsTextComponent(position: Vector2(0, 100)),
    );

    event(const GameEvent.createStage());
    // event(const GameEvent.enemySpawn());
    gameRef.camera
      ..moveTo(Vector2.all(200))
      ..moveOnlyMapArea = true;
    return super.onMount();
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
    final radars = game.query<MixinRadar>();
    final scans = game.query<Goblin>();

    for (final r in radars) {
      r.radarScan(scans);
    }
    final clashes = gameRef.query<MixinClash>();
    for (final c in clashes) {
      c.radarScan(scans);
    }
  }
}
