import 'package:bonfire/bonfire.dart';
import 'package:logging/logging.dart';

final _log = Logger(Clash.loggerName);

enum ClashMode {
  bestOne,
  clashAll,
}

mixin ClashTarget on PositionComponent {
  // abstract
  onClash(dynamic value);
}

mixin Clash on PositionComponent {
  static const loggerName = 'Clash';
  dynamic effect;
  ClashMode mode = ClashMode.bestOne;
  // abstract
  void clashAlert();
  bool _clashActive = true;
  void disableClash() {
    _clashActive = false;
  }

  void radarScan(Iterable<ClashTarget> targets) {
    if (!_clashActive) return;
    if (targets.isEmpty) return;
    // if (clashAlert == null) return;
    final t = targets.toList();
    switch (mode) {
      case ClashMode.bestOne:
        _onBestOne(t);
      case ClashMode.clashAll:
        _onClashAll(t);
    }
  }

  void _onBestOne(List<ClashTarget> targets) {
    final best = _getBestClash(targets);
    if (best == null) return;
    best.onClash(effect);
    clashAlert();
  }

  void _onClashAll(List<ClashTarget> targets) {
    final founded = _onScan(targets);
    if (founded.isEmpty) return;
    for (var i in founded) {
      i.onClash(effect);
    }

    clashAlert.call();
  }

  ClashTarget? _getBestClash(List<ClashTarget> targets) {
    double? bestDistance;
    ClashTarget? bestTarget;
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      final centerPos = target.position + (target.size / 2);
      final double distance = position.distanceTo(centerPos);
      final collision = target.position.distanceTo(centerPos);
      if (!(distance <= collision)) continue;
      if (bestDistance == null || (distance < bestDistance)) {
        bestTarget = target;
        bestDistance = distance;
      }
    }
    return bestTarget;
  }

  List<ClashTarget> _onScan(List<ClashTarget> targets, [double? maxDistance]) {
    final explosions = <ClashTarget>[];
    for (var i = 0; i < targets.length; i++) {
      final target = targets[i];
      maxDistance ??= target.position.distanceTo(target.position + target.size);
      final pos = target.position;
      final double distance = position.distanceTo(pos);
      if (!(distance <= maxDistance)) continue;
      explosions.add(target);
    }
    return explosions;
  }
}
