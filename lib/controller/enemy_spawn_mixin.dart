import 'dart:collection';

import 'package:bonfire/bonfire.dart';
import 'package:logging/logging.dart';
import 'package:td_2/controller/game_controller.dart';
import 'package:td_2/controller/game_event.dart';
import 'package:td_2/domain/enums/enemy_type.dart';

import '../domain/wave.dart';

final _log = Logger(EnemySpawnMixin.loggerName);

mixin EnemySpawnMixin on GameComponent {
  static const loggerName = 'EnemySpawnMixin';
  var waves = Queue<Wave>();
  var units = Queue<MapEntry<int, EnemyType>>();
  int? waveInterval;
  int? enemyInterval;

  void processEnemySpawn(double dt) {
    if (waveInterval == null && waves.isNotEmpty) {
      _log.info("waveInterval == null && isNotEmpty");
      final wave = waves.removeFirst();
      waveInterval = wave.nextWave.inMilliseconds;
      units.addAll(
        List.generate(
          wave.count,
          (i) => MapEntry(wave.unitInterval.inMilliseconds, wave.enemyType),
        ),
      );
    }
    if (waveInterval != null) {
      // _log.info("waveInterval != null");
      if (checkInterval('check next wave', waveInterval!, dt)) {
        _log.info("waveInterval checked");
        // resetWaveInterval = true;
        if (units.isEmpty) return;
        _log.info("waveInterval checked unit");
        final enemy = units.removeLast();
        enemyInterval = enemy.key;
        GameController.event(GameEvent.spawnOne(enemy.value));
      }
    }
  }

  // void setWave() {
  //   if (wave == null && nextWaves.isNotEmpty) {
  //     wave = nextWaves.removeLast();
  //   }
  // }
}
