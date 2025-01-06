// import 'package:bonfire/bonfire.dart';
import 'package:flame/components.dart';
import 'package:logging/logging.dart';

import 'mixin_radar_config.dart';
import 'mixin_radar_target.dart';

final _log = Logger(MixinRadar.loggerName);

typedef RadarScanCallback = void Function(MixinRadarTarget component);

typedef RadarInit = void Function(RadarMode value);

mixin MixinRadar on PositionComponent {
  static const loggerName = 'Radar';
  abstract MixinRadarConfig radarConfig;
  RadarMode get _radarMode => radarConfig.radarMode;
  bool get _radarOn => radarConfig.radarOn;
  double get _distScan => radarConfig.distScan;
  late double _bestDistance = _distScan;

  // RadarScanCallback? radarScanAlert;
  void onRadar(MixinRadarTarget component);

  set radarOn(bool i) {
    radarConfig = radarConfig.copyWith(radarOn: i);
  }

  void radarScan(List<MixinRadarTarget> targets) {
    _findBestTarget(targets);
  }

  void _findBestTarget(List<MixinRadarTarget> targets) {
    if (_radarOn) {
      _bestTarget = null;
      _bestDistance = _distScan;
      _checkDistance(targets);
    }
  }

  MixinRadarTarget? _bestTarget;

  void _checkDistance(List<MixinRadarTarget> targets) {
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
      if (distance <= _distScan) {
        switch (_radarMode) {
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
      onRadar(_bestTarget!);
      _bestTarget = null;
    }
  }
}
