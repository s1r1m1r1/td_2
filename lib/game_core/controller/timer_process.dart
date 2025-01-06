// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../domain/enums/enemy_type.dart';
import 'game_controller.dart';
import 'game_event.dart';

final _log = Logger(TimerProcess.loggerName);

abstract class TimerProcess extends Component {
  static const loggerName = 'TimerController';
  void process(double dt);
}

class EnemySpawnController extends TimerProcess {
  EnemySpawnController({
    required this.type,
    required this.count,
    bool shouldFirstRun = true,
    required this.interval,
  }) {
    _shouldFirstRun = shouldFirstRun;
    _timer = Timer(
      interval,
      repeat: true,
      onTick: onTick,
    );
  }
  final EnemyType type;
  ///  per second
  final double interval;
  late bool _shouldFirstRun;
  int count;
  late final Timer _timer;

  @override
  void process(double dt) {
    if (_shouldFirstRun) {
      _shouldFirstRun = false;
      onTick();
    }
    _timer.update(dt);
  }

  void onTick() {
    debugPrint(' UNITS remained $count');
    if (count < 1) {
      removeFromParent();
      return;
    }
    count -= 1;
    GameController.event(GameEvent.spawnOne(type));
  }
}

class WaveSpawnController extends TimerProcess {
  WaveSpawnController({
    required this.interval,
    required this.index,
    required this.max,
    bool shouldFirstRun = true,
  }) {
    _shouldFirstRun = shouldFirstRun;
    _timer = Timer(
      interval,
      repeat: true,
      onTick: onTick,
    );
  }
  ///  per second
  final double interval;
  int index;
  final int max;
  bool _shouldFirstRun = false;
  late final Timer _timer;

  @override
  void process(double dt) {
    if (_shouldFirstRun) {
      _shouldFirstRun = false;
      onTick();
    }
    _timer.update(dt);
  }

  void onTick() {
    // _log.info("waveInterval checked");
    // debugPrint('WAVE $index');
    if (index <= max) {
      debugPrint('WAVE LESS $index $max');
      GameController.event(GameEvent.nextWave(index));
      index += 1;
      return;
    }

    // debugPrint('WAVE REMOVE');
    removeFromParent();
  }
}
