// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'package:td_2/domain/enums/enemy_type.dart';
import 'package:td_2/game_core/controller/game_controller.dart';
import 'package:td_2/game_core/controller/game_event.dart';

final _log = Logger(TimerProcess.loggerName);

mixin TimerProcess on GameComponent {
  static const loggerName = 'TimerController';
  void process(double dt);
}

class EnemySpawnController extends GameComponent with TimerProcess {
  EnemySpawnController({
    required this.type,
    required this.count,
    required this.interval,
  });
  final EnemyType type;
  final int interval;
  int count;

  @override
  void process(double dt) {
    if (checkInterval('check next unit', interval, dt)) {
      _log.info("waveInterval checked");
      debugPrint(' UNITS remained $count');
      if (count < 1) {
        removeFromParent();
        return;
      }
      count -= 1;
      GameController.event(GameEvent.spawnOne(type));
    }
  }
}

class WaveSpawnController extends GameComponent with TimerProcess {
  WaveSpawnController({
    required this.interval,
    required this.index,
    required this.max,
  });
  final int interval;
  int index;
  final int max;

  @override
  void process(double dt) {
    if (checkInterval('check next wave', interval, dt)) {
      _log.info("waveInterval checked");
      debugPrint('WAVE $index');
      if (index <= max) {

      debugPrint('WAVE LESS $index $max');
        GameController.event(GameEvent.nextWave(index));
        index += 1;
        return;
      }

      debugPrint('WAVE REMOVE');
      removeFromParent();
    }
  }
}
