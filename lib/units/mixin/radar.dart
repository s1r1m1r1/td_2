import 'package:bonfire/bonfire.dart';
// import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../base/goblin.dart';

typedef RadarScanCallback = void Function(GameComponent c);

enum RadarMode { findBest, findFirst, disable }

mixin Radar on PositionComponent {
  static const loggerName = 'Radar';
  static final _log = Logger(loggerName);
  bool _radarOn = true;
  RadarMode mode = RadarMode.findBest;

  double damage = 0;
  double distScan = 1000;
  late double _bestDistance = distScan;

  RadarScanCallback? radarScanAlert;

  set radarOn(bool i) {
    _radarOn = i;
  }

  bool get radarOn => _radarOn;

  void radarScan(Iterable<Goblin> targets) {
    _findBestTarget(targets.toList());
  }

  void _findBestTarget(List<Goblin> targets) {
    if (radarScanAlert == null) return;
    if (radarOn) {
      _bestTarget = null;
      _bestDistance = distScan;
      _checkDistance(targets);
    }
  }

  Goblin? _bestTarget;

  void _checkDistance(List<Goblin> targets) {
    if (targets.isEmpty) return;
    bool stop = false;
    final centerRadar = position + (size / 2);
    for (var i = 0; i < targets.length; i++) {
      if (stop) break;
      final t = targets[i];
      final tPos = t.position + (t.size / 2);
      // final tCollisionSize = (t.size.x + t.size.y) + 1;
      // double collisionRange = tCollisionSize + distScan;
      final double distance = centerRadar.distanceTo(tPos);
      // debugPrint('targetPosition : $tPos');
      // debugPrint('targetColSize : $tCollisionSize');
      // debugPrint('collisionRange : $collisionRange');
      // debugPrint('distance : $distance');
      // debugPrint('bestDistance : $_bestDistance');
      if (distance <= distScan) {
        switch (mode) {
          case RadarMode.findBest:
            if (!(distance < _bestDistance)) continue;
            _log.info('findBest $i');
            _bestDistance = distance;
            _bestTarget = t;
          case RadarMode.findFirst:
            _log.info('findFirst $i');
            _bestTarget = t;
            stop = true;
          case RadarMode.disable:
            _log.info('disable');
            break;
        }
      }
    }
    if (_bestTarget != null) {
      _log.info('radarScanAlert');
      radarScanAlert?.call(_bestTarget!);
      _bestTarget = null;
    }
  }

  bool collision(Vector2 center, double dist, Goblin target) {
    final Vector2 targetPosition = target.position;
    final double targetCollisionSize = target.size.x + target.size.y;
    double collisionRange = targetCollisionSize + dist;
    final double distance = position.distanceTo(targetPosition);
    if (distance < collisionRange) {
      return true;
    }
    return false;
  }
}
