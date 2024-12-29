
import 'package:bonfire/bonfire.dart';
import 'package:td_2/world/grid_component.dart';

import '../unit/base/enemy_unit.dart';
import '../unit/base/goblin.dart';
import '../unit/mixin/clash.dart';
import '../unit/mixin/radar.dart';
import 'controller_process.dart';
import 'move_camera_mixin.dart';
import 'static_controller.dart';

class GameManualController extends GameComponent
    with MoveCameraMixin, GameInstruction {
  @override
  void onMount() {
    gameRef.camera
      ..moveTo(Vector2.all(200))
      ..moveOnlyMapArea = true;
    super.onMount();
  }

  void _processInstruction() {
    while (staticController.instructQ.isNotEmpty) {
      final event = staticController.instructQ.removeLast();
      process(event);
    }
  }

  @override
  void update(double dt) {
    _processInstruction();
    _processRadarScan();
    if (checkInterval('check_living_enemies', 500, dt)) {
      if (gameRef.query<ScannableEnemy>().length < 3) {
        _addEnemyInWorld();
      }
    }
    super.update(dt);
  }

  void _addEnemyInWorld() {
    final tiles = gameRef.query<GridTileComponent>();
    gameRef.addAll([...tiles.map((i) => Goblin(i.position))]);
  }

  void _processRadarScan() {
    final radars = gameRef.query<Radar>();
    final scans = gameRef.query<Goblin>();

    for (final r in radars) {
      r.radarScan(scans);
    }
    final clashes = gameRef.query<Clash>();
    for (final c in clashes) {
      c.radarScan(scans);
    }
  }
}
