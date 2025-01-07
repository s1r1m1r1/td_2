import 'package:flame/components.dart';
import 'package:flame/debug.dart';

import '../../bloc/stage_stats_bloc.dart';
import '../../bloc/stage_treasury_bloc.dart';
import '../../domain/stage_option.dart';
import '../../domain/weapon_option.dart';
import '../../game_dev.dart';
import '../mixin/clash/mixin_clash.dart';
import '../mixin/radar/mixin_radar.dart';
import '../tile/tile_component.dart';
import '../unit/enemy/enemy.dart';
import 'controller_process.dart';
import 'game_event.dart';
import 'timer_process.dart';

class GameController extends Component with HasGameReference<GameDev> {
  GameController({
    required this.stage,
    required this.weapons,
    required this.stageStatsBloc,
    required this.stageTreasuryBloc,
  });

  StartGateFloorComponent? _start;
  StartGateFloorComponent? get startGate {
    _start = game.query<StartGateFloorComponent>().firstOrNull;
    return _start;
  }

  EndGateFloorComponent? _end;
  EndGateFloorComponent get endGate {
    _end ??= game.query<EndGateFloorComponent>().first;
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
    game.addAll([
      FpsTextComponent(position: Vector2(0, 100))
        ..add(
          ChildCounterComponent<Enemy>(
              target: game.world, position: Vector2(0, 40)),
        ),
      // TextGameComponent(text: text, position: position)
    ]);

    event(const GameEvent.createStage());
    event(const GameEvent.enemySpawn());
    game.camera.moveTo(Vector2.all(200));
    // ..moveOnlyMapArea = true;
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
    final scans = game.query<Enemy>().toList();

    for (final r in radars) {
      r.radarScan(scans);
    }
    final clashes = game.query<MixinClash>();
    for (final c in clashes) {
      c.clashScan(scans);
    }
  }
}
